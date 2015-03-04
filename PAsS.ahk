;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Alice Ferrazzi <alice.ferrazzi@gmail.com>
;
; Script Function:
;	simple personal script for doing 25min pomodoro.
;

;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance,Force

applicationname=BlockInput

TryAgain:
focus_time = 0

InputBox, choice , Input Box Using Choices, Enter your choice number.`n(1) focus 25min`, (2) focus 40min`, (3) focus 5min
If Errorlevel
{    MsgBox,0,, You entered no choice. Please try again.
     goto TryAgain
}
If (Choice = 1)
{     MsgBox 0,,You selected focus for 25min
	  focus_time_sec := 25 * 60
}
If (Choice = 2)
{     MsgBox 0,,You selected focus for 40min
      focus_time_sec := 40 * 60
}
If (choice = 3)
{     MsgBox 0,,focus 5min
	  focus_time_sec := 5 * 60
	  
}
If (goodchoice = 0)
{     MsgBox 0,,You entered %choice% <-- an invalid response. Please try again.
      Goto TryAgain
}  
focus_time_min := (focus_time_sec//60)

; focus time
MsgBox Blocking input for %focus_time_min%m
BlockInput,On
Loop, %focus_time_sec%
{
	ToolTip, BlockInput resumes in %focus_time_sec% seconds
	focus_time_sec -= 1
	Sleep, 1000
}
ToolTip
BlockInput,Off

; 5min break
counter:= 5
MsgBox Take a rest for %counter%m
Loop, %counter%
{
	ToolTip, Break for %counter%m
	counter -= 1
	Sleep, 60000
}
ToolTip
Goto TryAgain
;Return
ExitApp