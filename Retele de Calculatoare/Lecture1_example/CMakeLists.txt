cmake_minimum_required(VERSION 3.22)
project(Lecture1_example)

set(CMAKE_CXX_STANDARD 14)
link_libraries(ws2_32 wsock32)
add_executable(Lecture1_example main.cpp)
