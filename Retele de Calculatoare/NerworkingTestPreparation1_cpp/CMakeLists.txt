cmake_minimum_required(VERSION 3.22)
project(NerworkingTestPreparation1_cpp)

set(CMAKE_CXX_STANDARD 14)
link_libraries(ws2_32 wsock32)

add_executable(NerworkingTestPreparation1_cpp main.cpp)
