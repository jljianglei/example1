#cmake 最低版本号要求
cmake_minimum_required (VERSION 2.8)
aux_source_directory(. DIR_EXAM_SRCFILE)
add_library(example1 ${DIR_EXAM_SRCFILE})
install(TARGETS example1 DESTINATION lib)
