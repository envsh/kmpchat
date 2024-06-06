
export NDK_HOME=/usr/local/share/android-ndk
export ANDROID_HOME=/opt/android-sdk/
export JAVA_HOME=/nix/store/rflj4qrjp5km8kqfwh2s70s64y4d904v-zulu-ca-jdk-17.0.10/
export GRADLE_CACHE=$(HOME)/.gradle/caches/modules-2/files-2.1

#
#On Windows, it maps to PATH
#On Linux, it maps to LD_LIBRARY_PATH
#On OS X, it maps to DYLD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=$(PWD)/jniLibs
export LD_LIBRARY_PATH=$(PWD)/jniLibs

all:


runpcori:
	./gradlew desktopApp:run   --info

bdpc:
	./gradlew desktopApp:build   --info

bdapk:
	./gradlew androidApp:build --info
	ls -lh ./androidApp/build/outputs/apk/debug/androidApp-debug.apk

# android aarch64
golibarm:
	cd src-go && ./buildandroid.sh
	cp -v jniLibs/libfedimuigo.so androidApp/src/androidMain/jniLibs/arm64-v8a/libfedimuigo.so

golibx86:
	cd src-go && CGO_ENABLED=1 go build -buildmode=c-shared -o ../jniLibs/libfedimuigo.dylib
	ls -lh jniLibs


env:
	./gradlew -v
	# echo $(JAVA_HOME)
	$(JAVA_HOME)/zulu-17.jdk/Contents/Home/bin/java -version
	#./gradlew --status  


runpc:
	$(JAVA_HOME)/zulu-17.jdk/Contents/Home/bin/java -Dcompose.application.configure.swing.globals=true -Dcompose.application.resources.dir=$(HOME)/aprog/kmpchat/desktopApp/build/compose/tmp/prepareAppResources -Dfile.encoding=UTF-8 -Duser.country=CN -Duser.language=zh -Duser.variant -cp "$(HOME)/aprog/kmpchat/desktopApp/build/libs/desktopApp-jvm.jar:$(HOME)/aprog/kmpchat/shared/build/libs/shared-desktop-1.0-SNAPSHOT.jar:$(GRADLE_CACHE)/org.jetbrains.compose.desktop/desktop-jvm/1.6.2/4c88c77f0770ee2c111199047d90ed5a47e4482b/desktop-jvm-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.skiko/skiko-awt-runtime-macos-x64/0.7.97/fc1bda4a577e8947aed7235bbb42d264c8eff80b/skiko-awt-runtime-macos-x64-0.7.97.jar:$(GRADLE_CACHE)/org.jetbrains.compose.material/material-desktop/1.6.2/8aba1d1e6fb631404f8e227b8da35a7599add83/material-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.components/components-resources-desktop/1.6.2/443021e9e9431698e8b4ffc498a52af32d204c42/library-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.material/material-ripple-desktop/1.6.2/211b0740ee3291b32ee3ed9dc224f8b526fe5923/material-ripple-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.foundation/foundation-desktop/1.6.2/a7bcfc60bba62b142ce6b909ad3d0d24e702bfa7/foundation-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.animation/animation-desktop/1.6.2/e0e0918c035bd28c2cf3a02c2ebc092880d38a43/animation-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.foundation/foundation-layout-desktop/1.6.2/9d639e56f127b36e0a2889af30b534ef713717d5/foundation-layout-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.animation/animation-core-desktop/1.6.2/3c6651ae9363fcb4a80dcdd564b2ae2e6ead54e5/animation-core-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.material/material-icons-core-desktop/1.6.2/47e99680d4e5f234dc4514fd12fec4daf1af4597/material-icons-core-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-desktop/1.6.2/730db799d647eaa0e433a2e013319e24e8d017cc/ui-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-text-desktop/1.6.2/ce3a7f60351c781cd0afe9c965d88862dfae59cd/ui-text-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-graphics-desktop/1.6.2/9e80f1f2e3104ef38e6e274576c8162bd9854afe/ui-graphics-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.skiko/skiko-awt/0.7.97/90aad197125592a9a8f1b1da8fbd6e915059a0af/skiko-awt-0.7.97.jar:$(GRADLE_CACHE)/org.jetbrains.kotlinx/kotlinx-datetime-jvm/0.5.0/8882b30187d18d2dcb5e22587447485e6f42dfb3/kotlinx-datetime-jvm-0.5.0.jar:$(GRADLE_CACHE)/org.jetbrains.kotlin/kotlin-stdlib-jdk8/1.9.23/557350a0941ddfe919fd2a30d996355bebc8a3a3/kotlin-stdlib-jdk8-1.9.23.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-tooling-preview-desktop/1.6.2/62232c44c61692b56d3071c29b0f9c8481b20574/ui-tooling-preview-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.runtime/runtime-saveable-desktop/1.6.2/1b72e4ff3c9e4940a90001c93a3108725e90dc34/runtime-saveable-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-unit-desktop/1.6.2/6489dd3c2b6122e1ebba9e9c1081779dc4e125ee/ui-unit-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-geometry-desktop/1.6.2/7eae6ed5c40e7e61eb16c2c7edfbd2019f2c239d/ui-geometry-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.compose.runtime/runtime-desktop/1.6.2/e6e94c1b03655b3635528d9b96c872e6b191413/runtime-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.kotlinx/kotlinx-coroutines-core-jvm/1.8.0/ac1dc37a30a93150b704022f8d895ee1bd3a36b3/kotlinx-coroutines-core-jvm-1.8.0.jar:$(GRADLE_CACHE)/org.jetbrains.compose.ui/ui-util-desktop/1.6.2/18d22abacf8b0224d12548b03352c810b71a6f42/ui-util-desktop-1.6.2.jar:$(GRADLE_CACHE)/org.jetbrains.kotlin/kotlin-stdlib-jdk7/1.9.23/b8eca9abec56bee1d01c788e3d571114416ea56d/kotlin-stdlib-jdk7-1.9.23.jar:$(GRADLE_CACHE)/org.jetbrains.kotlinx/atomicfu-jvm/0.23.2/a4601dc42dceb031a586058e8356ff778a57dea0/atomicfu-jvm-0.23.2.jar:$(GRADLE_CACHE)/androidx.collection/collection-jvm/1.4.0/e209fb7bd1183032f55a0408121c6251a81acb49/collection-jvm-1.4.0.jar:$(GRADLE_CACHE)/androidx.annotation/annotation-jvm/1.7.1/920472d40adcdef5e18708976b3e314f9a636fcd/annotation-jvm-1.7.1.jar:$(GRADLE_CACHE)/org.jetbrains.kotlin/kotlin-stdlib/1.9.23/dbaadea1f5e68f790d242a91a38355a83ec38747/kotlin-stdlib-1.9.23.jar:$(GRADLE_CACHE)/org.jetbrains/annotations/23.0.0/8cc20c07506ec18e0834947b84a864bfc094484e/annotations-23.0.0.jar" -Xms16m -Xmx128m -XX:-AggressiveHeap MainKt 1