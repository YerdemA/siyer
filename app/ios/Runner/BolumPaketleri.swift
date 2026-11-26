import BackgroundAssets
import Flutter
import Foundation
import System

/// Bölüm paketleri (Apple'da barındırılan Background Assets, isteğe bağlı)
/// için Dart köprüsü. Android'deki `BolumPaketleri.kt` ile aynı kanal ve aynı
/// yanıtlar; Dart tarafı: lib/icerik/paketler.dart.
///
/// Her yanıt bir durum haritasıdır:
/// `{ad, durum: hazir|yok|iniyor|hata, inen, toplam, yol?, hata?}`.
/// `yol`, paketin içindeki `<ad>/` klasörüdür; dosyalar oraya
/// `assets/icerik/` altındaki yollarıyla yerleşir.
///
/// iOS bütün paketleri tek ad alanında birleştirir. Bu yüzden her paketin
/// dosyaları `<ad>/` önekiyle durur ve klasör `<ad>/paket.json` işaretinden
/// bulunur (tools/icerik_esitle.dart yazar). Paketleri indiren sistem
/// eklentisi: ios/Indirici/Indirici.swift.
final class BolumPaketleri: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var olaylar: FlutterEventSink?

  /// Süren indirmeler; aynı paket için ikinci istek ilkine katılır.
  private var suren: [String: Task<Void, Never>] = [:]

  static func register(with registrar: FlutterPluginRegistrar) {
    let ornek = BolumPaketleri()
    FlutterMethodChannel(name: "siyer/paketler", binaryMessenger: registrar.messenger())
      .setMethodCallHandler(ornek.handle)
    FlutterEventChannel(name: "siyer/paketler/olay", binaryMessenger: registrar.messenger())
      .setStreamHandler(ornek)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let ad = (call.arguments as? [String: Any])?["ad"] as? String
    guard let ad, ad.range(of: "^[a-z][a-z0-9_]*$", options: .regularExpression) != nil else {
      result(FlutterError(code: "ad", message: "Geçersiz paket adı: \(ad ?? "nil")", details: nil))
      return
    }
    switch call.method {
    case "durum": Task { @MainActor in self.yanitla(result, await self.durum(ad)) }
    case "indir": Task { @MainActor in self.yanitla(result, await self.indir(ad)) }
    case "sil": Task { @MainActor in self.yanitla(result, await self.sil(ad)) }
    default: result(FlutterMethodNotImplemented)
    }
  }

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    olaylar = events
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    olaylar = nil
    return nil
  }

  // MARK: - İşlemler

  // Durum (`suren`, `olaylar`) yalnız ana iş parçacığında değişir.
  @MainActor private func durum(_ ad: String) async -> [String: Any?] {
    if let yol = await konum(ad) { return hazir(ad, yol) }
    if suren[ad] != nil { return ["ad": ad, "durum": "iniyor"] }
    return yok(ad)
  }

  @MainActor private func indir(_ ad: String) async -> [String: Any?] {
    if let yol = await konum(ad) { return hazir(ad, yol) }
    if suren[ad] == nil {
      suren[ad] = Task { @MainActor in await self.indirmeyiYurut(ad) }
    }
    return ["ad": ad, "durum": "iniyor"]
  }

  /// İndirir; ilerlemeyi ve sonucu olay kanalından bildirir.
  @MainActor private func indirmeyiYurut(_ ad: String) async {
    let izleyici = Task { @MainActor in
      for await d in AssetPackManager.shared.statusUpdates(forAssetPackWithID: ad) {
        if case .downloading(_, let ilerleme) = d {
          self.bildir([
            "ad": ad, "durum": "iniyor",
            "inen": ilerleme.completedUnitCount, "toplam": ilerleme.totalUnitCount,
          ])
        }
      }
    }
    defer { izleyici.cancel() }

    let sonuc: [String: Any?]
    do {
      let paket = try await AssetPackManager.shared.assetPack(withID: ad)
      if #available(iOS 26.4, *) {
        try await AssetPackManager.shared.ensureLocalAvailability(of: paket, requireLatestVersion: false)
      } else {
        try await AssetPackManager.shared.ensureLocalAvailability(of: paket)
      }
      if let yol = await konum(ad) {
        sonuc = hazir(ad, yol)
      } else {
        sonuc = hata(ad, "Paket indi ama klasörü bulunamadı.")
      }
    } catch {
      sonuc = hata(ad, error.localizedDescription)
    }
    suren[ad] = nil
    bildir(sonuc)
  }

  @MainActor private func sil(_ ad: String) async -> [String: Any?] {
    suren[ad]?.cancel()
    suren[ad] = nil
    // İnmemiş pakette silinecek bir şey yoktur; hata da "yok" sayılır.
    try? await AssetPackManager.shared.remove(assetPackWithID: ad)
    return yok(ad)
  }

  /// İnmiş paketin `<ad>/` klasörü; yoksa nil. `url(for:)` ana iş parçacığında
  /// takılabildiği için ayrı görevde çağrılır.
  private func konum(_ ad: String) async -> String? {
    await Task.detached { () -> String? in
      guard let isaret = try? AssetPackManager.shared.url(for: FilePath("\(ad)/paket.json")),
        FileManager.default.fileExists(atPath: isaret.path)
      else { return nil }
      return isaret.deletingLastPathComponent().path
    }.value
  }

  // MARK: - Yanıtlar

  @MainActor private func yanitla(_ result: @escaping FlutterResult, _ cevap: [String: Any?]) {
    result(cevap.compactMapValues { $0 })
  }

  @MainActor private func bildir(_ cevap: [String: Any?]) {
    olaylar?(cevap.compactMapValues { $0 })
  }

  private func hazir(_ ad: String, _ yol: String) -> [String: Any?] { ["ad": ad, "durum": "hazir", "yol": yol] }
  private func yok(_ ad: String) -> [String: Any?] { ["ad": ad, "durum": "yok"] }
  private func hata(_ ad: String, _ mesaj: String?) -> [String: Any?] { ["ad": ad, "durum": "hata", "hata": mesaj] }
}
