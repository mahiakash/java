:: OSSROOTis being set from the command line options in TeamCity
set OSSROOT=E:\agent\BuildAgent\work\OSS_VRTRACK

::Mpich2 binary path
set MPICH_BIN=C:\Program Files\Microsoft MPI\Bin

:: set OSG Directories
set OSG_DIR=%OSSROOT%\osg-3.4
set OSG_BIN=%OSG_DIR%\bin
set OSG_PLUGIN_DIR=%OSG_BIN%\osgPlugins-3.4.2

::set TinyXML Directories
set TINYXML_DIR=%OSSROOT%\tinyxml
set TINYXML_BIN=%TINYXML_DIR%\bin

::set VRPN Path
set VRPN_DIR=%OSSROOT%\VRPN
set VRPN_BIN=%VRPN_DIR%\bin

::set OPENVR Paths
set OPENVR_DIR=%OSSROOT%\OpenVR
set OPENVR_BIN=%OPENVR_DIR%\bin

::set OSGOpenVR Paths
set OSGOPENVR_DIR=%OSSROOT%\osgOpenVR

echo "%1"

if "%1"=="Release" set TRANSVIZ_DIR=%OSSROOT%\TransViz\Release
if "%1"=="Debug" set TRANSVIZ_DIR=%OSSROOT%\TransViz\Debug
set TRANSVIZ_BIN=%TRANSVIZ_DIR%\bin

:: png bin
set PNG_DIR=%OSSROOT%\png
set PNG_BIN=%PNG_DIR%\bin

:: JPEG Binaries
set JPEG_DIR=%OSSROOT%\jpeg
set JPEG_BIN=%JPEG_DIR%\bin

:: set FAASt Library
set FAAST_DIR=%OSSROOT%\FAAST

:: QT Paths
::Qt Path
set QT_DIR=%OSSROOT%\qt\5.9.4\msvc2013_64
set QT_INC=%QT_DIR%\include
set QT_BIN=%QT_DIR%\bin
set QT_PLUGIN_PATH=%QT_DIR%\plugins
set QML2_IMPORT_PATH=%QT_DIR%\qml

::set PhysXSDK Directories
set PHYSX_DIR=%OSSROOT%\PhysXSDK
set PHYSX_BIN=%PHYSX_DIR%\Bin

::set osgPhysics Directories
set OSGPHYSICS_DIR=%OSSROOT%\osgPhysics
set OSGPHYSICS_BIN=%OSGPHYSICS_DIR%\bin

:: dynamic libs paths
set PATH=%OSG_BIN%;%OSG_PLUGIN_DIR%;%VRPN_BIN%;%OPENVR_BIN%;%QT_BIN%;%TINYXML_BIN%;%TRANSVIZ_BIN%;%PHYSX_BIN%;%OSGPHYSICS_BIN%;%PATH%

set VRTRACK_DIR=%cd%

if "%1" EQU "debug" set DBG=1
if "%2" EQU "debug" set DBG=1
if "%3" EQU "debug" set DBG=1
if "%4" EQU "debug" set DBG=1

set BUILDENV=%1
::if DEFINED DBG set BUILDENV=Debug


IF exist x64\VRTrack.sln goto build_x64
call generate.bat

::generating build for x64 env if build parameter is given
:build_x64

if "%1" EQU "nobuild" goto package
if "%2" EQU "nobuild" goto package
if "%3" EQU "nobuild" goto package
if "%4" EQU "nobuild" goto package

set buildType=%1
::if DEFINED DBG set buildType=Debug

echo %buildType%

call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x64
echo "Starting Build for all VRTrack"
echo .  
msbuild "x64\VRTrack.sln" /p:configuration=%buildType%
echo . 
:package

if "%1" EQU "nopackage" goto end
if "%2" EQU "nopackage" goto end
if "%3" EQU "nopackage" goto end
if "%4" EQU "nopackage" goto end

if DEFINED DBG(goto end)

cd %VRTRACK_DIR%/package

call VRTrackSetup.bat

:end
cd "%VRTRACK_DIR%"
