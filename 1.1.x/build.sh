#!/bin/sh

OPENSSL=openssl-1.1.1s
HOST_PLATFORM=darwin-x86_64

export ANDROID_NDK_HOME=~/android-ndk-r21

PATH_ORIG="$PATH"

BUILD_ARCH=armeabi-v7a

export PATH="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$HOST_PLATFORM/arm-linux-androideabi/bin:$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$HOST_PLATFORM/bin:$PATH_ORIG"

mkdir -p "$BUILD_ARCH" && cd "$BUILD_ARCH" && tar -xzf "../$OPENSSL.tar.gz" && cd "$OPENSSL" && \
./Configure android-arm --target=armv7a-linux-androideabi -Wl,--fix-cortex-a8 -fPIC -D__ANDROID_API__=16 && \
make SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so && cd ../..

if [[ $? -ne 0 ]]; then
    exit $?
fi

BUILD_ARCH=arm64-v8a

export PATH="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$HOST_PLATFORM/aarch64-linux-android/bin:$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$HOST_PLATFORM/bin:$PATH_ORIG"

mkdir -p "$BUILD_ARCH" && cd "$BUILD_ARCH" && tar -xzf "../$OPENSSL.tar.gz" && cd "$OPENSSL" && \
./Configure android-arm64 -fPIC -D__ANDROID_API__=21 && \
make SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so && cd ../..

if [[ $? -ne 0 ]]; then
    exit $?
fi
