# -*- cmake -*-

include_guard()

# FMODSTUDIO can be set when launching the make using the argument -DUSE_FMODSTUDIO:BOOL=ON
# When building using proprietary binaries though (i.e. having access to LL private servers),
# we always build with FMODSTUDIO.
if (INSTALL_PROPRIETARY)
  set(USE_FMODSTUDIO ON CACHE BOOL "Using FMODSTUDIO sound library.")
endif (INSTALL_PROPRIETARY)

# ND: To streamline arguments passed, switch from FMODSTUDIO to USE_FMODSTUDIO
# To not break all old build scripts convert old arguments but warn about it
if(FMODSTUDIO)
  message( WARNING "Use of the FMODSTUDIO argument is deprecated, please switch to USE_FMODSTUDIO")
  set(USE_FMODSTUDIO ${FMODSTUDIO})
endif()

if (USE_FMODSTUDIO)
  add_library( ll::fmodstudio INTERFACE IMPORTED )
  target_compile_definitions( ll::fmodstudio INTERFACE LL_FMODSTUDIO=1)

  if (FMODSTUDIO_LIBRARY AND FMODSTUDIO_INCLUDE_DIR)
    # If the path have been specified in the arguments, use that

    target_link_libraries(ll::fmodstudio INTERFACE ${FMODSTUDIO_LIBRARY})
    target_include_directories( ll::fmodstudio SYSTEM INTERFACE  ${FMODSTUDIO_INCLUDE_DIR})
  else (FMODSTUDIO_LIBRARY AND FMODSTUDIO_INCLUDE_DIR)
    # If not, we're going to try to get the package listed in autobuild.xml
    # Note: if you're not using INSTALL_PROPRIETARY, the package URL should be local (file:/// URL)
    # as accessing the private LL location will fail if you don't have the credential
    include(Prebuilt)
    if (USESYSTEMLIBS)
      if (DARWIN)
        execute_process(
          COMMAND hdiutil attach -noverify $ENV{HOME}/Downloads/fmodstudioapi20223mac-installer.dmg
          COMMAND mkdir -p
            include/fmodstudio
            lib/release
          WORKING_DIRECTORY ${AUTOBUILD_INSTALL_DIR}
          )
        execute_process(
          COMMAND cp
            inc/fmod.h
            inc/fmod.hpp
            inc/fmod_codec.h
            inc/fmod_common.h
            inc/fmod_dsp.h
            inc/fmod_dsp_effects.h
            inc/fmod_errors.h
            inc/fmod_output.h
            ${AUTOBUILD_INSTALL_DIR}/include/fmodstudio/
          COMMAND lipo
            lib/libfmod.dylib
            -thin ${CMAKE_OSX_ARCHITECTURES}
            -output ${AUTOBUILD_INSTALL_DIR}/lib/release/libfmod.dylib
          WORKING_DIRECTORY /Volumes/FMOD\ Programmers\ API\ Mac/FMOD\ Programmers\ API/api/core
          )
        execute_process(
          COMMAND hdiutil detach FMOD\ Programmers\ API\ Mac
          WORKING_DIRECTORY /Volumes
          RESULT_VARIABLE fmodstudio_installed
          )
      else (DARWIN)
        execute_process(
          COMMAND mkdir -p ${AUTOBUILD_INSTALL_DIR}/include/fmodstudio
          COMMAND tar -xf $ENV{HOME}/Downloads/fmodstudioapi20223linux.tar.gz
          WORKING_DIRECTORY /tmp
          )
        execute_process(
          COMMAND cp
            inc/fmod.h
            inc/fmod.hpp
            inc/fmod_codec.h
            inc/fmod_common.h
            inc/fmod_dsp.h
            inc/fmod_dsp_effects.h
            inc/fmod_errors.h
            inc/fmod_output.h
            ${AUTOBUILD_INSTALL_DIR}/include/fmodstudio/
          COMMAND cp -P
            lib/${CMAKE_SYSTEM_PROCESSOR}/libfmod.so
            lib/${CMAKE_SYSTEM_PROCESSOR}/libfmod.so.13
            lib/${CMAKE_SYSTEM_PROCESSOR}/libfmod.so.13.23
            ${AUTOBUILD_INSTALL_DIR}/lib/release/
          WORKING_DIRECTORY /tmp/fmodstudioapi20223linux/api/core
          )
        execute_process(
          COMMAND rm -rf fmodstudioapi20223linux
          WORKING_DIRECTORY /tmp
          RESULT_VARIABLE fmodstudio_installed
          )
      endif (DARWIN)
      file(WRITE ${PREBUILD_TRACKING_DIR}/fmodstudio_installed "${fmodstudio_installed}")
    else (USESYSTEMLIBS)
    use_prebuilt_binary(fmodstudio)
    endif (USESYSTEMLIBS)
    if (WINDOWS)
      target_link_libraries( ll::fmodstudio INTERFACE  fmod_vc)
    elseif (DARWIN)
      #despite files being called libfmod.dylib, we are searching for fmod
      target_link_libraries( ll::fmodstudio INTERFACE  fmod)
    elseif (LINUX)
      target_link_libraries( ll::fmodstudio INTERFACE  fmod)
    endif (WINDOWS)

    target_include_directories( ll::fmodstudio SYSTEM INTERFACE ${LIBS_PREBUILT_DIR}/include/fmodstudio)
  endif (FMODSTUDIO_LIBRARY AND FMODSTUDIO_INCLUDE_DIR)
else()
  set( USE_FMODSTUDIO "OFF")
endif ()

