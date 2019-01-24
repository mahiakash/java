# Created By Vasim Ali
FIND_PATH( PHYSX_INCLUDE_DIR "PxPhysics.h"
    $ENV{PHYSX_DIR}/Include
    NO_DEFAULT_PATH
)

MACRO(FIND_PHYSX_LIBRARY MYLIBRARY MYLIBRARYNAME)
	
	# FIND_LIBRARY(${MYLIBRARY} ${MYLIBRARYNAME} $ENV{OSG_DIR} ${BUILD})
FIND_LIBRARY(     ${MYLIBRARY}
          NAMES       ${MYLIBRARYNAME}
          PATHS
          $ENV{PHYSX_DIR}/lib
      NO_DEFAULT_PATH
      )
	   message("path: " ${MYLIBRARY})
ENDMACRO(FIND_PHYSX_LIBRARY )

# Find release (optimized) libs
FIND_PHYSX_LIBRARY(LOWLEVEL_LIBRARY 						LowLevel)
FIND_PHYSX_LIBRARY(LOWLEVELCLOTH_LIBRARY 					LowLevelCloth)
FIND_PHYSX_LIBRARY(PHYSX3_LIBRARY 						    PhysX3_x64)
FIND_PHYSX_LIBRARY(PHYSX3CHARACTERKINEMATIC_LIBRARY 		PhysX3CharacterKinematic_x64)
FIND_PHYSX_LIBRARY(PHYSX3COMMON_X64_LIBRARY 				PhysX3Common_x64)
FIND_PHYSX_LIBRARY(PHYSX3COOKING_X64_LIBRARY 				PhysX3Cooking_x64)
FIND_PHYSX_LIBRARY(PHYSX3EXTENSIONS_LIBRARY 				PhysX3Extensions)
FIND_PHYSX_LIBRARY(PHYSX3GPU_X64_LIBRARY 					PhysX3Gpu_x64)
FIND_PHYSX_LIBRARY(PHYSX3GPUCHECKED_X64_LIBRARY 			PhysX3GpuCHECKED_x64)
FIND_PHYSX_LIBRARY(PHYSX3GPUPROFILE_X64_LIBRARY 			PhysX3GpuPROFILE_x64)
FIND_PHYSX_LIBRARY(PHYSX3VEHICLE_LIBRARY 				    PhysX3Vehicle)
FIND_PHYSX_LIBRARY(PHYSXPROFILESDK_LIBRARY 					PhysXProfileSDK)
FIND_PHYSX_LIBRARY(PHYSXVISUALDEBUGGERSDK_LIBRARY 			PhysXVisualDebuggerSDK)
FIND_PHYSX_LIBRARY(PVDRUNTIME_LIBRARY 				        PvdRuntime)
FIND_PHYSX_LIBRARY(PXTASK_LIBRARY 			                PxTask)
FIND_PHYSX_LIBRARY(SCENEQUERY_LIBRARY 				        SceneQuery)
FIND_PHYSX_LIBRARY(SIMULATIONCONTROLLER_LIBRARY 			SimulationController)

# Find debug libs
FIND_PHYSX_LIBRARY(LOWLEVEL_LIBRARY_DEBUG 					LowLevelDEBUG)
FIND_PHYSX_LIBRARY(LOWLEVELCLOTH_LIBRARY_DEBUG 				LowLevelClothDEBUG)
FIND_PHYSX_LIBRARY(PHYSX3_LIBRARY_DEBUG 			        PhysX3DEBUG_x64)
FIND_PHYSX_LIBRARY(PHYSX3CHARACTERKINEMATIC_LIBRARY_DEBUG 	PhysX3CharacterKinematicDEBUG_x64)
FIND_PHYSX_LIBRARY(PHYSX3COMMON_X64_LIBRARY_DEBUG 			PhysX3CommonDEBUG_x64)
FIND_PHYSX_LIBRARY(PHYSX3COOKING_X64_LIBRARY_DEBUG 			PhysX3CookingDEBUG_x64)
FIND_PHYSX_LIBRARY(PHYSX3EXTENSIONS_LIBRARY_DEBUG 			PhysX3ExtensionsDEBUG)
FIND_PHYSX_LIBRARY(PHYSX3GPU_X64_LIBRARY_DEBUG 				PhysX3GpuDEBUG_x64)
FIND_PHYSX_LIBRARY(PHYSX3VEHICLE_LIBRARY_DEBUG 			    PhysX3VehicleDEBUG)
FIND_PHYSX_LIBRARY(PHYSXPROFILESDK_LIBRARY_DEBUG 			PhysXProfileSDKDEBUG)
FIND_PHYSX_LIBRARY(PHYSXVISUALDEBUGGERSDK_LIBRARY_DEBUG 	PhysXVisualDebuggerSDKDEBUG)
FIND_PHYSX_LIBRARY(PVDRUNTIME_LIBRARY_DEBUG 			    PvdRuntimeDEBUG)
FIND_PHYSX_LIBRARY(PXTASK_LIBRARY_DEBUG 		            PxTaskDEBUG)
FIND_PHYSX_LIBRARY(SCENEQUERY_LIBRARY_DEBUG			        SceneQueryDEBUG)
FIND_PHYSX_LIBRARY(SIMULATIONCONTROLLER_LIBRARY_DEBUG 		SimulationControllerDEBUG)

SET(PHYSX_FOUND "NO")
IF(PHYSX_LIBRARY AND PHYSX_INCLUDE_DIR)
    SET(PHYSX_FOUND "YES")
ENDIF(PHYSX_LIBRARY AND PHYSX_INCLUDE_DIR)
