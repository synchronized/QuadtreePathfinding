cmake_minimum_required(VERSION 3.16)

project(QuadtreePathfindingVisualizer)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

# windows 动态库导出lib文件
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# 设置VisualStudio使用utf-8编码
add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")

# 设置可执行文件和dll文件的输出目录
set(publish_bin_debug 			${CMAKE_CURRENT_SOURCE_DIR}/bin/debug)
set(publish_bin_release 		${CMAKE_CURRENT_SOURCE_DIR}/bin/release)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG 	${publish_bin_debug})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE 	${publish_bin_release})

# 定义spdlog使用fmt库
add_definitions(-DSPDLOG_FMT_EXTERNAL)

find_package(fmt CONFIG REQUIRED)
find_package(argparse CONFIG REQUIRED)
find_package(spdlog CONFIG REQUIRED)
find_package(SDL2_ttf CONFIG REQUIRED)
find_package(SDL2 CONFIG REQUIRED)

# ----- library imgui ------
file(GLOB IMGUI_SOURCES 3rdParty/imgui/*.cpp)
add_library(imgui ${IMGUI_SOURCES})
target_include_directories(imgui PUBLIC "3rdParty/imgui")
target_include_directories(imgui PUBLIC ${SDL2_INCLUDE_DIRS})

# ------ QDPF ---------
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../Source
                 ${CMAKE_CURRENT_BINARY_DIR}/Source)

# ----- QuadtreePathfindingVisualizer ------
file(GLOB VISUALIZER_SOURCES Source/*.cpp)
add_executable(QuadtreePathfindingVisualizer ${VISUALIZER_SOURCES})
target_include_directories(QuadtreePathfindingVisualizer PUBLIC "../Source"
                                                                "3rdParty")

target_link_libraries(QuadtreePathfindingVisualizer PRIVATE fmt::fmt)
target_link_libraries(QuadtreePathfindingVisualizer PRIVATE argparse::argparse)
target_link_libraries(QuadtreePathfindingVisualizer PRIVATE spdlog::spdlog)
target_link_libraries(QuadtreePathfindingVisualizer
    PRIVATE
    $<TARGET_NAME_IF_EXISTS:SDL2::SDL2main>
    $<IF:$<TARGET_EXISTS:SDL2::SDL2>,SDL2::SDL2,SDL2::SDL2-static>
)
target_link_libraries(QuadtreePathfindingVisualizer PRIVATE $<IF:$<TARGET_EXISTS:SDL2_ttf::SDL2_ttf>,SDL2_ttf::SDL2_ttf,SDL2_ttf::SDL2_ttf-static>)

target_link_libraries(QuadtreePathfindingVisualizer PRIVATE imgui)
target_link_libraries(QuadtreePathfindingVisualizer PRIVATE QDPF)
