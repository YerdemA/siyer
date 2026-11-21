import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Yükleme anahtarı (Play App Signing): app/android/key.properties, git'e girmez.
// Dosya yoksa release derlemesi debug anahtarıyla imzalanır (yalnız yerel deneme).
val anahtarDosyasi = rootProject.file("key.properties")
val anahtar = Properties().apply {
    if (anahtarDosyasi.exists()) anahtarDosyasi.inputStream().use { load(it) }
}

android {
    namespace = "com.yerdema.siyer"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.yerdema.siyer"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (anahtarDosyasi.exists()) {
            create("yukleme") {
                keyAlias = anahtar.getProperty("keyAlias")
                keyPassword = anahtar.getProperty("keyPassword")
                storeFile = file(anahtar.getProperty("storeFile"))
                storePassword = anahtar.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("yukleme") ?: signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

// Yayın kapısı (CLAUDE.md): doğrulanmamış atıf ya da eksik katman görseli varken
// yayın derlemesi başarısız olur. Uygulamaya paketlenen içerik denetlenir
// (`dart run tools/icerik_esitle.dart` ile kopyalanan app/assets/icerik).
// Paketlenen içerik content/ ile aynı olsun diye denetimden önce eşitlenir.
val icerikEsitle by tasks.registering(Exec::class) {
    group = "build"
    description = "content/ klasörünü app/assets/icerik altına kopyalar (tools/icerik_esitle.dart)."
    workingDir = rootProject.projectDir.parentFile.parentFile
    val dart = listOf("dart", "run", "tools/icerik_esitle.dart")
    commandLine(if (System.getProperty("os.name").startsWith("Windows")) listOf("cmd", "/c") + dart else dart)
}

// Play kapalı testi için: `flutter build appbundle --android-project-arg=kapaliTest=true`.
// Doğrulama bekleyen atıf uyarı olur; diğer bütün yayın kuralları aynen geçerli
// (Erdem, 2026-11-21). Herkese açık yayın bu seçenek olmadan derlenir.
val kapaliTest = (findProperty("kapaliTest") as String?) == "true"

val icerikYayinDenetimi by tasks.registering(Exec::class) {
    dependsOn(icerikEsitle)
    group = "verification"
    description = "İçeriği yayın kurallarıyla denetler (tools/icerik_dogrula.dart --yayin)."
    val depoKoku = rootProject.projectDir.parentFile.parentFile
    workingDir = depoKoku
    val kip = if (kapaliTest) "--kapali-test" else "--yayin"
    val dart = listOf("dart", "run", "tools/icerik_dogrula.dart", kip, "--kok", "app/assets/icerik")
    // Windows'ta dart bir .bat dosyasıdır; doğrudan çalıştırılamaz.
    commandLine(if (System.getProperty("os.name").startsWith("Windows")) listOf("cmd", "/c") + dart else dart)
}

tasks.matching { it.name == "preReleaseBuild" }.configureEach {
    dependsOn(icerikYayinDenetimi)
}
