cmake_minimum_required(VERSION 3.18)

set(TARGET BeginnersGuideCppCheatMod)
project(${TARGET})

add_library(${TARGET} SHARED "src/dllmain.cpp")
target_include_directories(${TARGET} PRIVATE . "${CMAKE_SOURCE_DIR}/CXXHeaderDump")
target_link_libraries(${TARGET} PUBLIC UE4SS)

# Set this to the full path of your Subnautica 2 UE4SS mods folder
set(GAME_MODS_DIR "E:/Games/Steam/steamapps/common/Subnautica2/Subnautica2/Binaries/Win64/ue4ss/Mods")

# This will automatically create a subfolder in the Mods folder and deploy the compiled DLL as 'main.dll'
add_custom_command(TARGET ${TARGET} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory "${GAME_MODS_DIR}/${TARGET}/dlls"
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${TARGET}> "${GAME_MODS_DIR}/${TARGET}/dlls/main.dll"
)