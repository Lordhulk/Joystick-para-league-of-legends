
If WinExist("ahk_class RiotWindowClass")


{
	WinActivate, ahk_class RiotWindowClass
	
JoyMultiplier = 0.50

JoyThreshold = 3

InvertYAxis := false

ButtonLeft = 1
ButtonRight = 2
ButtonA = 3
ButtonBack = 4
ButtonQ = 5
ButtonW = 6
ButtonE = 7
ButtonR = 8
Buttonselect = 9
Buttontienda = 10
ButtonF = 11
ButtonD = 12


JoystickNumber = 1


#SingleInstance force
#Persistent
CoordMode,Mouse,Window
CoordMode,Pixel,Window



JoystickPrefix = %JoystickNumber%Joy
Hotkey, %JoystickPrefix%%ButtonLeft%, ButtonLeft
Hotkey, %JoystickPrefix%%ButtonRight%, ButtonRight
Hotkey, %JoystickPrefix%%ButtonBack%, ButtonBack
Hotkey, %JoystickPrefix%%ButtonA%, ButtonA
Hotkey, %JoystickPrefix%%ButtonQ%, ButtonQ
Hotkey, %JoystickPrefix%%ButtonD%, ButtonD
Hotkey, %JoystickPrefix%%ButtonF%, ButtonF
Hotkey, %JoystickPrefix%%ButtonW%, ButtonW
Hotkey, %JoystickPrefix%%ButtonE%, ButtonE
Hotkey, %JoystickPrefix%%ButtonR%, ButtonR
Hotkey, %JoystickPrefix%%Buttontienda%, Buttontienda


; Calculate the axis displacements that are needed to start moving the cursor:
JoyThresholdUpper := 50 + JoyThreshold
JoyThresholdLower := 50 - JoyThreshold
if InvertYAxis
    YAxisMultiplier = -1
else
    YAxisMultiplier = 1

SetTimer, WatchJoystick, 10  ; Monitor the movement of the joystick.
SetTimer, WatchPOV, 5
SetTimer, WatchJoystick2, 10 ;<-------------cambio

return  ; End of auto-execute section.



ButtonA:

Send {a down}{a up}
sleep 10
MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
sleep 10
MouseClick, left,,, 1, 0, U  ; Release the mouse button.
return


ButtonD:
Send {d down}{d up}
sleep 10
MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
sleep 10
MouseClick, left,,, 1, 0, U  ; Release the mouse button.
return


ButtonBack:
Send {b down}{b up}
return

Buttontienda:
Send {p down}{p up}
return


ButtonF:
Send {F down}{F up}
return

ButtonQ:
GetKeyState ,select , %JoystickPrefix%%Buttonselect%
if select=D
Send ^{q}

else {
Send {Q down}{Q up}
sleep 10
MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
sleep 10
MouseClick, left,,, 1, 0, U  ; Release the mouse button.
}
return



ButtonW:
GetKeyState ,select , %JoystickPrefix%%Buttonselect%
if select=D
Send ^{w}
else {
Send {W down}{W up}
sleep 10
MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
sleep 10
MouseClick, left,,, 1, 0, U  ; Release the mouse button.
}
return


ButtonE:
GetKeyState ,select , %JoystickPrefix%%Buttonselect%
if select=D
Send ^{e}

else {
Send {E down}{E up}
sleep 10
MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
sleep 10
MouseClick, left,,, 1, 0, U  ; Release the mouse button.
}
return


ButtonR:
GetKeyState ,select , %JoystickPrefix%%Buttonselect%
if select=D
Send ^{r}

else {
Send {R down}{R up}
sleep 10
MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
sleep 10
MouseClick, left,,, 1, 0, U  ; Release the mouse button.
}
return


ButtonLeft:
SetMouseDelay, -1  ; Makes movement smoother.
MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
SetTimer, WaitForLeftButtonUp, 10
return

ButtonRight:
SetMouseDelay, -1  ; Makes movement smoother.
MouseClick, right,,, 1, 0, D  ; Hold down the right mouse button.
SetTimer, WaitForRightButtonUp, 10
return


WaitForLeftButtonUp:
if GetKeyState(JoystickPrefix . ButtonLeft)
    return  ; The button is still, down, so keep waiting.
; Otherwise, the button has been released.
SetTimer, WaitForLeftButtonUp, off
SetMouseDelay, -1  ; Makes movement smoother.
MouseClick, left,,, 1, 0, U  ; Release the mouse button.
return

WaitForRightButtonUp:
if GetKeyState(JoystickPrefix . ButtonRight)
    return  ; The button is still, down, so keep waiting.
; Otherwise, the button has been released.
SetTimer, WaitForRightButtonUp, off
MouseClick, right,,, 1, 0, U  ; Release the mouse button.
return

WatchJoystick:
MouseNeedsToBeMoved := false  ; Set default.
SetFormat, float, 03
GetKeyState, joyx, %JoystickNumber%JoyX
GetKeyState, joyy, %JoystickNumber%JoyY
if joyx > %JoyThresholdUpper%
{
    MouseNeedsToBeMoved := true
    DeltaX := joyx - JoyThresholdUpper
	
}
else if joyx < %JoyThresholdLower%
{
    MouseNeedsToBeMoved := true
    DeltaX := joyx - JoyThresholdLower
}
else
    DeltaX = 0
if joyy > %JoyThresholdUpper%
{
    MouseNeedsToBeMoved := true
    DeltaY := joyy - JoyThresholdUpper
}
else if joyy < %JoyThresholdLower%
{
    MouseNeedsToBeMoved := true
    DeltaY := joyy - JoyThresholdLower
}
else
    DeltaY = 0
if MouseNeedsToBeMoved
{
    SetMouseDelay, -1  ; Makes movement smoother.
    MouseMove, DeltaX * JoyMultiplier, DeltaY * JoyMultiplier * YAxisMultiplier, 0, R
   ; MouseClick, right,,, 1, 0, D  ; Hold down the right mouse button.;ESTO HACE CLIK SEGUIDO
}
return

WatchJoystick2:

GetKeyState, joyZ, %JoystickNumber%JoyZ
GetKeyState, joyR, %JoystickNumber%JoyR

if  joyZ < 10 
{
	
	MouseMove, 750, 540
	;MouseClick, right,,, 1, 0, D
	;sleep 2
	;MouseClick, right,,, 1, 0, U
}
else if  joyZ > 90
{
	MouseMove, 1150, 540
	;MouseClick, right,,, 1, 0, D
	;sleep 2
	;MouseClick, right,,, 1, 0, U
}
else if  joyR < 10
{
	MouseMove, 960, 350
	;MouseClick, right,,, 1, 0, D
	;sleep 2
	MouseClick, right,,, 1, 0, U
}
else if  joyR > 90
{
	MouseMove, 960, 750
	;MouseClick, right,,, 1, 0, D
	;sleep 2
	;MouseClick, right,,, 1, 0, U
}
else
wasa=0


return

WatchPOV:
GetKeyState, POV, JoyPOV  ; Get position of the POV control.

if POV < 0   ; No angle to report
	wasa =
else if POV > 31500                 ; 315 to 360 degrees: Forward
    Send {1 down} {1 up}
else if POV between 0 and 4500      ; 0 to 45 degrees: Forward
     Send {1 down} {1 up}
else if POV between 4501 and 13500  ; 45 to 135 degrees: Right
     Send {2 down} {2 up}
else if POV between 13501 and 22500 ; 135 to 225 degrees: Down
 Send {3 down} {3 up}
else                                ; 225 to 315 degrees: Left
    Send {4 down} {4 up}
    return  ; Do nothing.


}