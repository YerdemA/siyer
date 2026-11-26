import BackgroundAssets
import ExtensionFoundation
import StoreKit

/// Bölüm paketlerini (Apple'da barındırılan Background Assets) indiren sistem
/// eklentisi. Ne zaman ne indirileceğine uygulama karar verir
/// (Runner/BolumPaketleri.swift); paketler isteğe bağlı (`onDemand`) olduğu
/// için varsayılan davranış yeter.
@main
struct Indirici: StoreDownloaderExtension {}
