cmake_minimum_required(VERSION 3.5)


project("sample")

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif(CCACHE_FOUND)

# name of the executable
set(bin_name "sample")
set(static_lib "sample")
set(shared_lib "sample")

add_executable(${bin_name} src/main.cpp)
add_library(${static_lib} src/main.cpp)
add_library(${shared_lib} src/main.cpp)

install(TARGETS ${bin_name} ${shared_lib} ${static_lib}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)
include_directories(SYSTEM "")

add_compile_options(
    "-std=c++14;-Wall;-Wpedantic;-Wextra;-Winline;-Wshadow;-Wuseless-cast"
)
target_compile_options(
    ${bin_name} PUBLIC
    "-Wmissing-include-dirs;-Wduplicated-cond;-Wfloat-equal;-Wlogical-op"
    "-Wmissing-declarations;-Wsuggest-override;-Wconversion;-Wredundant-decls"
    "-Wpadded;-Wnon-virtual-dtor;-Wold-style-cast;-Wcast-align;-Woverloaded-virtual"
    "-Wsign-conversion;-Wctor-dtor-privacy;-Weffc++"
    "-Werror"
    "-fdiagnostics-color=always"
    )

#optimization
target_compile_options(
   ${bin_name} PUBLIC
   "-Wstack-protector;-fstack-protector"
   )
target_compile_definitions(${bin_name} PUBLIC "")


# 'src' contains both .h and .cpp
target_sources(${bin_name} PUBLIC src/test.cpp)
target_include_directories(${bin_name} PUBLIC src)

find_library(PROTOBUF_LIB NAMES protobuf)
target_link_libraries(${bin_name} PUBLIC ${PROTOBUF_LIB})
