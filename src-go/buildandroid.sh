set -e fail

# 
# cat /usr/local/bin/ndk-build
# cat `which ndk-build`

NDKDIR=/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK//toolchains/llvm/prebuilt/darwin-x86_64

export CGO_CFLAGS="-I/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK//toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/include -I/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK//toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/include/arm-linux-androideabi"


# export CC=/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK//toolchains/llvm/prebuilt/darwin-x86_64/bin/armv7a-linux-androideabi21-clang
export CC=/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK//toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android21-clang
RUSTUP_TOOLCHAIN=$CC

# export CC=/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK//toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android21-clang

# export LD=/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK//toolchains/llvm/prebuilt/darwin-x86_64/bin/ld

#GOOS=android  GOARCH=arm64  CGO_LDFLAGS="-arch arm64" CGO_ENABLED=1 go build -buildmode=c-shared -o ../fedimuigo.so
GOOS=android  GOARCH=arm64  CGO_CFLAGS="-arch arm64" CGO_LDFLAGS="-arch arm64" CGO_ENABLED=1 go build -buildmode=c-shared -o ../jniLibs/libfedimuigo.so
# GOOS=android GOARCH=arm64 CGO_ENABLED=1 go build -v -x -buildmode=c-shared
# otool -L ../libfedimuirs.so | grep my_project
$NDKDIR/bin/llvm-objdump -x ../libfedimuigo.so |grep NEEDED
