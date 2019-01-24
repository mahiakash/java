PROJECT(VRTRACK)

# SET(DB_PLUGINS ${LIBRARY_PREFIX}DBPlugins) 
# SET(DB_PLUGIN_PREFIX "")

CMAKE_MINIMUM_REQUIRED(VERSION 2.4.6)

#see cmake --help-policy CMP0005 for more information
IF(COMMAND cmake_policy)
    CMAKE_POLICY(SET CMP0005 NEW)
ENDIF(COMMAND cmake_policy)

#see cmake --help-policy CMP0003 for more information
IF(COMMAND cmake_policy)
    CMAKE_POLICY(SET CMP0003 NEW)
ENDIF(COMMAND cmake_policy)

SET(CMAKE_DEBUG_POSTFIX  "d") 
IF (WIN32)
    OPTION(BUILD_WITH_MP "Enables the /MP multi-processor compiler option" ON)
    MARK_AS_ADVANCED(BUILD_WITH_MP)
   
    IF(BUILD_WITH_MP)
     SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
    ENDIF(BUILD_WITH_MP)
ENDIF (WIN32)
# We have some custom .cmake scripts not in the official distribution.
# Maybe this can be used override existing behavior if needed?
SET(CMAKE_MODULE_PATH "${VRTRACK_SOURCE_DIR}/CMakeModules;${CMAKE_MODULE_PATH}")
message("CMAKE_MODULE_PATH : " ${CMAKE_MODULE_PATH})
## Setting Global Dir for outputing lib,dll,exe

SET(OUTPUT_LIBDIR ${PROJECT_BINARY_DIR}/lib)
MAKE_DIRECTORY(${OUTPUT_LIBDIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_LIBDIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_LIBDIR})

SET(OUTPUT_BINDIR ${PROJECT_BINARY_DIR}/bin)
MAKE_DIRECTORY(${OUTPUT_BINDIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_BINDIR})
SET(EXECUTABLE_OUTPUT_PATH ${OUTPUT_BINDIR})

# # Add macro functions
INCLUDE(UtilityMacros)
INCLUDE(UtilityFunctions)
INCLUDE(BuildExample)
INCLUDE(BuildBinding)
INCLUDE(CPack)
FIND_PACKAGE(VRTRACK)

FIND_PACKAGE(OpenGL REQUIRED)

IF(UNIX)
   FIND_PACKAGE(X11)
   
   FIND_LIBRARY(XXF86VM_LIBRARY Xxf86vm)
   SET(X11_LIBRARIES
        ${X11_LIBRARIES}
         ${XXF86VM_LIBRARY}
   )
     # Some Unicies need explicit linkage to the Math library or the build fails.
    FIND_LIBRARY(MATH_LIBRARY m)

    ADD_DEFINITIONS(-DSIGSLOT_PURE_ISO)

    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wno-non-virtual-dtor")

    OPTION(SUPPRESS_UNUSED "Suppress unused variables warnings" OFF)
    IF (SUPPRESS_UNUSED)
        SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unused")
    ENDIF (SUPPRESS_UNUSED)
ENDIF (UNIX)

# Platform specific definitions

IF(WIN32)
    ADD_DEFINITIONS(-D_SCL_SECURE_NO_WARNINGS)
    ADD_DEFINITIONS(-D_CRT_SECURE_NO_DEPRECATE)
    
    # Mark 32 bit executables large address aware so they can 
    # use > 2GB address space
    IF(CMAKE_SIZEOF_VOID_P MATCHES 4)
        MESSAGE("Enabling Large address space Aware flag for 32 bit applications")
        SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /LARGEADDRESSAWARE")
    ENDIF()
    
    #Uncomment this while evaluating performance of operations
ADD_DEFINITIONS(-DEVALUATE_PERFORMANCE)
ADD_DEFINITIONS(-DNONGUISAMPLE)

    
#Flag for using VRTRACK as VRTRACK_SDK    
#ADD_DEFINITIONS(-DUSE_VRTRACK_SDK)
#needed for net plugin
ADD_DEFINITIONS(-DNOMINMAX)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DBOOST_ALL_NO_LIB")

################################################################################
# the following options are MSVC specific,
# the first VRTRACK_MSVC_VERSIONED_DLL activate a custom build-time layout that
# should allow to run examples and application
# fron bin folder without requiring installation step.
# it also prepend "osg${OPENSCENEGRAPH_SOVERSION}-" to only .dll files, leaving
#.lib files untouched in lib
# it also use a hack to get rid of Debug and Release folder in MSVC projects
# all the .dll and .pdb are in bin and all the .lib and .exp are in lib
#
# the second option disable incremental linking in debug build , that is enabled
# by default by CMake
################################################################################

    IF(MSVC)
        IF(${CMAKE_MAJOR_VERSION} EQUAL 2 AND ${CMAKE_MINOR_VERSION} EQUAL 4 AND
${CMAKE_PATCH_VERSION} LESS 7)
            MESSAGE("Warning:  disabling versioned options 2.4.6 exibits
inconsintencies in .pdb naming, at least under MSVC, suggested
upgrading at least to 2.4.7")
            SET(VRTRACK_MSVC_VERSIONED_DLL OFF)
            SET(VRTRACK_MSVC_DEBUG_INCREMENTAL_LINK ON)
        ELSE(${CMAKE_MAJOR_VERSION} EQUAL 2 AND ${CMAKE_MINOR_VERSION} EQUAL 4
AND ${CMAKE_PATCH_VERSION} LESS 7)
            OPTION(VRTRACK_MSVC_VERSIONED_DLL "Set to ON to build OpenSceneGraph
with versioned dll names" ON)
            MARK_AS_ADVANCED(VRTRACK_MSVC_VERSIONED_DLL)
            OPTION(VRTRACK_MSVC_DEBUG_INCREMENTAL_LINK "Set to OFF to build
OpenSceneGraph without incremental linking in debug (release is off
by default)" ON)
            MARK_AS_ADVANCED(VRTRACK_MSVC_DEBUG_INCREMENTAL_LINK)
            IF(NOT VRTRACK_MSVC_DEBUG_INCREMENTAL_LINK)
                SET(CMAKE_MODULE_LINKER_FLAGS_DEBUG "/debug /INCREMENTAL:NO")
                SET(CMAKE_SHARED_LINKER_FLAGS_DEBUG "/debug /INCREMENTAL:NO")
                SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "/debug /INCREMENTAL:NO")
            ENDIF(NOT VRTRACK_MSVC_DEBUG_INCREMENTAL_LINK)
        ENDIF(${CMAKE_MAJOR_VERSION} EQUAL 2 AND ${CMAKE_MINOR_VERSION} EQUAL 4
AND ${CMAKE_PATCH_VERSION} LESS 7)

            #Clubbing each test in the folder
            SET_PROPERTY(GLOBAL PROPERTY USE_FOLDERS ON)
            IF(CMAKE_SIZEOF_VOID_P MATCHES "4")
                SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /ZI")
            ENDIF(CMAKE_SIZEOF_VOID_P MATCHES "4")
    ENDIF(MSVC)
ENDIF(WIN32)

# We respond to a flag that lets us disable all modules/classes
# that are not needed for visualization. This is to allow building
# a minimalist version of TK_SDK which can be used in scenarios such as
#
cmake_policy(SET "CMP0012" NEW)
IF ($ENV{DISABLE_VISUALIZATION} MATCHES "true")
    MESSAGE(STATUS "Disabling visualization related modules")
    ADD_DEFINITIONS (-DDISABLE_VISUALIZATION)
    SET(DISABLE_VISUALIZATION "on")
ELSE()
    SET(DISABLE_VISUALIZATION "off")
ENDIF()

################################################################################

#required dependencies
FIND_PACKAGE(OSG)
FIND_PACKAGE(VRPN)
FIND_PACKAGE(OpenVR)
FIND_PACKAGE(QtCustom)
FIND_PACKAGE(OSGOpenVR)
FIND_PACKAGE(TinyXML)
FIND_PACKAGE(TransViz)
FIND_PACKAGE(PhysXSDK)
FIND_PACKAGE(OsgPhysics)

# Make the headers visible to everything
INCLUDE_DIRECTORIES(
    ${CMAKE_SOURCE_DIR}/inc
    ${OPENGL_INCLUDE_DIR}
    ${OPENTHREADS_INCLUDE_DIR}
    ${OSG_INCLUDE_DIR}
)

#------------------------------------------------------------------------------
# ADD VRTRACKSDK SOURCES HERE

OPTION(BUILD_EXAMPLES "Build example modules" ON)

# optional external dependencies
ADD_SUBDIRECTORY(src)

if(BUILD_EXAMPLES)
    ADD_SUBDIRECTORY(examples)
endif(BUILD_EXAMPLES) 

#------------------------------------------------------------------------------


LINK_DIRECTORIES( ${VRTRACK_EXT_DIR}/lib
)

################################################################################
# Create bin and lib directories if required

IF("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
   FILE(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/bin ${CMAKE_BINARY_DIR}/lib )
ENDIF("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")

