#NoTrayIcon
Global Const $BS_ICON = 0x0040
Global Const $BS_BITMAP = 0x0080
Global Const $BM_GETIMAGE = 0xF6
Global Const $BM_SETIMAGE = 0xF7
Global Const $GUI_EVENT_CLOSE = -3
Global Const $SS_ICON = 0x3
Global Const $SS_BLACKRECT = 0x4
Global Const $SS_BITMAP = 0xE
Global Const $RT_ANICURSOR = 21
Global Const $RT_BITMAP = 2
Global Const $RT_CURSOR = 1
Global Const $RT_FONT = 8
Global Const $RT_ICON = 3
Global Const $RT_MENU = 4
Global Const $RT_RCDATA = 10
Global Const $RT_STRING = 6
Global Const $LOAD_LIBRARY_AS_DATAFILE = 0x02
Global Const $tagGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $tagOSVERSIONINFO = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $IMAGE_BITMAP = 0
Global Const $IMAGE_ICON = 1
Global Const $IMAGE_CURSOR = 2
Global Const $IMAGE_ENHMETAFILE = 3
Global Const $LR_DEFAULTCOLOR = 0x0000
Global Const $__WINVER = __WINVER()
Func _WinAPI_FreeLibrary($hModule)
Local $aResult = DllCall("kernel32.dll", "bool", "FreeLibrary", "handle", $hModule)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_GetDlgCtrlID($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetModuleHandle($sModuleName)
Local $sModuleNameType = "wstr"
If $sModuleName = "" Then
$sModuleName = 0
$sModuleNameType = "ptr"
EndIf
Local $aResult = DllCall("kernel32.dll", "handle", "GetModuleHandleW", $sModuleNameType, $sModuleName)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_LoadImage($hInstance, $sImage, $iType, $iXDesired, $iYDesired, $iLoad)
Local $aResult, $sImageType = "int"
If IsString($sImage) Then $sImageType = "wstr"
$aResult = DllCall("user32.dll", "handle", "LoadImageW", "handle", $hInstance, $sImageType, $sImage, "uint", $iType, "int", $iXDesired, "int", $iYDesired, "uint", $iLoad)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func __WINVER()
Local $tOSVI = DllStructCreate($tagOSVERSIONINFO)
DllStructSetData($tOSVI, 1, DllStructGetSize($tOSVI))
Local $aRet = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $tOSVI)
If @error Or Not $aRet[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($tOSVI, 2), -8), DllStructGetData($tOSVI, 3))
EndFunc
Func _WinAPI_CreateStreamOnHGlobal($hGlobal = 0, $bDeleteOnRelease = True)
Local $aReturn = DllCall('ole32.dll', 'long', 'CreateStreamOnHGlobal', 'handle', $hGlobal, 'bool', $bDeleteOnRelease, 'ptr*', 0)
If @error Then Return SetError(@error, @extended, 0)
If $aReturn[0] Then Return SetError(10, $aReturn[0], 0)
Return $aReturn[3]
EndFunc
Func _WinAPI_ReleaseStream($pStream)
Local $aReturn = DllCall('oleaut32.dll', 'long', 'DispCallFunc', 'ptr', $pStream, 'ulong_ptr', 8 *(1 + @AutoItX64), 'uint', 4, 'ushort', 23, 'uint', 0, 'ptr', 0, 'ptr', 0, 'str', '')
If @error Then Return SetError(@error, @extended, 0)
If $aReturn[0] Then Return SetError(10, $aReturn[0], 0)
Return 1
EndFunc
Global Const $STR_STRIPALL = 8
Func _WinAPI_SetLastError($iErrorCode, Const $_iCurrentError = @error, Const $_iCurrentExtended = @extended)
DllCall("kernel32.dll", "none", "SetLastError", "dword", $iErrorCode)
Return SetError($_iCurrentError, $_iCurrentExtended, Null)
EndFunc
Func _WinAPI_DeleteObject($hObject)
Local $aResult = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hObject)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_DestroyIcon($hIcon)
Local $aResult = DllCall("user32.dll", "bool", "DestroyIcon", "handle", $hIcon)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_DeleteEnhMetaFile($hEmf)
Local $aRet = DllCall('gdi32.dll', 'bool', 'DeleteEnhMetaFile', 'handle', $hEmf)
If @error Then Return SetError(@error, @extended, False)
Return $aRet[0]
EndFunc
Func _WinAPI_RemoveFontMemResourceEx($hFont)
Local $aRet = DllCall('gdi32.dll', 'bool', 'RemoveFontMemResourceEx', 'handle', $hFont)
If @error Then Return SetError(@error, @extended, False)
Return $aRet[0]
EndFunc
Global $__g_hGDIPDll = 0
Global $__g_iGDIPRef = 0
Global $__g_iGDIPToken = 0
Global $__g_bGDIP_V1_0 = True
Func _GDIPlus_BitmapCreateFromHBITMAP($hBitmap, $hPal = 0)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateBitmapFromHBITMAP", "handle", $hBitmap, "handle", $hPal, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[3]
EndFunc
Func _GDIPlus_BitmapCreateFromStream($pStream)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateBitmapFromStream", "ptr", $pStream, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[2]
EndFunc
Func _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap, $iARGB = 0xFF000000)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateHBITMAPFromBitmap", "handle", $hBitmap, "handle*", 0, "dword", $iARGB)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[2]
EndFunc
Func _GDIPlus_BitmapDispose($hBitmap)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDisposeImage", "handle", $hBitmap)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_Shutdown()
If $__g_hGDIPDll = 0 Then Return SetError(-1, -1, False)
$__g_iGDIPRef -= 1
If $__g_iGDIPRef = 0 Then
DllCall($__g_hGDIPDll, "none", "GdiplusShutdown", "ulong_ptr", $__g_iGDIPToken)
DllClose($__g_hGDIPDll)
$__g_hGDIPDll = 0
EndIf
Return True
EndFunc
Func _GDIPlus_Startup($sGDIPDLL = Default, $bRetDllHandle = False)
$__g_iGDIPRef += 1
If $__g_iGDIPRef > 1 Then Return True
If $sGDIPDLL = Default Then $sGDIPDLL = "gdiplus.dll"
$__g_hGDIPDll = DllOpen($sGDIPDLL)
If $__g_hGDIPDll = -1 Then
$__g_iGDIPRef = 0
Return SetError(1, 2, False)
EndIf
Local $sVer = FileGetVersion($sGDIPDLL)
$sVer = StringSplit($sVer, ".")
If $sVer[1] > 5 Then $__g_bGDIP_V1_0 = False
Local $tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
Local $tToken = DllStructCreate("ulong_ptr Data")
DllStructSetData($tInput, "Version", 1)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdiplusStartup", "struct*", $tToken, "struct*", $tInput, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
$__g_iGDIPToken = DllStructGetData($tToken, "Data")
If $bRetDllHandle Then Return $__g_hGDIPDll
Return SetExtended($sVer[1], True)
EndFunc
Global Const $GWL_STYLE = 0xFFFFFFF0
Func _WinAPI_GetClassName($hWnd)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hWnd, "wstr", "", "int", 4096)
If @error Or Not $aResult[0] Then Return SetError(@error, @extended, '')
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _WinAPI_GetWindowLong($hWnd, $iIndex)
Local $sFuncName = "GetWindowLongW"
If @AutoItX64 Then $sFuncName = "GetWindowLongPtrW"
Local $aResult = DllCall("user32.dll", "long_ptr", $sFuncName, "hwnd", $hWnd, "int", $iIndex)
If @error Or Not $aResult[0] Then Return SetError(@error + 10, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_InvalidateRect($hWnd, $tRECT = 0, $bErase = True)
Local $aResult = DllCall("user32.dll", "bool", "InvalidateRect", "hwnd", $hWnd, "struct*", $tRECT, "bool", $bErase)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_UpdateWindow($hWnd)
Local $aResult = DllCall("user32.dll", "bool", "UpdateWindow", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _GUICtrlMenu_DestroyMenu($hMenu)
Local $aResult = DllCall("user32.dll", "bool", "DestroyMenu", "handle", $hMenu)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Global Const $GMEM_MOVEABLE = 0x0002
Func _MemGlobalAlloc($iBytes, $iFlags = 0)
Local $aResult = DllCall("kernel32.dll", "handle", "GlobalAlloc", "uint", $iFlags, "ulong_ptr", $iBytes)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _MemGlobalLock($hMemory)
Local $aResult = DllCall("kernel32.dll", "ptr", "GlobalLock", "handle", $hMemory)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _MemGlobalUnlock($hMemory)
Local $aResult = DllCall("kernel32.dll", "bool", "GlobalUnlock", "handle", $hMemory)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _MemMoveMemory($pSource, $pDest, $iLength)
DllCall("kernel32.dll", "none", "RtlMoveMemory", "struct*", $pDest, "struct*", $pSource, "ulong_ptr", $iLength)
If @error Then Return SetError(@error, @extended)
EndFunc
Func _WinAPI_DestroyCursor($hCursor)
Local $aRet = DllCall('user32.dll', 'bool', 'DestroyCursor', 'handle', $hCursor)
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func _WinAPI_FindResource($hInstance, $sType, $sName)
Local $sTypeOfType = 'int', $sTypeOfName = 'int'
If IsString($sType) Then
$sTypeOfType = 'wstr'
EndIf
If IsString($sName) Then
$sTypeOfName = 'wstr'
EndIf
Local $aRet = DllCall('kernel32.dll', 'handle', 'FindResourceW', 'handle', $hInstance, $sTypeOfName, $sName, $sTypeOfType, $sType)
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func _WinAPI_FindResourceEx($hInstance, $sType, $sName, $iLanguage)
Local $sTypeOfType = 'int', $sTypeOfName = 'int'
If IsString($sType) Then
$sTypeOfType = 'wstr'
EndIf
If IsString($sName) Then
$sTypeOfName = 'wstr'
EndIf
Local $aRet = DllCall('kernel32.dll', 'handle', 'FindResourceExW', 'handle', $hInstance, $sTypeOfType, $sType, $sTypeOfName, $sName, 'ushort', $iLanguage)
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func _WinAPI_LoadString($hInstance, $iStringID)
Local $aResult = DllCall("user32.dll", "int", "LoadStringW", "handle", $hInstance, "uint", $iStringID, "wstr", "", "int", 4096)
If @error Or Not $aResult[0] Then Return SetError(@error + 10, @extended, "")
Return SetExtended($aResult[0], $aResult[3])
EndFunc
Func _WinAPI_LoadLibraryEx($sFileName, $iFlags = 0)
Local $aResult = DllCall("kernel32.dll", "handle", "LoadLibraryExW", "wstr", $sFileName, "ptr", 0, "dword", $iFlags)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_LoadResource($hInstance, $hResource)
Local $aRet = DllCall('kernel32.dll', 'handle', 'LoadResource', 'handle', $hInstance, 'handle', $hResource)
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func _WinAPI_LockResource($hData)
Local $aRet = DllCall('kernel32.dll', 'ptr', 'LockResource', 'handle', $hData)
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func _WinAPI_SizeOfResource($hInstance, $hResource)
Local $aRet = DllCall('kernel32.dll', 'dword', 'SizeofResource', 'handle', $hInstance, 'handle', $hResource)
If @error Or Not $aRet[0] Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
OnAutoItExitRegister(_GDIPlus_Shutdown)
OnAutoItExitRegister(_Resource_DestroyAll)
_GDIPlus_Startup()
Global Enum $RESOURCE_ERROR_NONE, $RESOURCE_ERROR_FINDRESOURCE, $RESOURCE_ERROR_INVALIDCONTROLID, $RESOURCE_ERROR_INVALIDCLASS, $RESOURCE_ERROR_INVALIDRESOURCENAME, $RESOURCE_ERROR_INVALIDRESOURCETYPE, $RESOURCE_ERROR_LOCKRESOURCE, $RESOURCE_ERROR_LOADBITMAP, $RESOURCE_ERROR_LOADCURSOR, $RESOURCE_ERROR_LOADICON, $RESOURCE_ERROR_LOADIMAGE, $RESOURCE_ERROR_LOADLIBRARY, $RESOURCE_ERROR_LOADSTRING, $RESOURCE_ERROR_SETIMAGE
Global Const $RESOURCE_SS_ENHMETAFILE = 0xF
Global Const $RESOURCE_SS_REALSIZECONTROL = 0x40
Global Const $RESOURCE_STM_GETIMAGE = 0x0173
Global Const $RESOURCE_STM_SETIMAGE = 0x0172
Global Const $RESOURCE_LANG_DEFAULT = 0
Global Enum $RESOURCE_RT_BITMAP = 1000, $RESOURCE_RT_ENHMETAFILE, $RESOURCE_RT_FONT
Global Enum $RESOURCE_POS_H, $RESOURCE_POS_W, $RESOURCE_POS_MAX
Global Const $RESOURCE_STORAGE_GUID = 'CA37F1E6-04D1-11E4-B340-4B0AE3E253B6'
Global Enum $RESOURCE_STORAGE, $RESOURCE_STORAGE_FIRSTINDEX
Global Enum $RESOURCE_STORAGE_ID, $RESOURCE_STORAGE_INDEX, $RESOURCE_STORAGE_RESETCOUNT, $RESOURCE_STORAGE_UBOUND
Global Enum $RESOURCE_STORAGE_DLL, $RESOURCE_STORAGE_CASTRESTYPE, $RESOURCE_STORAGE_LENGTH, $RESOURCE_STORAGE_PTR, $RESOURCE_STORAGE_RESLANG, $RESOURCE_STORAGE_RESNAMEORID, $RESOURCE_STORAGE_RESTYPE, $RESOURCE_STORAGE_MAX, $RESOURCE_STORAGE_ADD, $RESOURCE_STORAGE_DESTROY, $RESOURCE_STORAGE_DESTROYALL, $RESOURCE_STORAGE_GET
Global Enum $RESOURCE_WINGETPOS_XPOS, $RESOURCE_WINGETPOS_YPOS, $RESOURCE_WINGETPOS_WIDTH, $RESOURCE_WINGETPOS_HEIGHT
Func _Resource_DestroyAll()
Return __Resource_Storage($RESOURCE_STORAGE_DESTROYALL, Null, Null, Null, Null, Null, Null, Null)
EndFunc
Func _Resource_GetAsBitmap($sResNameOrID, $iResType = $RT_RCDATA, $sDllOrExePath = Default)
Local $hHBITMAP = 0, $hBitmap = _Resource_GetAsImage($sResNameOrID, $iResType, $sDllOrExePath)
Local $iError = @error
Local $iLength = @extended
If $iError = $RESOURCE_ERROR_NONE And $iLength > 0 Then
$hHBITMAP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
If @error Then
$iError = $RESOURCE_ERROR_LOADBITMAP
Else
_GDIPlus_BitmapDispose($hBitmap)
$hBitmap = 0
EndIf
EndIf
If $iError <> $RESOURCE_ERROR_NONE Then $hHBITMAP = 0
Return SetError($iError, $iLength, $hHBITMAP)
EndFunc
Func _Resource_GetAsCursor($sResNameOrID, $iResType = $RT_RCDATA, $sDllOrExePath = Default)
Local $hCursor = __Resource_Get($sResNameOrID, $iResType, $RESOURCE_LANG_DEFAULT, $sDllOrExePath, $RT_CURSOR)
Local $iError = @error
Local $iLength = @extended
If $iError <> $RESOURCE_ERROR_NONE Then $hCursor = 0
Return SetError($iError, $iLength, $hCursor)
EndFunc
Func _Resource_GetAsIcon($sResNameOrID, $iResType = $RT_RCDATA, $sDllOrExePath = Default)
Local $hIcon = __Resource_Get($sResNameOrID, $iResType, $RESOURCE_LANG_DEFAULT, $sDllOrExePath, $RT_ICON)
Local $iError = @error
Local $iLength = @extended
If $iError <> $RESOURCE_ERROR_NONE Then $hIcon = 0
Return SetError($iError, $iLength, $hIcon)
EndFunc
Func _Resource_GetAsImage($sResNameOrID, $iResType = $RT_RCDATA, $sDllOrExePath = Default)
If $iResType = Default Then $iResType = $RT_RCDATA
Local $iError = $RESOURCE_ERROR_LOADIMAGE, $iLength = 0, $hBitmap = 0
Switch $iResType
Case $RT_BITMAP
Local $hHBITMAP = __Resource_Get($sResNameOrID, $RT_BITMAP, 0, $sDllOrExePath, $RT_BITMAP)
$iError = @error
$iLength = @extended
If $iError = $RESOURCE_ERROR_NONE And $iLength > 0 Then
$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBITMAP)
If @error Then
$iError = $RESOURCE_ERROR_LOADIMAGE
Else
EndIf
EndIf
Case Else
Local $pResource = __Resource_Get($sResNameOrID, $iResType, 0, $sDllOrExePath, $RT_RCDATA)
$iError = @error
$iLength = @extended
If $iError = $RESOURCE_ERROR_NONE And $iLength > 0 Then
$hBitmap = __Resource_ConvertToBitmap($pResource, $iLength)
EndIf
EndSwitch
Return SetError($iError, $iLength, $hBitmap)
EndFunc
Func _Resource_SetToCtrlID($iCtrlID, $sResNameOrID, $iResType = $RT_RCDATA, $sDllOrExePath = Default, $bResize = Default)
If $iResType = Default Then $iResType = $RT_RCDATA
Local $aWinGetPos = 0, $bDestroy = True, $bReturn = False, $iError = $RESOURCE_ERROR_INVALIDRESOURCETYPE, $iLength = 0, $vReturn = False
Local $hWnd = 0
__Resource_GetCtrlId($hWnd, $iCtrlID)
Switch $iResType
Case $RT_BITMAP, $RT_RCDATA
If StringStripWS($sResNameOrID, $STR_STRIPALL) = '' Or String($sResNameOrID) = '0' Then
$bReturn = __Resource_SetToCtrlID($iCtrlID, 0, $RT_BITMAP, True, False)
$iError = @error
Else
Local $hHBITMAP = _Resource_GetAsBitmap($sResNameOrID, $iResType, $sDllOrExePath)
$iError = @error
$iLength = @extended
If $iError = $RESOURCE_ERROR_NONE And $iLength > 0 Then
$bReturn = __Resource_SetToCtrlID($iCtrlID, $hHBITMAP, $RT_BITMAP, $bDestroy, $bResize)
$iError = @error
If $bReturn Then
If $__WINVER >= 0x0600 Then
$bReturn = _WinAPI_DeleteObject($hHBITMAP) > 0
$vReturn = $bReturn
Else
__Resource_Storage($RESOURCE_STORAGE_ADD, $sDllOrExePath, $hHBITMAP, $sResNameOrID, $iResType, Null, $iResType, $iLength)
$vReturn = $hHBITMAP
EndIf
EndIf
EndIf
EndIf
Case $RT_CURSOR
If StringStripWS($sResNameOrID, $STR_STRIPALL) = '' Or String($sResNameOrID) = '0' Then
$bReturn = __Resource_SetToCtrlID($iCtrlID, 0, $RT_CURSOR, True, False)
$iError = @error
Else
$bDestroy = False
Local $hCursor = 0
If $bResize Then
$aWinGetPos = WinGetPos($hWnd)
If Not @error Then
Local $aPos[$RESOURCE_POS_MAX]
$aPos[$RESOURCE_POS_H] = $aWinGetPos[$RESOURCE_WINGETPOS_HEIGHT]
$aPos[$RESOURCE_POS_W] = $aWinGetPos[$RESOURCE_WINGETPOS_WIDTH]
If $aPos[$RESOURCE_POS_H] = 0 And $aPos[$RESOURCE_POS_W] = 0 Then
GUICtrlSetImage($iCtrlID, @AutoItExe, 0)
$aWinGetPos = WinGetPos($hWnd)
If Not @error Then
$aPos[$RESOURCE_POS_H] = $aWinGetPos[$RESOURCE_WINGETPOS_HEIGHT]
$aPos[$RESOURCE_POS_W] = $aWinGetPos[$RESOURCE_WINGETPOS_WIDTH]
EndIf
EndIf
$hCursor = __Resource_Get($sResNameOrID, $RT_CURSOR, $RESOURCE_LANG_DEFAULT, $sDllOrExePath, $RT_CURSOR, $aPos)
$iError = @error
$iLength = @extended
EndIf
Else
$hCursor = _Resource_GetAsCursor($sResNameOrID, $iResType, $sDllOrExePath)
$iError = @error
$iLength = @extended
EndIf
If $iError = $RESOURCE_ERROR_NONE Then
$bReturn = __Resource_SetToCtrlID($iCtrlID, $hCursor, $RT_CURSOR, $bDestroy, $bResize)
EndIf
$hCursor = 0
$vReturn = $bReturn
EndIf
Case $RT_ICON
If StringStripWS($sResNameOrID, $STR_STRIPALL) = '' Or String($sResNameOrID) = '0' Then
$bReturn = __Resource_SetToCtrlID($iCtrlID, 0, $RT_ICON, True, False)
$iError = @error
Else
$bDestroy = False
Local $hIcon = 0
If $bResize Then
__Resource_GetCtrlId($hWnd, $iCtrlID)
$aWinGetPos = WinGetPos($hWnd)
If Not @error Then
Local $aPos[$RESOURCE_POS_MAX]
$aPos[$RESOURCE_POS_H] = $aWinGetPos[$RESOURCE_WINGETPOS_HEIGHT]
$aPos[$RESOURCE_POS_W] = $aWinGetPos[$RESOURCE_WINGETPOS_WIDTH]
If $aPos[$RESOURCE_POS_H] = 0 And $aPos[$RESOURCE_POS_W] = 0 Then
GUICtrlSetImage($iCtrlID, @AutoItExe, 0)
$aWinGetPos = WinGetPos($hWnd)
If Not @error Then
$aPos[$RESOURCE_POS_H] = $aWinGetPos[$RESOURCE_WINGETPOS_HEIGHT]
$aPos[$RESOURCE_POS_W] = $aWinGetPos[$RESOURCE_WINGETPOS_WIDTH]
EndIf
EndIf
$hIcon = __Resource_Get($sResNameOrID, $RT_ICON, $RESOURCE_LANG_DEFAULT, $sDllOrExePath, $RT_ICON, $aPos)
$iError = @error
$iLength = @extended
EndIf
Else
$hIcon = _Resource_GetAsIcon($sResNameOrID, $iResType, $sDllOrExePath)
$iError = @error
$iLength = @extended
EndIf
If $iError = $RESOURCE_ERROR_NONE Then
$bReturn = __Resource_SetToCtrlID($iCtrlID, $hIcon, $RT_ICON, $bDestroy, $bResize)
EndIf
$hIcon = 0
$vReturn = $bReturn
EndIf
EndSwitch
Return SetError($iError, $iLength, $vReturn)
EndFunc
Func __Resource_ConvertToBitmap($pResource, $iLength)
Local $hData = _MemGlobalAlloc($iLength, $GMEM_MOVEABLE)
Local $pData = _MemGlobalLock($hData)
_MemMoveMemory($pResource, $pData, $iLength)
_MemGlobalUnlock($hData)
Local $pStream = _WinAPI_CreateStreamOnHGlobal($hData)
Local $hBitmap = _GDIPlus_BitmapCreateFromStream($pStream)
_WinAPI_ReleaseStream($pStream)
Return $hBitmap
EndFunc
Func __Resource_Destroy($pResource, $iResType)
Local $bReturn = False
Switch $iResType
Case $RT_ANICURSOR, $RT_CURSOR
$bReturn = _WinAPI_DeleteObject($pResource) > 0
If Not $bReturn Then
$bReturn = _WinAPI_DestroyCursor($pResource) > 0
EndIf
Case $RT_BITMAP
$bReturn = _WinAPI_DeleteObject($pResource) > 0
Case $RT_FONT
$bReturn = True
Case $RT_ICON
$bReturn = _WinAPI_DeleteObject($pResource) > 0
If Not $bReturn Then
$bReturn = _WinAPI_DestroyIcon($pResource) > 0
EndIf
Case $RT_MENU
$bReturn = _GUICtrlMenu_DestroyMenu($pResource) > 0
Case $RT_STRING
$bReturn = True
Case $RESOURCE_RT_BITMAP
$bReturn = _GDIPlus_BitmapDispose($pResource) > 0
Case $RESOURCE_RT_ENHMETAFILE
$bReturn = _WinAPI_DeleteEnhMetaFile($pResource) > 0
Case $RESOURCE_RT_FONT
$bReturn = _WinAPI_RemoveFontMemResourceEx($pResource) > 0
Case Else
$bReturn = True
EndSwitch
If Not IsBool($bReturn) Then $bReturn = $bReturn > 0
Return $bReturn
EndFunc
Func __Resource_Get($sResNameOrID, $iResType = $RT_RCDATA, $iResLang = Default, $sDllOrExePath = Default, $iCastResType = Default, $aPos = Null)
If $iResType = $RT_RCDATA And StringStripWS($sResNameOrID, $STR_STRIPALL) = '' Then Return SetError($RESOURCE_ERROR_INVALIDRESOURCENAME, 0, Null)
If $iCastResType = Default Then $iCastResType = $iResType
If $iResLang = Default Then $iResLang = $RESOURCE_LANG_DEFAULT
If $iResType = Default Then $iResType = $RT_RCDATA
Local $iError = $RESOURCE_ERROR_NONE, $iLength = 0, $vResource = __Resource_Storage($RESOURCE_STORAGE_GET, $sDllOrExePath, Null, $sResNameOrID, $iResType, $iResLang, $iCastResType, Null)
$iLength = @extended
If $vResource Then
Return SetError($iError, $iLength, $vResource)
EndIf
Local $bIsInternal = False
Local $hInstance = __Resource_LoadModule($sDllOrExePath, $bIsInternal)
If Not $hInstance Then Return SetError($RESOURCE_ERROR_LOADLIBRARY, 0, 0)
Local $hResource =(($iResLang <> $RESOURCE_LANG_DEFAULT) ? _WinAPI_FindResourceEx($hInstance, $iResType, $sResNameOrID, $iResLang) : _WinAPI_FindResource($hInstance, $iResType, $sResNameOrID))
If @error <> $RESOURCE_ERROR_NONE Then $iError = $RESOURCE_ERROR_FINDRESOURCE
If $iError = $RESOURCE_ERROR_NONE Then
If $aPos = Null Then
Local $aTemp[$RESOURCE_POS_MAX] = [0, 0]
$aPos = $aTemp
$aTemp = 0
$aPos[$RESOURCE_POS_H] = 0
$aPos[$RESOURCE_POS_W] = 0
EndIf
$iLength = _WinAPI_SizeOfResource($hInstance, $hResource)
Switch $iCastResType
Case $RT_ANICURSOR, $RT_CURSOR
$vResource = _WinAPI_LoadImage($hInstance, $sResNameOrID, $IMAGE_CURSOR, $aPos[$RESOURCE_POS_W], $aPos[$RESOURCE_POS_H], $LR_DEFAULTCOLOR)
If @error <> $RESOURCE_ERROR_NONE Or Not $vResource Then $iError = $RESOURCE_ERROR_LOADCURSOR
Case $RT_BITMAP
$vResource = _WinAPI_LoadImage($hInstance, $sResNameOrID, $IMAGE_BITMAP, $aPos[$RESOURCE_POS_W], $aPos[$RESOURCE_POS_H], $LR_DEFAULTCOLOR)
If @error <> $RESOURCE_ERROR_NONE Or Not $vResource Then $iError = $RESOURCE_ERROR_LOADBITMAP
Case $RT_ICON
$vResource = _WinAPI_LoadImage($hInstance, $sResNameOrID, $IMAGE_ICON, $aPos[$RESOURCE_POS_W], $aPos[$RESOURCE_POS_H], $LR_DEFAULTCOLOR)
If @error <> $RESOURCE_ERROR_NONE Or Not $vResource Then $iError = $RESOURCE_ERROR_LOADICON
Case $RT_STRING
$vResource = _WinAPI_LoadString($hInstance, $sResNameOrID)
$iLength = @extended
If @error <> $RESOURCE_ERROR_NONE Then $iError = $RESOURCE_ERROR_LOADSTRING
Case Else
Local $hData = _WinAPI_LoadResource($hInstance, $hResource)
$vResource = _WinAPI_LockResource($hData)
$hData = 0
If Not $vResource Then $iError = $RESOURCE_ERROR_LOCKRESOURCE
EndSwitch
If $iError = $RESOURCE_ERROR_NONE Then
__Resource_Storage($RESOURCE_STORAGE_ADD, $sDllOrExePath, $vResource, $sResNameOrID, $iResType, $iResLang, $iCastResType, $iLength)
Else
$vResource = Null
EndIf
EndIf
__Resource_UnloadModule($hInstance, $bIsInternal)
Return SetError($iError, $iLength, $vResource)
EndFunc
Func __Resource_GetCtrlId(ByRef $hWnd, ByRef $iCtrlID)
If $iCtrlID = Default Or $iCtrlID <= 0 Or Not IsInt($iCtrlID) Then $iCtrlID = -1
$hWnd = GUICtrlGetHandle($iCtrlID)
If $hWnd And $iCtrlID = -1 Then
$iCtrlID = _WinAPI_GetDlgCtrlID($hWnd)
EndIf
Return True
EndFunc
Func __Resource_GetLastImage($iCtrlID, $hResource, $sClassName, ByRef $hPrevious, ByRef $iPreviousResType)
$hPrevious = 0
$iPreviousResType = 0
Local $aGetImage = 0, $bReturn = True, $iMsg_Get = 0
Switch $sClassName
Case 'Button'
Local $aButton = [[$IMAGE_BITMAP, $RT_BITMAP], [$IMAGE_ICON, $RT_ICON]]
$aGetImage = $aButton
$aButton = 0
$iMsg_Get = $BM_GETIMAGE
Case 'Static'
Local $aStatic = [[$IMAGE_BITMAP, $RT_BITMAP], [$IMAGE_CURSOR, $RT_CURSOR], [$IMAGE_ENHMETAFILE, $RESOURCE_RT_ENHMETAFILE], [$IMAGE_ICON, $RT_ICON]]
$aGetImage = $aStatic
$aStatic = 0
$iMsg_Get = $RESOURCE_STM_GETIMAGE
Case Else
$bReturn = False
EndSwitch
If $bReturn Then
Local Enum $eWPARAM, $eRESTYPE
For $i = 0 To UBound($aGetImage) - 1
$hPrevious = GUICtrlSendMsg($iCtrlID, $iMsg_Get, $aGetImage[$i][$eWPARAM], 0)
If $hPrevious <> 0 And $hPrevious <> $hResource Then
$iPreviousResType = $aGetImage[$i][$eRESTYPE]
ExitLoop
EndIf
Next
EndIf
Return $bReturn
EndFunc
Func __Resource_LoadModule(ByRef $sDllOrExePath, ByRef $bIsInternal)
$bIsInternal =($sDllOrExePath = Default Or $sDllOrExePath = -1)
If Not $bIsInternal And Not StringRegExp($sDllOrExePath, '\.(?:cpl|dll|exe)$') Then
$bIsInternal = True
EndIf
Return($bIsInternal ? _WinAPI_GetModuleHandle(Null) : _WinAPI_LoadLibraryEx($sDllOrExePath, $LOAD_LIBRARY_AS_DATAFILE))
EndFunc
Func __Resource_UnloadModule(ByRef $hInstance, ByRef $bIsInternal)
Local $bReturn = True
If $bIsInternal And $hInstance Then
$bReturn = _WinAPI_FreeLibrary($hInstance)
EndIf
Return $bReturn
EndFunc
Func __Resource_SetToCtrlID($iCtrlID, $hResource, $iResType, $bDestroy, $bResize)
Local $bReturn = False, $iError = $RESOURCE_ERROR_SETIMAGE
Local $hWnd = 0
__Resource_GetCtrlId($hWnd, $iCtrlID)
$iError = $RESOURCE_ERROR_INVALIDCONTROLID
If $hWnd And $iCtrlID > 0 Then
Local $aStyles[0]
$bReturn = True
$iError = $RESOURCE_ERROR_NONE
Local $iMsg_Set = 0, $iStyle = 0, $wParam = 0
Local $sClassName = _WinAPI_GetClassName($iCtrlID)
Switch $sClassName
Case 'Button'
Local $aButtonStyles = [$BS_BITMAP, $BS_ICON]
$aStyles = $aButtonStyles
$aButtonStyles = 0
$iMsg_Set = $BM_SETIMAGE
Switch $iResType
Case $RT_BITMAP
$iStyle = $BS_BITMAP
$wParam = $IMAGE_BITMAP
$bResize = False
Case $RT_ICON
$iStyle = $BS_ICON
$wParam = $IMAGE_ICON
$bResize = False
Case Else
$bReturn = False
$iError = $RESOURCE_ERROR_INVALIDRESOURCETYPE
EndSwitch
Case 'Static'
Local $aStaticStyles = [$SS_BITMAP, $SS_ICON, $RESOURCE_SS_ENHMETAFILE]
$aStyles = $aStaticStyles
$aStaticStyles = 0
$iMsg_Set = $RESOURCE_STM_SETIMAGE
Switch $iResType
Case $RT_BITMAP
$iStyle = $SS_BITMAP
$wParam = $IMAGE_BITMAP
Case $RT_CURSOR
$iStyle = $SS_ICON
$wParam = $IMAGE_CURSOR
Case $RESOURCE_RT_ENHMETAFILE
$iStyle = $RESOURCE_SS_ENHMETAFILE
$wParam = $IMAGE_ENHMETAFILE
Case $RT_ICON
$iStyle = $SS_ICON
$wParam = $IMAGE_ICON
Case Else
$bReturn = False
$iError = $RESOURCE_ERROR_INVALIDRESOURCETYPE
EndSwitch
Case Else
$bReturn = False
$iError = $RESOURCE_ERROR_INVALIDCLASS
EndSwitch
If $bReturn Then
Local $iCurrentStyle = _WinAPI_GetWindowLong($hWnd, $GWL_STYLE)
If Not @error Then
For $i = 0 To UBound($aStyles) - 1
If BitAND($aStyles[$i], $iCurrentStyle) Then
$iCurrentStyle = BitXOR($iCurrentStyle, $aStyles[$i])
EndIf
Next
If $bResize Then
_WinAPI_SetWindowLong($hWnd, $GWL_STYLE, BitOR($iCurrentStyle, $RESOURCE_SS_REALSIZECONTROL, $iStyle))
Else
_WinAPI_SetWindowLong($hWnd, $GWL_STYLE, BitOR($iCurrentStyle, $iStyle))
EndIf
EndIf
Local $hPrevious = 0, $iPreviousResType = 0
__Resource_GetLastImage($iCtrlID, $hResource, $sClassName, $hPrevious, $iPreviousResType)
GUICtrlSendMsg($iCtrlID, $iMsg_Set, $wParam, $hResource)
If $iPreviousResType Then
__Resource_Destroy($hPrevious, $iPreviousResType)
__Resource_Storage($RESOURCE_STORAGE_DESTROY, Null, $hPrevious, Null, Null, Null, Null, Null)
If $bDestroy = Default Or $bDestroy Then
__Resource_Destroy($hResource, $iResType)
__Resource_Storage($RESOURCE_STORAGE_DESTROY, Null, $hResource, Null, Null, Null, Null, Null)
EndIf
_WinAPI_InvalidateRect($hWnd, 0, True)
_WinAPI_UpdateWindow($hWnd)
Else
$bReturn = False
$iError = $RESOURCE_ERROR_SETIMAGE
EndIf
EndIf
EndIf
Return SetError($iError, 0, $bReturn)
EndFunc
Func __Resource_Storage($iAction, $sDllOrExePath, $pResource, $sResNameOrID, $iResType, $iResLang, $iCastResType, $iLength)
Local Static $aStorage[$RESOURCE_STORAGE_FIRSTINDEX][$RESOURCE_STORAGE_MAX]
Local $bReturn = False
Switch $iAction
Case $RESOURCE_STORAGE_ADD
If Not($aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_ID] = $RESOURCE_STORAGE_GUID) Then
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_ID] = $RESOURCE_STORAGE_GUID
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX] = 0
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_RESETCOUNT] = 0
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_UBOUND] = $RESOURCE_STORAGE_FIRSTINDEX
EndIf
If Not($pResource = Null) And Not __Resource_Storage($RESOURCE_STORAGE_GET, $sDllOrExePath, Null, $sResNameOrID, $iResType, $iResLang, $iCastResType, Null) Then
$bReturn = True
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX] += 1
If $aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX] >= $aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_UBOUND] Then
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_UBOUND] = Ceiling($aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX] * 1.3)
ReDim $aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_UBOUND]][$RESOURCE_STORAGE_MAX]
EndIf
$aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]][$RESOURCE_STORAGE_DLL] = $sDllOrExePath
$aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]][$RESOURCE_STORAGE_PTR] = $pResource
$aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]][$RESOURCE_STORAGE_RESLANG] = $iResLang
$aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]][$RESOURCE_STORAGE_RESNAMEORID] = $sResNameOrID
$aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]][$RESOURCE_STORAGE_RESTYPE] = $iResType
$aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]][$RESOURCE_STORAGE_CASTRESTYPE] = $iCastResType
$aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]][$RESOURCE_STORAGE_LENGTH] = $iLength
EndIf
Case $RESOURCE_STORAGE_DESTROY
Local $iDestoryCount = 0, $iDestoryed = 0
For $i = $RESOURCE_STORAGE_FIRSTINDEX To $aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]
If Not($aStorage[$i][$RESOURCE_STORAGE_PTR] = Null) Then
If $aStorage[$i][$RESOURCE_STORAGE_PTR] = $pResource Or($aStorage[$i][$RESOURCE_STORAGE_DLL] = $sDllOrExePath And $aStorage[$i][$RESOURCE_STORAGE_RESNAMEORID] = $sResNameOrID And $aStorage[$i][$RESOURCE_STORAGE_RESTYPE] = $iResType And $aStorage[$i][$RESOURCE_STORAGE_CASTRESTYPE] = $iCastResType) Then
$bReturn = __Resource_Storage_Destroy($aStorage, $i)
If $bReturn Then
$iDestoryed += 1
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_RESETCOUNT] += 1
EndIf
$iDestoryCount += 1
EndIf
EndIf
Next
$bReturn = $iDestoryCount = $iDestoryed
If $aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_RESETCOUNT] >= 20 Then
Local $iIndex = 0
For $i = $RESOURCE_STORAGE_FIRSTINDEX To $aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]
If Not($aStorage[$i][$RESOURCE_STORAGE_PTR] = Null) Then
$iIndex += 1
For $j = 0 To $RESOURCE_STORAGE_MAX - 1
$aStorage[$iIndex][$j] = $aStorage[$i][$j]
Next
EndIf
Next
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX] = $iIndex
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_RESETCOUNT] = 0
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_UBOUND] = $iIndex + $RESOURCE_STORAGE_FIRSTINDEX
ReDim $aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_UBOUND]][$RESOURCE_STORAGE_MAX]
EndIf
Case $RESOURCE_STORAGE_DESTROYALL
$bReturn = True
For $i = $RESOURCE_STORAGE_FIRSTINDEX To $aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX]
__Resource_Storage_Destroy($aStorage, $i)
Next
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_INDEX] = 0
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_RESETCOUNT] = 0
$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_UBOUND] = $RESOURCE_STORAGE_FIRSTINDEX
ReDim $aStorage[$aStorage[$RESOURCE_STORAGE][$RESOURCE_STORAGE_UBOUND]][$RESOURCE_STORAGE_MAX]
Case $RESOURCE_STORAGE_GET
Local $iExtended = 0, $pReturn = Null
Return SetExtended($iExtended, $pReturn)
EndSwitch
Return $bReturn
EndFunc
Func __Resource_Storage_Destroy(ByRef $aStorage, $iIndex)
Local $bReturn = False
If Not($aStorage[$iIndex][$RESOURCE_STORAGE_PTR] = Null) Then
$bReturn = __Resource_Destroy($aStorage[$iIndex][$RESOURCE_STORAGE_PTR], $aStorage[$iIndex][$RESOURCE_STORAGE_RESTYPE])
If $bReturn Then
$aStorage[$iIndex][$RESOURCE_STORAGE_PTR] = Null
$aStorage[$iIndex][$RESOURCE_STORAGE_RESLANG] = Null
$aStorage[$iIndex][$RESOURCE_STORAGE_RESNAMEORID] = Null
$aStorage[$iIndex][$RESOURCE_STORAGE_RESTYPE] = Null
EndIf
EndIf
Return $bReturn
EndFunc
Func _WinAPI_SetWindowLong($hWnd, $iIndex, $iValue)
_WinAPI_SetLastError(0)
Local $sFuncName = "SetWindowLongW"
If @AutoItX64 Then $sFuncName = "SetWindowLongPtrW"
Local $aResult = DllCall("user32.dll", "long_ptr", $sFuncName, "hwnd", $hWnd, "int", $iIndex, "long_ptr", $iValue)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _END()
Exit
EndFunc
Global $ProgramName = "Array-Font Creator"
Global $ProgramVersion = "V1.0"
Global $BoxArray[0]
Global $BoxStates[0]
Global $LastCharacterInput = "Character"
Func DrawMainGUI()
Global $MainGUI = GUICreate($ProgramName & " " & $ProgramVersion,475,301,-1,-1)
Global $MainGUIInputCharacterName = GUICtrlCreateInput("Character",25,3,100,20)
Global $MainGUIButtonClear = GUICtrlCreateButton("Clear",127,3,100,20)
Local $ArrayCount = 0
For $B = 0 To 4 Step 1
For $I = 0 To 3 Step 1
ReDim $BoxArray[UBound($BoxArray) + 1]
ReDim $BoxStates[UBound($BoxStates) + 1]
$BoxArray[$ArrayCount] = GUICtrlCreatePic("",26 +(50 * $I),26 +(50 * $B))
$BoxStates[$ArrayCount] = False
_Resource_SetToCtrlID($BoxArray[$ArrayCount],"WhiteImg")
$ArrayCount = $ArrayCount + 1
Next
Next
GUICtrlCreateGraphic(25,25,200,1,$SS_BLACKRECT)
GUICtrlCreateGraphic(25,75,200,1,$SS_BLACKRECT)
GUICtrlCreateGraphic(25,125,200,1,$SS_BLACKRECT)
GUICtrlCreateGraphic(25,175,200,1,$SS_BLACKRECT)
GUICtrlCreateGraphic(25,225,200,1,$SS_BLACKRECT)
GUICtrlCreateGraphic(25,275,200,1,$SS_BLACKRECT)
GUICtrlCreateGraphic(25,25,1,250,$SS_BLACKRECT)
GUICtrlCreateGraphic(75,25,1,250,$SS_BLACKRECT)
GUICtrlCreateGraphic(125,25,1,250,$SS_BLACKRECT)
GUICtrlCreateGraphic(175,25,1,250,$SS_BLACKRECT)
GUICtrlCreateGraphic(225,25,1,250,$SS_BLACKRECT)
Global $MainGUILabelOutput = GUICtrlCreateLabel("Output: ",250,10,-1,13)
Global $MainGUIEditOutput = GUICtrlCreateEdit("",250,25,200,251)
GUICtrlSetFont(-1,8.5,500,0,"Consolas")
GUISetState()
EndFunc
DrawMainGUI()
Func CreateNewOutput()
Local $NewOutput = "///////////////"&@CRLF&"("
For $A = 0 To 4 Step 1
For $B = 0 To 3 Step 1
If $BoxStates[($A*4) + $B] Then
If $B = 0 Then
$NewOutput = $NewOutput & "1"
Else
$NewOutput = $NewOutput & " 1"
EndIf
Else
If $B = 0 Then
$NewOutput = $NewOutput & "0"
Else
$NewOutput = $NewOutput & " 0"
EndIf
EndIf
If($A*4) + $B <> UBound($BoxStates) - 1 Then $NewOutput = $NewOutput & ","
Next
If $A = 1 Then $NewOutput = $NewOutput & " //#" & GUICtrlRead($MainGUIInputCharacterName) & @CRLF & " "
If $A <> 4 and $A <> 1 Then $NewOutput = $NewOutput & " // " & @CRLF & " "
Next
$NewOutput = $NewOutput & "),//"
GUICtrlSetData($MainGUIEditOutput,$NewOutput)
EndFunc
Global $LastGUIMsg
Func CheckPicStateChange()
For $I = 0 To UBound($BoxArray) - 1 Step 1
If $LastGUIMsg = $BoxArray[$I] Then
$BoxStates[$I] =(Not $BoxStates[$I])
If Not $BoxStates[$I] Then
_Resource_SetToCtrlID($BoxArray[$I],"WhiteImg")
Else
_Resource_SetToCtrlID($BoxArray[$I],"BlackImg")
EndIf
CreateNewOutput()
ExitLoop
EndIf
Next
EndFunc
While True
$LastGUIMsg = GUIGetMsg()
CheckPicStateChange()
Local $CacheInput = GUICtrlRead($MainGUIInputCharacterName)
If $CacheInput <> $LastCharacterInput Then
$LastCharacterInput = $CacheInput
CreateNewOutput()
EndIf
Switch $LastGUIMsg
Case $MainGUIButtonClear
GUICtrlSetData($MainGUIInputCharacterName,"Character")
For $I = 0 To UBound($BoxStates) - 1 Step 1
$BoxStates[$I] = False
_Resource_SetToCtrlID($BoxArray[$I],"WhiteImg")
Next
CreateNewOutput()
Case $GUI_EVENT_CLOSE
_END()
EndSwitch
Sleep(1)
WEnd
