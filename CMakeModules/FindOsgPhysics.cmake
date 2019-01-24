# Created By Vasim Ali
FIND_PATH( OSGPHYSICS_INCLUDE_DIR "physics/Engine.h"
    $ENV{OSGPHYSICS_DIR}/include
    NO_DEFAULT_PATH
)

MACRO(FIND_OSGPHYSICS_LIBRARY MYLIBRARY MYLIBRARYNAME)
	
	# FIND_LIBRARY(${MYLIBRARY} ${MYLIBRARYNAME} $ENV{OSG_DIR} ${BUILD})
FIND_LIBRARY(     ${MYLIBRARY}
          NAMES       ${MYLIBRARYNAME}
          PATHS
          $ENV{OSGPHYSICS_DIR}/lib
      NO_DEFAULT_PATH
      )
	  message("path: " ${MYLIBRARY})
ENDMACRO(FIND_OSGPHYSICS_LIBRARY )

#Release Lib
FIND_OSGPHYSICS_LIBRARY(OSGPHYSICS_LIBRARY osgPhysics)
FIND_OSGPHYSICS_LIBRARY(OSGPHYSICSUTILS_LIBRARY osgPhysicsUtils)

#Debug Lib
FIND_OSGPHYSICS_LIBRARY(OSGPHYSICS_LIBRARY_DEBUG osgPhysics_d)
FIND_OSGPHYSICS_LIBRARY(OSGPHYSICSUTILS_LIBRARY_DEBUG osgPhysicsUtils_d)