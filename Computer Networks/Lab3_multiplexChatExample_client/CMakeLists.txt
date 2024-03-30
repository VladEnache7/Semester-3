cmake_minimum_required(VERSION 3.22)
project(Lab3_multiplexChatExample_client)

set(CMAKE_CXX_STANDARD 14)
link_libraries(ws2_32 wsock32)

add_executable(Lab3_multiplexChatExample_client main.cpp)
