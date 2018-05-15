
*-- Common include file
#INCLUDE "FOXPRO.H"
#INCLUDE "STRINGS.H"

#DEFINE DEBUGMODE	.T.
*--DEFINE INIFILE		"???.INI"
#DEFINE K_CRLF		CHR(13) + CHR(10)
#DEFINE K_ENTER		CHR(13)
#DEFINE K_TAB		CHR(9)
#DEFINE K_BS		CHR(8)

#DEFINE NK_ENTER	13
#DEFINE NK_ESC		27
#DEFINE NK_BS		127
#DEFINE NK_F2		-1
#DEFINE NK_INS		22
#DEFINE NK_DEL		7

#DEFINE CURRENCY	"$"
#DEFINE AERRORARRAY	7

*-- These constants are used in tsbaseform to 
*-- indicate the status of the current alias
#DEFINE FILE_OK		0
#DEFINE FILE_BOF	1
#DEFINE FILE_EOF	2
#DEFINE FILE_CANCEL	3

*-- Constants to identify which trigger failed
*-- using element 5 of the array returned by 
*-- AERROR(), as well as to reference the appropriate
*-- array element in the error message array: aErrorMsg[]
#DEFINE INSERTTRIG  1
#DEFINE UPDATETRIG  2
#DEFINE DELETETRIG  3

*-- Constants used to read the system registry
#DEFINE HKEY_LOCAL_MACHINE			-2147483646  
#DEFINE KEY_SHARED_TOOLS_LOCATION	"Software\Microsoft\Shared Tools"
#DEFINE KEY_NTCURRENTVERSION		"Software\Microsoft\Windows NT\CurrentVersion"
#DEFINE KEY_WIN4CURRENTVERSION		"Software\Microsoft\Windows\CurrentVersion"
#DEFINE KEY_WIN4_MSINFO				"Software\Microsoft\Shared Tools\MSInfo"
#DEFINE KEY_QUERY_VALUE				1
#DEFINE ERROR_SUCCESS				0

#DEFINE ADMINBAR_LOC "Administración"
#DEFINE ALL_LOC "Todo"

#DEFINE USER_APPDEV_LOC "PROGRAMADOR DE APLICACIONES"
#DEFINE USER_OPSMGR_LOC "DIRECTOR DE OPERACIONES"

#DEFINE DOLLAR_FORMAT1_LOC ": $"
#DEFINE DOLLAR_FORMAT2_LOC ""
#DEFINE DOLLAR_FORMAT3_LOC "$"
#DEFINE SEEKVALUE_LOC	"*Supuesto práctico"

#DEFINE SYS2011_EXCLUSIVE_LOC 	"EXCLUSIVE"
#DEFINE SYS2011_RECLOCK_LOC 	"RECORD LOCKED"
#DEFINE SYS2011_RECUNLOCK_LOC 	"RECORD UNLOCKED"

#DEFINE	I_SHPMIN	111			&& how far left can the Behind the Scenes splitter go?
#DEFINE I_SHPMAX	303			&& how far right can the Behind the Scenes splitter go?

#DEFINE MESS_BOX_SI	     6
#DEFINE MESS_BOX_NO   	 7
#DEFINE MESS_BOX_ACEPTAR 1
#DEFINE MESS_BOX_CANCEL	 2

#DEFINE I_AreaType     1
#DEFINE I_Area3DType   -4098
#DEFINE I_BarType	   2
#DEFINE I_Bar3DType    -4099
#DEFINE I_ColType	   3
#DEFINE I_Col3DType    -4100
#DEFINE I_Linetype     4
#DEFINE I_Line3Dtype   -4101
#DEFINE I_PieType      5
#DEFINE I_Pie3DType    -4102
