<picture>
  <source media="(prefers-color-scheme: dark)" srcset="doc/sl-logo-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="doc/sl-logo.png">
  <img alt="Second Life Logo" src="doc/sl-logo.png">
</picture>

**[Second Life][] is a free 3D virtual world where users can create, connect and chat with others from around the
world.** This repository contains a fork of the source code for the official client.

## Open Source

Second Life provides a huge variety of tools for expression, content creation, socialization and play. Its vibrancy is
only possible because of input and contributions from its residents. The client codebase has been open source since
2007 and is available under the LGPL license. The [Open Source Portal][] contains additional information about Linden
Lab's open source history and projects.

## Download

Most people use a pre-built viewer release to access Second Life. Windows and macOS builds are
[published on the official website][download]. More experimental viewers, such as release candidates and
project viewers, are detailed on the [Alternate Viewers page](https://releasenotes.secondlife.com/viewer.html).

### Third Party Viewers

Third party maintained forks, which include Linux compatible builds, are indexed in the [Third Party Viewer Directory][tpv].

## Build Instructions

### Common

```
$ cd viewer
$ git remote add megapahit git://megapahit.org/viewer.git
$ git fetch megapahit
$ git checkout megapahit/main
$ git switch -c megapahit
```

### macOS

```
$ mkdir -p build/universal-apple-darwin`uname -r`
$ cd build/universal-apple-darwin`uname -r`
$ export LL_BUILD="-O3 -gdwarf-2 -stdlib=libc++ -iwithsysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk -std=c++17 -fPIC -DLL_RELEASE=1 -DLL_RELEASE_FOR_DOWNLOAD=1 -DNDEBUG -DPIC -DLL_DARWIN=1"
# port install cmake pkgconfig freealut +universal apr-util +universal boost +universal collada-dom +universal hunspell +universal jsoncpp +universal openjpeg +universal libsdl2 +universal uriparser +universal
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=newview/Megapahit.app/Contents -DCMAKE_OSX_ARCHITECTURES:STRING="arm64;x86_64" -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=OFF ../../indra
$ make -j`gnproc`
$ make install
$ open newview/Megapahit.app
```

### GNU/Linux

```
$ mkdir -p build/`uname -m`-linux-gnu
$ cd build/`uname -m`-linux-gnu
$ export LL_BUILD="-O3 -std=c++17 -fPIC -DLL_LINUX=1"
```

#### Debian 12.5

```
# apt install cmake pkg-config libalut-dev libaprutil1-dev libboost-fiber-dev libboost-program-options-dev libboost-regex-dev libcollada-dom-dev libexpat1-dev libglu1-mesa-dev libgtk2.0-dev libhunspell-dev libjsoncpp-dev libmeshoptimizer-dev libnghttp2-dev libsdl2-dev liburiparser-dev libvlc-dev libvlccore-dev libvorbis-dev libxmlrpc-epi-dev libxxhash-dev
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=ON -DCPACK_PACKAGE_NAME:STRING=megapahit -DCPACK_BINARY_STGZ:BOOL=OFF -DCPACK_BINARY_TGZ:BOOL=OFF -DCPACK_BINARY_TZ:BOOL=OFF -DCPACK_BINARY_DEB:BOOL=ON -DCPACK_DEBIAN_PACKAGE_ARCHITECTURE:STRING=amd64 -DCPACK_DEBIAN_PACKAGE_DESCRIPTION:STRING="A fork of the Second Life viewer" -DCPACK_DEBIAN_PACKAGE_MAINTAINER:STRING=$USER@$HOST -DCPACK_DEBIAN_PACKAGE_SECTION:STRING=net -DCPACK_DEBIAN_PACKAGE_DEPENDES:STRING="libalut0, libaprutil1, libboost-fiber1.74.0 | libboost-fiber1.81.0, libboost-program-options1.74.0 | libboost-program-options1.81.0, libboost-regex1.74.0 | libboost-regex1.81.0, libboost-thread1.74.0 | libboost-thread1.81.0, libcollada-dom2.5-dp0, libexpat1, libgtk2.0-0, libglu1-mesa, libhunspell-1.7-0, libjsoncpp25, libmeshoptimizer2d (>= 0.18), libnghttp2-14, libsdl2-2.0-0, liburiparser1, libvlc5, libvorbisenc2, libvorbisfile3, libxmlrpc-epi0, vlc-plugin-base" ../../indra
$ cmake ../../indra
$ make -j`nproc`
$ cpack -G DEB
# apt install megapahit-`cat newview/viewer_version.txt`-Linux.deb
$ megapahit
```

#### Ubuntu 24.04

```
# apt install cmake pkg-config libalut-dev libaprutil1-dev libboost-fiber-dev libboost-program-options-dev libboost-regex-dev libcollada-dom-dev libexpat1-dev libglu1-mesa-dev libgtk2.0-dev libhunspell-dev libjsoncpp-dev libmeshoptimizer-dev libnanosvg-dev libnghttp2-dev libsdl2-dev liburiparser-dev libvlc-dev libvlccore-dev libvorbis-dev libxmlrpc-epi-dev libxxhash-dev
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=ON -DCPACK_PACKAGE_NAME:STRING=megapahit -DCPACK_BINARY_STGZ:BOOL=OFF -DCPACK_BINARY_TGZ:BOOL=OFF -DCPACK_BINARY_TZ:BOOL=OFF -DCPACK_BINARY_DEB:BOOL=ON -DCPACK_DEBIAN_PACKAGE_ARCHITECTURE:STRING=amd64 -DCPACK_DEBIAN_PACKAGE_DESCRIPTION:STRING="A fork of the Second Life viewer" -DCPACK_DEBIAN_PACKAGE_MAINTAINER:STRING=$USER@$HOST -DCPACK_DEBIAN_PACKAGE_SECTION:STRING=net -DCPACK_DEBIAN_PACKAGE_DEPENDES:STRING="libalut0, libaprutil1t64, libboost-fiber1.83.0, libboost-program-options1.83.0, libboost-regex1.83.0, libboost-thread1.83.0, libcollada-dom2.5-dp0, libexpat1, libgtk2.0-0t64, libglu1-mesa, libhunspell-1.7-0, libjsoncpp25, libmeshoptimizer2d, libnghttp2-14, libsdl2-2.0-0, liburiparser1, libvlc5, libvorbisenc2, libvorbisfile3, libxmlrpc-epi0t64, vlc-plugin-base" ../../indra
$ cmake ../../indra
$ make -j`nproc`
$ cpack -G DEB
# apt install megapahit-`cat newview/viewer_version.txt`-Linux.deb
$ megapahit
```

#### Fedora

```
# dnf install cmake gcc-c++ freealut-devel apr-util-devel boost-devel collada-dom-devel expat-devel mesa-libGLU-devel gtk2-devel hunspell-devel jsoncpp-devel libnghttp2-devel nanosvg-devel openjpeg2-devel SDL2-devel uriparser-devel vlc-devel libvorbis-devel xmlrpc-epi-devel xxhash-devel zstd
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=ON -DCPACK_PACKAGE_NAME:STRING=megapahit -DCPACK_BINARY_STGZ:BOOL=OFF -DCPACK_BINARY_TGZ:BOOL=OFF -DCPACK_BINARY_TZ:BOOL=OFF -DCPACK_BINARY_RPM:BOOL=ON -DCPACK_RPM_PACKAGE_SUMMARY:STRING="A fork of the Second Life viewer" -DCPACK_RPM_PACKAGE_ARCHITECTURE:STRING=`uname -m` -DCPACK_RPM_PACKAGE_LICENSE:STRING=LGPL-2.1-only -DCPACK_RPM_PACKAGE_VENDOR:STRING=Megapahit -DCPACK_RPM_PACKAGE_URL:STRING=https://megapahit.net -DCPACK_RPM_PACKAGE_DESCRIPTION:STRING="An entrance to virtual empires in only megabytes. A shelter for the metaverse refugess, especially those from less supported operating systems." -DCPACK_RPM_PACKAGE_REQUIRES:STRING="freealut, apr-util, boost-fiber, boost-program-options, boost-regex, boost-thread, collada-dom, expat, mesa-libGLU, gtk2, hunspell, jsoncpp, libnghttp2, openjpeg2, SDL2, uriparser, vlc-libs, vlc-plugins-base, libvorbis, xmlrpc-epi" ../../indra
$ cmake ../../indra
$ make -j`nproc`
$ cpack -G RPM
# rpm -i megapahit-`cat newview/viewer_version.txt`-Linux.rpm
$ megapahit
```

### FreeBSD

```
$ mkdir -p build/`uname -m`-unknown-freebsd14.1
$ cd build/`uname -m`-unknown-freebsd14.1
$ setenv LL_BUILD "-O3 -std=c++17 -fPIC"
# portmaster devel/cmake devel/pkgconf audio/freealut devel/apr1 devel/collada-dom textproc/hunspell x11-toolkits/gtk20 misc/meshoptimizer graphics/nanosvg graphics/openjpeg devel/sdl20 net/uriparser multimedia/vlc audio/libvorbis net/xmlrpc-epi devel/xxhash
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=ON -DCPACK_PACKAGE_NAME:STRING=megapahit -DCPACK_BINARY_STGZ:BOOL=OFF -DCPACK_BINARY_TGZ:BOOL=OFF -DCPACK_BINARY_TZ:BOOL=OFF -DCPACK_BINARY_FREEBSD:BOOL=ON -DCPACK_FREEBSD_PACKAGE_COMMENT:STRING="A fork of the Second Life viewer" -DCPACK_FREEBSD_PACKAGE_DESCRIPTION:STRING="An entrance to virtual empires in only megabytes. A shelter for the metaverse refugess, especially those from less supported operating systems." -DCPACK_FREEBSD_PACKAGE_WWW:STRING=https://megapahit.net -DCPACK_FREEBSD_PACKAGE_LICENSE:STRING=LGPL21 -DCPACK_FREEBSD_PACKAGE_MAINTAINER:STRING=$USER@$HOST -DCPACK_FREEBSD_PACKAGE_ORIGIN:STRING=net/megapahit -DCPACK_FREEBSD_PACKAGE_DEPS:STRING="audio/freealut;devel/collada-dom;graphics/libGLU;textproc/hunspell;misc/meshoptimizer;www/libnghttp2;graphics/openjpeg;net/uriparser;multimedia/vlc;audio/libvorbis;net/xmlrpc-epi" ../../indra
$ cmake ../../indra
$ make -j`nproc`
# cpack -G FREEBSD
# pkg add megapahit-`cat newview/viewer_version.txt`-FreeBSD.pkg
$ megapahit
```

## Contribute

Help make Second Life better! You can get involved with improvements by filing bugs, suggesting enhancements, submitting
pull requests and more. See the [CONTRIBUTING][] and the [open source portal][] for details.

[Second Life]: https://secondlife.com/
[download]: https://secondlife.com/support/downloads/
[tpv]: http://wiki.secondlife.com/wiki/Third_Party_Viewer_Directory
[open source portal]: http://wiki.secondlife.com/wiki/Open_Source_Portal
[contributing]: https://github.com/secondlife/viewer/blob/main/CONTRIBUTING.md
