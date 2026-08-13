cmake_minimum_required(VERSION 3.14)
project(crazy_block_online LANGUAGES CXX)

set(BINARY_NAME "crazy_block_online")

cmake_policy(SET CMP0063 NEW)

set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(${BINARY_NAME} WIN32
  "runner.cpp"
  "utils.cpp"
  "win32_window.cpp"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
)

apply_standard_settings(${BINARY_NAME})

target_compile_definitions(${BINARY_NAME} PRIVATE "NOMINMAX")
target_compile_definitions(${BINARY_NAME} PRIVATE "_WINDOWS_")
target_compile_definitions(${BINARY_NAME} PRIVATE "_USRDLL")

target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")

target_link_libraries(${BINARY_NAME} PRIVATE flutter)
target_link_libraries(${BINARY_NAME} PRIVATE "ws2_32.lib")

add_dependencies(${BINARY_NAME} flutter_assemble)

windows_set_project_attributes(${BINARY_NAME})
windows_add_all_resource_files(${BINARY_NAME})
windows_copy_all_dll_files(${BINARY_NAME} verbatim)
