plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
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
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
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

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
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
val icerikYayinDenetimi by tasks.registering(Exec::class) {
    group = "verification"
    description = "İçeriği yayın kurallarıyla denetler (tools/icerik_dogrula.dart --yayin)."
    val depoKoku = rootProject.projectDir.parentFile.parentFile
    workingDir = depoKoku
    val dart = listOf("dart", "run", "tools/icerik_dogrula.dart", "--yayin", "--kok", "app/assets/icerik")
    // Windows'ta dart bir .bat dosyasıdır; doğrudan çalıştırılamaz.
    commandLine(if (System.getProperty("os.name").startsWith("Windows")) listOf("cmd", "/c") + dart else dart)
}

tasks.matching { it.name == "preReleaseBuild" }.configureEach {
    dependsOn(icerikYayinDenetimi)
}
