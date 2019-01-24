#define MainFolder "E:\agent\BuildAgent\work\VRTrack\package\VRTrack"

#define MyAppName "VRPlay"
#define MyAppVersion "1.0"
#define MyAppPublisher "VizExperts Pvt. Ltd."
#define MyAppURL "http://www.vizexperts.com/"

#define PlayName "VRPlay"
#define ConfName "VRConfig"



[ISSI]
;; Name of the bitmap image:
#define ISSI_SplashScreen "E:\agent\BuildAgent\work\VRTrack\package\VRTrack\Icons\SPLASH.bmp"
;; Time in seconds:
#define ISSI_SplashScreen_T 5
;; Image Width:
#define ISSI_SplashScreen_X 850
;; Image Heigth:
#define ISSI_SplashScreen_Y 650
;; Rounded corners (Optional):
#define ISSI_Splash_Corner 
;; Include ISSI (required)
#define ISSI_IncludePath "C:\ISSI"
#include ISSI_IncludePath+"\_issi.isi"



[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{2F4D27C1-7153-423C-9F39-12B2F6F2AAB6}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=true

;DisableWelcomePage=no
;DisableDirPage=no
SetupIconFile=E:\agent\BuildAgent\work\VRTrack\package\VRTrack\Icons\VRPlayAPP.ico


OutputDir=E:\VRTrack\Installer
OutputBaseFilename=VRPlaysetup
Compression=lzma
SolidCompression=yes
WizardImageFile={#MainFolder}\Icons\Installer Screen.bmp
WizardSmallImageFile={#MainFolder}\Icons\Modernsmall.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#MainFolder}\bin\VRPlay.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MainFolder}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MainFolder}\bin\VRConfig.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#PlayName}"; Filename: "{app}\bin\VRPlay.exe"; IconFilename: "{app}\Icons\VRPlay.ico";
Name: "{commondesktop}\{#PlayName}"; Filename: "{app}\bin\VRPlay.exe"; IconFilename: "{app}\Icons\VRPlay.ico";

Name: "{commonprograms}\{#ConfName}"; Filename: "{app}\bin\VRConfig.exe"; IconFilename: "{app}\Icons\VRConfig.ico";
Name: "{commondesktop}\{#ConfName}"; Filename: "{app}\bin\VRConfig.exe"; IconFilename: "{app}\Icons\VRConfig.ico";

;Name: "{commondesktop}\{#GameClientName}"; Filename: "{app}\{#GameClientName}\{#PlayName}"; IconFilename: "{app}\{#GameClientName}\vts_angad.ico";
;Name: "{commondesktop}\{#GameServerName}"; Filename: "{app}\{#GameServerName}\{#ServerExeName}"; Parameters: "?servertype=gameserver -server -log"; IconFilename: "{app}\{#GameClientName}\vts_angad.ico";
;Name: "{commondesktop}\{#LobbyServerName}"; Filename: "{app}\{#GameServerName}\{#ServerExeName}"; Parameters: "?servertype=lobbyserver -server -log"; IconFilename: "{app}\{#GameClientName}\vts_angad.ico";

[Run]
Filename: "{app}\bin\VRPlay.exe"; Description: "{cm:LaunchProgram,{#StringChange(PlayName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
Filename: "{app}\bin\VRConfig.exe"; Description: "{cm:LaunchProgram,{#StringChange(ConfName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
