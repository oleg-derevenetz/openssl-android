#!/bin/sh

OPENSSL=openssl-1.0.2s

ANDROID_NDK_ROOT=~/android-ndk-r10e; export ANDROID_NDK_ROOT

BUILD_ARCH=armeabi-v7a

. ./Setenv-android-arm.sh

mkdir -p $BUILD_ARCH && cd $BUILD_ARCH && tar -xzf ../$OPENSSL.tar.gz && cd $OPENSSL && ./Configure shared android && make CALC_VERSIONS="SHLIB_COMPAT=; SHLIB_SOVER=" && cd ../..

if [[ $? -ne 0 ]]; then
    exit $?
fi

BUILD_ARCH=arm64-v8a

. ./Setenv-android-arm64.sh

mkdir -p $BUILD_ARCH && cd $BUILD_ARCH && tar -xzf ../$OPENSSL.tar.gz && cd $OPENSSL && ./Configure shared android && make CALC_VERSIONS="SHLIB_COMPAT=; SHLIB_SOVER=" && cd ../..

if [[ $? -ne 0 ]]; then
    exit $?
fi
