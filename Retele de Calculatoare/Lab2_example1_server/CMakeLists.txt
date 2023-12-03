cmake_minimum_required(VERSION 3.22)
project(Lab2_example1_server)

set(CMAKE_CXX_STANDARD 14)
link_libraries(ws2_32 wsock32)

add_executable(Lab2_example1_server main.cpp)
