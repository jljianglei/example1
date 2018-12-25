#cmake 最低版本号要求
cmake_minimum_required (VERSION 2.8)
#项目信息
project (Demo1)
#检测系统中是否有库函数
include (${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)
check_function_exists(pow HAVE_POW)
#加入一个配置头文件，用于处理cmake对源码的设置
configure_file(
        "${PROJECT_SOURCE_DIR}/config.h.in"
        "${PROJECT_SOURCE_DIR}/config.h"
        )
#是否使用自己的库
option(USE_MYLIBRARY ON)
if(USE_MYLIBRARY)
    include_directories("${PROJECT_SOURCE_DIR}/exam")
    add_subdirectory(exam)
    set(EXTRA_LIBS ${EXTRA_LIBS} example1)
endif(USE_MYLIBRARY)
#指定生成目标
#变量名在子目录中是可见的，所以要避免父子目录出现同名，否则编译会报错
aux_source_directory(. DIR_SRCFILE)
add_executable(Demo ${DIR_SRCFILE})
target_link_libraries(Demo example1)
install (TARGETS Demo DESTINATION bin)
install (FILES "${PROJECT_SOURCE_DIR}/config.h" DESTINATION include)

#测试规则
enable_testing()
add_test(test_run Demo)

#添加对gdb的支持
set(CMAKE_BUILD_TYPE "Debug")
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
#添加版本号
set(Demo_VERSION_MAJOR 1)
set(Demo_VERSION_MINOR 0)
# 构建一个 CPack 安装包
include (InstallRequiredSystemLibraries)
set (CPACK_PACKAGE_VERSION_MAJOR "${Demo_VERSION_MAJOR}")
set (CPACK_PACKAGE_VERSION_MINOR "${Demo_VERSION_MINOR}")
include (CPack)
