;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Alice Ferrazzi <alice.ferrazzi@gmail.com>
;
; Script Function:
;	Simple personal script for doing pomodoro. And send email to beeminder.
;   Please take care that is completing blocking the pc during pomodoro.
;

;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance,Force

applicationname=BlockInput

; TODO: make possible to send comment. as now escaping " with "" looks not working.
; more info here: https://www.beeminder.com/faq#qcut
;
sendMail("bot@beeminder.com","your-password","your-email","yourbeeminderusername/yourgoalname","^ 1 ")

sendMail(emailToAddress,emailPass,emailFromAddress,emailSubject,emailMessage)
	{
	global
	IfNotExist, %A_MyDocuments%\mailsend1.17b12.exe
		{
		URLDownloadToFile, https://mailsend.googlecode.com/files/mailsend1.17b12.exe, %A_MyDocuments%\mailsend1.17b12.exe
		}
	Run, %A_MyDocuments%\mailsend1.17b12.exe -to %emailToAddress% -from %emailFromAddress% -ssl -smtp smtp.gmail.com -port 465 -sub "%emailSubject%" -M "%emailMessage%" +cc +bc -q -auth-plain -user "%emailFromAddress%" -pass "%emailPass%"
	WinWait, %A_MyDocuments%\mailsend1.17b12.exe
	IfWinExist, %A_MyDocuments%\mailsend1.17b12.exe
		{
		WinHide
		}
	}
ExitApp
TryAgain:
focus_time = 0


InputBox, choice , Input Box Using Choices, Enter your choice number.`n(1) focus 25min`, (2) focus 40min`, (3) focus 180min
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
{     MsgBox 0,,focus 180min
	  focus_time_sec := 180 * 60
	  
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
