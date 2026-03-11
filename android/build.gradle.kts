allprojects {
    repositories {
        google()
        mavenCentral()
    }

    // Force stable, AGP-compatible versions of bleeding-edge androidx transitive deps
    // Also pin Kotlin stdlib to match the Kotlin plugin version (2.2.20) declared in settings.gradle.kts
    configurations.all {
        resolutionStrategy {
            force("androidx.activity:activity:1.9.3")
            force("androidx.activity:activity-ktx:1.9.3")
            force("androidx.core:core:1.15.0")
            force("androidx.core:core-ktx:1.15.0")
            force("org.jetbrains.kotlin:kotlin-stdlib:2.2.20")
            force("org.jetbrains.kotlin:kotlin-stdlib-jdk7:2.2.20")
            force("org.jetbrains.kotlin:kotlin-stdlib-jdk8:2.2.20")
        }
    }
}

// Fix for isar_flutter_libs incompatibility with AGP 8+
// 1. Injects the missing namespace declaration
// 2. Bumps compileSdk from 30 -> 35 (lStar attr requires API 31+)
// 3. Strips the legacy package= attribute from AndroidManifest.xml before AGP processes it
subprojects {
    afterEvaluate {
        if (project.name == "isar_flutter_libs") {
            extensions.findByType<com.android.build.gradle.LibraryExtension>()?.apply {
                namespace = "dev.isar.isar_flutter_libs"
                compileSdk = 35
            }
            tasks.matching { task ->
                task.name.startsWith("process") && task.name.contains("Manifest")
            }.configureEach {
                doFirst {
                    val manifestFile = file("src/main/AndroidManifest.xml")
                    if (manifestFile.exists()) {
                        val original = manifestFile.readText()
                        val patched = original.replace(Regex("""package="[^"]*"\s*"""), "")
                        if (original != patched) {
                            manifestFile.writeText(patched)
                            logger.lifecycle("Patched isar_flutter_libs AndroidManifest.xml: removed legacy package= attribute")
                        }
                    }
                }
            }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
