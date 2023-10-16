# specify the cross compiler
set(CMAKE_SYSTEM_NAME @OS@)
set(CMAKE_SYSTEM_PROCESSOR @CPU@)
set(CMAKE_SYSROOT @PREFIX@/@TRIPLE@/sysroot)
set(CMAKE_C_COMPILER @PREFIX@/bin/@TRIPLE@-gcc)
set(CMAKE_CXX_COMPILER @PREFIX@/bin/@TRIPLE@-g++)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--as-needed -Wl,-dynamic-linker=@DYNAMIC_LINKER@ -Wl,-rpath=@PREFIX@/@TRIPLE@/sysroot/lib:@PREFIX@/@TRIPLE@/sysroot/usr/lib")
# where is the target environment
set (CMAKE_FIND_ROOT_PATH @PREFIX@/@TRIPLE@/sysroot)

set (CMAKE_BUILD_RPATH @PREFIX@/@TRIPLE@/sysroot/usr/lib)

# search for programs in the build host directories
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Make sure Qt can be detected by CMake
set (QT_BINARY_DIR @PREFIX@/@TRIPLE@/sysroot/bin /usr/bin)
set (QT_INCLUDE_DIRS_NO_SYSTEM ON)
set (QT_HOST_PATH /usr CACHE PATH "host path for Qt")

set (PKG_CONFIG_EXECUTABLE @PREFIX@/bin/@TRIPLE@-pkg-config)