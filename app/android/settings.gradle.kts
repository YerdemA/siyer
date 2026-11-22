pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.1.0" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}

include(":app")

// Bölüm paketleri (Play Asset Delivery); tools/icerik_esitle.dart üretir.
file("paketler").listFiles()
    ?.filter { File(it, "build.gradle.kts").exists() }
    ?.sortedBy { it.name }
    ?.forEach {
        include(":${it.name}")
        project(":${it.name}").projectDir = it
    }
