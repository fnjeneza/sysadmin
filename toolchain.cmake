# To use this file add -DCMAKE_TOOLCHAIN_FILE=/path/to/this/file

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_C_COMPILER "arm-gnuabihf-gcc/or/path/to/compiler/in/chroot")
set(CMAKE_CXX_COMPILER "arm-gnuabihf-gcc/or/path/to/compiler/in/chroot")

set(CMAKE_FIND_ROOT_PATH "/path/to/chroot/for/example")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
