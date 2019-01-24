# Locate VRTRACK

FIND_PATH(VRTRACK_INCLUDE_DIR VRCore/VRCore.h
    PATHS
    ${VRTRACK_SOURCE_DIR}/include
)

FIND_FILE(VRTRACK_LIB_DIR NAMES lib
    PATHS
    ${VRTRACK_SOURCE_DIR}/lib
    NO_DEFAULT_PATH
)

SET(VRCORE_LIBRARY              VRCore)
SET(VR3DUI_LIBRARY				VR3DUI)

message ("include directory is ${VRTRACK_INCLUDE_DIR}")
message ("lib directory is ${VRTRACK_LIB_DIR}")

SET(VRCORE_FOUND "NO")
IF(VRTRACK_INCLUDE_DIR AND VRTRACK_LIB_DIR)
	message ("include directory is ${VRTRACK_INCLUDE_DIR}")
	message ("lib directory is ${VRTRACK_LIB_DIR}")
    SET(VRCORE_FOUND "YES")
ENDIF(VRTRACK_INCLUDE_DIR AND VRTRACK_LIB_DIR)
