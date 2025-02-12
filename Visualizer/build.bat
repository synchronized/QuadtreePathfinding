@ECHO ON

set BASEDIR=%~dp0
PUSHD %BASEDIR%

RMDIR /Q /S build

conan install . --output-folder=build --build=missing -s compiler.cppstd=20 -s build_type=Debug
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE="conan_toolchain.cmake"
cmake --build . --config Debug
