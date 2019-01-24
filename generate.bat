If exist CMakeCache.txt del CMakeCache.txt

set FolderName=x64

if not exist %FolderName% mkdir %FolderName%
cd %FolderName%
cmake -G "Visual Studio 12 2013 Win64" ..

cd..
exit /B 0