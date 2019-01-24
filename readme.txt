1. Build instructions for Windows
---------------------------------
    1.1 Setting up the machine
    --------------------------
	Install the mentioned softwares from the web or local software store
        1.1.1 Install Visual Studio 2013 compiler (64-bit)
        
		1.1.2 Install cmake from the following link, during installation choose
              to set cmake directory in your PATH. MInimum Version Required 2.4.6
              http://www.cmake.org/cmake/resources/software.html
		
		1.1.3 Install QTCreator 5.9.4, for Widget Creation
		
		1.1.4 The following OpenSource Packages must be checked out from SVN under OSS_ADA directory
			OSS_ADA can be found in "http://192.168.0.2:18080/svn/OSS_ADA"
			OSS_VRTrack\OpenVR
			OSS_VRTrack\vrpn
			OSS_VRTrack\OSG
			OSS_VRTrack\qt
			
			Setup the OSSROOT environment variable to correct path in the initVRTrack.bat file
			for example: set OSSROOT=""
	1.2 Build
    ---------
		- cd to the root directory of the source tree.
		
		- Setup the OSSROOT environment variable to correct path in the initVRTrack.bat file.
		
        - run the following command from CMD: initVRTrack.bat
		
	Corresponding solution file would formed under x64 folder.
        - Open the .sln file and build the solution.