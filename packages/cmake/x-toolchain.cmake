# specify the cross compiler
set(CMAKE_SYSTEM_NAME @OS@)
set(CMAKE_SYSTEM_PROCESSOR @CPU@)
set(CMAKE_SYSROOT @PREFIX@/@TRIPLE@/sysroot)
set(CMAKE_C_COMPILER @PREFIX@/bin/@TRIPLE@-gcc)
set(CMAKE_CXX_COMPILER @PREFIX@/bin/@TRIPLE@-g++)

# where is the target environment
# set (CMAKE_FIND_ROOT_PATH @PREFIX@/@TRIPLE@/sysroot)

# search for programs in the build host directories
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
# for libraries and headers in the target directories
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Make sure Qt can be detected by CMake
set (QT_BINARY_DIR @PREFIX@/bin /usr/bin)
set (QT_INCLUDE_DIRS_NO_SYSTEM ON)

set (PKG_CONFIG_EXECUTABLE @PREFIX@/bin/@TRIPLE@-pkg-config)