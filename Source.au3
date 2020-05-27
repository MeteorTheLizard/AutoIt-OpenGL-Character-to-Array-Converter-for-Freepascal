#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Prog.ico
#AutoIt3Wrapper_Outfile=Font Generator X86.exe
#AutoIt3Wrapper_Outfile_x64=Font Generator X64.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_File_Add=Resource\White.jpg, RT_RCDATA, WhiteImg, 0
#AutoIt3Wrapper_Res_File_Add=Resource\Black.jpg, RT_RCDATA, BlackImg, 0
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Include <GUIConstants.au3>
#Include <GuiConstantsEx.au3>
#Include <ResourcesEx.au3>
#Include <WinAPISysWin.au3> ;- Required for ResourcesEx.au3 to function (The UDF is outdated)

;~ HotKeySet("{F5}","_END")
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

	;-Boxes
	Local $ArrayCount = 0
	For $B = 0 To 4 Step 1
		For $I = 0 To 3 Step 1
			ReDim $BoxArray[UBound($BoxArray) + 1]
			ReDim $BoxStates[UBound($BoxStates) + 1]

			$BoxArray[$ArrayCount] = GUICtrlCreatePic("",26 + (50 * $I),26 + (50 * $B))
			$BoxStates[$ArrayCount] = False
			_Resource_SetToCtrlID($BoxArray[$ArrayCount],"WhiteImg")

			$ArrayCount = $ArrayCount + 1
		Next
	Next

	;- Horizontal Lines
	GUICtrlCreateGraphic(25,25,200,1,$SS_BLACKRECT)
	GUICtrlCreateGraphic(25,75,200,1,$SS_BLACKRECT)
	GUICtrlCreateGraphic(25,125,200,1,$SS_BLACKRECT)
	GUICtrlCreateGraphic(25,175,200,1,$SS_BLACKRECT)
	GUICtrlCreateGraphic(25,225,200,1,$SS_BLACKRECT)
	GUICtrlCreateGraphic(25,275,200,1,$SS_BLACKRECT)

	;- Vertical Lines
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

Func CreateNewOutput() ;- This function is extremely messy and requires a cleanup. It works though! (blegh)
	Local $NewOutput = "///////////////"&@CRLF&"("
	For $A = 0 To 4 Step 1
		For $B = 0 To 3 Step 1
			If $BoxStates[($A*4) + $B] Then
				If $B = 0 Then ;- If only this would work: ($B = 0 And "1" Or " 1") - To bad It's not lua.
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

			If ($A*4) + $B <> UBound($BoxStates) - 1 Then $NewOutput = $NewOutput & ","
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
			$BoxStates[$I] = (Not $BoxStates[$I])

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
	$LastGUIMsg = GUIGetMsg() ;- Calling GUIGetMsg twice in one frame is bad!!
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