
export NDK_HOME=/usr/local/share/android-ndk
export ANDROID_HOME=/opt/android-sdk/
export JAVA_HOME=/nix/store/rflj4qrjp5km8kqfwh2s70s64y4d904v-zulu-ca-jdk-17.0.10/
# export JAVA_HOME=/nix/store/rl72g2cy65l5f5kpqhnaw0a9lh08qfhs-zulu-ca-jdk-21.0.2/
# export JAVA_HOME=/nix/store/kyl9rk74hbqjm3gh1a1kg30dar5r6bl2-zulu-ca-jdk-22.0.0/
export GRADLE_CACHE=$(HOME)/.gradle/caches/modules-2/files-2.1
export CGO_CFLAGS=-I$(JAVA_HOME)/include
export CGO_LDFLAGS=-L$(JAVA_HOME)/lib

#
#On Windows, it maps to PATH
#On Linux, it maps to LD_LIBRARY_PATH
#On OS X, it maps to DYLD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=$(PWD)/jniLibs:$(JAVA_HOME)/lib
export LD_LIBRARY_PATH=$(PWD)/jniLibs

all:


runpcori:
	./gradlew desktopApp:run   --info

bdpc:
	./gradlew desktopApp:build   --info
	ls -lh desktopApp/build/libs/
	ls -lh shared/build/libs/

bdapk:
	./gradlew androidApp:build --info
	ls -lh ./androidApp/build/outputs/apk/debug/androidApp-debug.apk

# android aarch64
golibarm:
	cd src-go && ./buildandroid.sh
	cp -v jniLibs/libfedimuigo.so androidApp/src/androidMain/jniLibs/arm64-v8a/libfedimuigo.so

golibpc:
	cd src-go && CGO_ENABLED=1 go build -tags usejni -buildmode=c-shared -o ../jniLibs/libfedimuigo.dylib
	ls -lh jniLibs

goexepc:
	cd src-go && CGO_ENABLED=1 go build -tags usejni -o ../fedimuigo-exe
	ls -lh fedimuigo-exe
	otool -L ./fedimuigo-exe

# WIP
rungoexepc:
	./fedimuigo-exe

# package all .jar files into go binary
# fuse map virutal dir???
pack:


bdjs:
	./gradlew jsApp:build --info

env:
	./gradlew -v
	# echo $(JAVA_HOME)
	$(JAVA_HOME)/bin/java -version
	#./gradlew --status  


runpc:
	$(JAVA_HOME)/bin/java -Dcompose.application.configure.swing.globals=true -Dcompose.application.resources.dir=$(HOME)/aprog/kmpchat/desktopApp/build/compose/tmp/prepareAppResources -Dfile.encoding=UTF-8 -Duser.country=CN -Duser.language=zh -Duser.variant -cp $(HOME)/aprog/kmpchat/desktopApp/build/libs/desktopApp-jvm.jar:$(HOME)/aprog/kmpchat/shared/build/libs/shared-desktop-1.0-SNAPSHOT.jar:$(GRADLE_CACHE)/org.jetbrains.compose.desktop/desktop-jvm/1.6.10/4c88c77f0770ee2c111199047d90ed5a47e4482b/desktop-jvm-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.skiko/skiko-awt-runtime-macos-x64/0.8.4/aefddcbdabf326a8268ed638a34a60bb2b89f238/skiko-awt-runtime-macos-x64-0.8.4.jar:$(GRADLE_CACHE)/org.jetbrains.compose.material/material-desktop/1.6.10/d3e4b632fadb752973fa898989e4666e986011e6/material-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.components/components-resources-desktop/1.6.10/5320a6943410f5e8484a3140a9a562d716753bc5/library-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.material/material-ripple-desktop/1.6.10/81d8093be11dfbc4ce334bad9bcfc237f21ed701/material-ripple-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.foundation/foundation-desktop/1.6.10/ae2b43abc911ccb6eb335b682ed5f2763939b760/foundation-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.animation/animation-desktop/1.6.10/ce21e9b6dea3019932615f2211ddec7eb4525cd6/animation-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.foundation/foundation-layout-desktop/1.6.10/da4289cf3f4f7b0ee49c7db8bd2f5db09aac6dee/foundation-layout-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.animation/animation-core-desktop/1.6.10/f6404cd973e8dc12994f487a61967aa4f8a949b4/animation-core-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.material/material-icons-core-desktop/1.6.10/47e99680d4e5f234dc4514fd12fec4daf1af4597/material-icons-core-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-desktop/1.6.10/dc5665750f4cc2baaea177774f719fd1ba06f7a5/ui-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-text-desktop/1.6.10/c84eb9f99b8492775cfc57b458a2c113b2139041/ui-text-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-graphics-desktop/1.6.10/9e80f1f2e3104ef38e6e274576c8162bd9854afe/ui-graphics-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.skiko/skiko-awt/0.8.4/d86c3b412d118aa62c8cdf606fc364e2cb4ff1f9/skiko-awt-0.8.4.jar:$(GRADLE_CACHE)/org.jetbrains.kotlinx/kotlinx-datetime-jvm/0.5.0/8882b30187d18d2dcb5e22587447485e6f42dfb3/kotlinx-datetime-jvm-0.5.0.jar:$(GRADLE_CACHE)/org.jetbrains.kotlin/kotlin-stdlib-jdk8/1.9.23/557350a0941ddfe919fd2a30d996355bebc8a3a3/kotlin-stdlib-jdk8-1.9.23.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-tooling-preview-desktop/1.6.10/62232c44c61692b56d3071c29b0f9c8481b20574/ui-tooling-preview-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.androidx.lifecycle/lifecycle-runtime-compose-desktop/2.8.0/4120374fb483acbf8077d5e43ebb74820a565ac1/lifecycle-runtime-compose-desktop-2.8.0.jar:$(GRADLE_CACHE)/org.jetbrains.compose.runtime/runtime-saveable-desktop/1.6.10/74106ad127dea1103cfa5517287147da68694e9f/runtime-saveable-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-unit-desktop/1.6.10/6489dd3c2b6122e1ebba9e9c1081779dc4e125ee/ui-unit-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-geometry-desktop/1.6.10/7eae6ed5c40e7e61eb16c2c7edfbd2019f2c239d/ui-geometry-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.compose.runtime/runtime-desktop/1.6.10/328c18df89b7bf14a52d2d39e20065b029cdfeeb/runtime-desktop-1.6.10.jar:$(GRADLE_CACHE)/androidx.lifecycle/lifecycle-viewmodel-desktop/2.8.0/b7e91a95c8ed79cde23e08651bc34f3d43392f0d/lifecycle-viewmodel-desktop-2.8.0.jar:$(GRADLE_CACHE)/androidx.lifecycle/lifecycle-runtime-desktop/2.8.0/fed8b9973735cbe77645edf153d5f7bb412bfd45/lifecycle-runtime-desktop-2.8.0.jar:$(GRADLE_CACHE)/androidx.lifecycle/lifecycle-common-jvm/2.8.0/7174a594afb73a9ad9ac9074ce78b94af3cc52a7/lifecycle-common-jvm-2.8.0.jar:$(GRADLE_CACHE)/org.jetbrains.kotlinx/kotlinx-coroutines-core-jvm/1.8.0/ac1dc37a30a93150b704022f8d895ee1bd3a36b3/kotlinx-coroutines-core-jvm-1.8.0.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-util-desktop/1.6.10/64039cd04d69b704a0b59a45567d2e4fc9fb0582/ui-util-desktop-1.6.10.jar:$(GRADLE_CACHE)/org.jetbrains.kotlin/kotlin-stdlib-jdk7/1.9.23/b8eca9abec56bee1d01c788e3d571114416ea56d/kotlin-stdlib-jdk7-1.9.23.jar:$(GRADLE_CACHE)/org.jetbrains.kotlinx/atomicfu-jvm/0.23.2/a4601dc42dceb031a586058e8356ff778a57dea0/atomicfu-jvm-0.23.2.jar:$(GRADLE_CACHE)/androidx.collection/collection-jvm/1.4.0/e209fb7bd1183032f55a0408121c6251a81acb49/collection-jvm-1.4.0.jar:$(GRADLE_CACHE)/androidx.arch.core/core-common/2.2.0/5e1b8b81dfd5f52c56a8d53b18ca759c19a301f3/core-common-2.2.0.jar:$(GRADLE_CACHE)/androidx.annotation/annotation-jvm/1.8.0/b8a16fe526014b7941c1debaccaf9c5153692dbb/annotation-jvm-1.8.0.jar:$(GRADLE_CACHE)/org.jetbrains.kotlin/kotlin-stdlib/2.0.0/b48df2c4aede9586cc931ead433bc02d6fd7879e/kotlin-stdlib-2.0.0.jar:$(GRADLE_CACHE)/org.jetbrains/annotations/23.0.0/8cc20c07506ec18e0834947b84a864bfc094484e/annotations-23.0.0.jar  -Xms16m -Xmx128m -XX:-AggressiveHeap MainKt 1