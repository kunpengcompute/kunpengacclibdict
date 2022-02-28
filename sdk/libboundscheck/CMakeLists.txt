cmake_minimum_required (VERSION 2.8)
project (boundscheck)

# Add source files
aux_source_directory(src DIR_SRCS)

# Add header file include directories
include_directories(${PROJECT_SOURCE_DIR}/include)

# Set compile options
set(CMAKE_BOUNDSCHECK_FLAGS "-Wall -DNDEBUG -O2 -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -O2 -Wformat=2 -Wfloat-equal -Wshadow")
set(CMAKE_BOUNDSCHECK_FLAGS "${CMAKE_BOUNDSCHECK_FLAGS} -Wconversion -Wformat-security -Wextra --param ssp-buffer-size=4 -Warray-bounds -Wpointer-arith")
set(CMAKE_BOUNDSCHECK_FLAGS "${CMAKE_BOUNDSCHECK_FLAGS} -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes -Wstrict-overflow=1 -Wstrict-aliasing=2 -Wswitch -Wswitch-default")

# Set link options
set(CMAKE_BOUNDSCHECK_LINK_FLAGS "-fPIC -s -Wl,-z,relro,-z,now,-z,noexecstack -fstack-protector-all")

# Set output dir
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)

# Generate .so file
add_library(tmp_object OBJECT ${DIR_SRCS})
set_target_properties(tmp_object PROPERTIES COMPILE_FLAGS ${CMAKE_BOUNDSCHECK_FLAGS})
add_library(boundscheck SHARED $<TARGET_OBJECTS:tmp_object>)
set_target_properties(boundscheck PROPERTIES LINK_FLAGS ${CMAKE_BOUNDSCHECK_LINK_FLAGS})
