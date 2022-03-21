#!/bin/bash

mkdir -p build
pushd build

cmake \
 -DCMAKE_INSTALL_PREFIX="install" \
 -DCMAKE_BUILD_TYPE="Release" \
 -DDCMTK_ENABLE_PRIVATE_TAGS="ON" \
 -DDCMTK_ENABLE_STL="ON" \
 .. && \
 make -j16
 