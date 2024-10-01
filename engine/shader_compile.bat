@echo off

set ENGINE_DIR=%1

set shader_list=shape tex shape_curve quad_shape

for %%a in (%shader_list%) do ( 
    glslc %ENGINE_DIR%/shaders/%%a.vert -o %ENGINE_DIR%/shaders/out/%%a_vert.spv
    glslc %ENGINE_DIR%/shaders/%%a.frag -o %ENGINE_DIR%/shaders/out/%%a_frag.spv
)