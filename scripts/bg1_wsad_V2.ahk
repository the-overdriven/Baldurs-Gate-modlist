#HotIf WinActive("Baldur's Gate - Enhanced Edition - v2.6.6.0")

; Get screen resolution
ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

; Calculate the middle of the screen, but treat it as 50px lower
CenterX := ScreenWidth / 2
CenterY := (ScreenHeight / 2) + 50  ; Adjust center 50px lower

; Variables to handle throttling (100ms cooldown)
lastPressTimeW := 0
lastPressTimeA := 0
lastPressTimeS := 0
lastPressTimeD := 0
cooldown := 100  ; 100 milliseconds

; Set up hotkeys for W, A, S, D
w::
{
    global lastPressTimeW  ; Explicitly declare the variable as global
    currentTime := A_TickCount
    if (currentTime - lastPressTimeW > cooldown) {
        lastPressTimeW := currentTime
        
        ; Save original mouse position
        MouseGetPos(&originalX, &originalY)  ; Use parentheses and pass by reference
        
        MouseMove(CenterX, CenterY - 400, 0)
        Click("R")  ; Right-click
        
        ; Restore original mouse position
        MouseMove(originalX, originalY, 0)
    }
}

s::
{
    global lastPressTimeS  ; Explicitly declare the variable as global
    currentTime := A_TickCount
    if (currentTime - lastPressTimeS > cooldown) {
        lastPressTimeS := currentTime
        
        ; Save original mouse position
        MouseGetPos(&originalX, &originalY)  ; Use parentheses and pass by reference
        
        MouseMove(CenterX, CenterY + 280, 0)
        Click("R")  ; Right-click
        
        ; Restore original mouse position
        MouseMove(originalX, originalY, 0)
    }
}

a::
{
    global lastPressTimeA  ; Explicitly declare the variable as global
    currentTime := A_TickCount
    if (currentTime - lastPressTimeA > cooldown) {
        lastPressTimeA := currentTime
        
        ; Save original mouse position
        MouseGetPos(&originalX, &originalY)  ; Use parentheses and pass by reference
        
        MouseMove(CenterX - 500, CenterY, 0)
        Click("R")  ; Right-click
        
        ; Restore original mouse position
        MouseMove(originalX, originalY, 0)
    }
}

d::
{
    global lastPressTimeD  ; Explicitly declare the variable as global
    currentTime := A_TickCount
    if (currentTime - lastPressTimeD > cooldown) {
        lastPressTimeD := currentTime
        
        ; Save original mouse position
        MouseGetPos(&originalX, &originalY)  ; Use parentheses and pass by reference
        
        MouseMove(CenterX + 500, CenterY, 0)
        Click("R")  ; Right-click
        
        ; Restore original mouse position
        MouseMove(originalX, originalY, 0)
    }
}

#HotIf
