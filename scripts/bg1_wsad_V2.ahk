#HotIf WinActive("Baldur's Gate - Enhanced Edition - v2.6.6.0")
#Include bg1_wsad_V2_Gdip_All.ahk

if !(pToken := Gdip_Startup()) {
    MsgBox("GDI+ failed to start")
    ExitApp
}

ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

CenterX := ScreenWidth / 2
CenterY := (ScreenHeight / 2) + 50 ; Adjust center 50px lower

RegionX := 0
RegionY := 0
RegionWidth := 300
RegionHeight := 100

lastPressTimeW := 0
lastPressTimeA := 0
lastPressTimeS := 0
lastPressTimeD := 0
cooldown := 100 ; 100 milliseconds

w:: {
    global lastPressTimeW
    currentTime := A_TickCount
    if (currentTime - lastPressTimeW > cooldown) {
        lastPressTimeW := currentTime
        
        MouseGetPos(&originalX, &originalY)
        MouseMove(CenterX, CenterY - 400, 0)
        Click("R")
        MouseMove(originalX, originalY, 0)
        
        if (CheckScreenUnchanged()) {
            MouseGetPos(&originalX, &originalY)
            MouseMove(CenterX, CenterY - 50, 0)
            Click("R")
            MouseMove(originalX, originalY, 0)
        }
    }
}

s:: {
    global lastPressTimeS
    currentTime := A_TickCount
    if (currentTime - lastPressTimeS > cooldown) {
        lastPressTimeS := currentTime
        
        MouseGetPos(&originalX, &originalY)
        MouseMove(CenterX, CenterY + 280, 0)
        Click("R")
        MouseMove(originalX, originalY, 0)
        
        if (CheckScreenUnchanged()) {
            MouseGetPos(&originalX, &originalY)
            MouseMove(CenterX, CenterY + 50, 0)
            Click("R")
            MouseMove(originalX, originalY, 0)
        }
    }
}

a:: {
    global lastPressTimeA
    currentTime := A_TickCount
    if (currentTime - lastPressTimeA > cooldown) {
        lastPressTimeA := currentTime
        
        MouseGetPos(&originalX, &originalY)
        MouseMove(CenterX - 500, CenterY, 0)
        Click("R")
        MouseMove(originalX, originalY, 0)
        
        if (CheckScreenUnchanged()) {
            MouseGetPos(&originalX, &originalY)
            MouseMove(CenterX - 50, CenterY, 0)
            Click("R")
            MouseMove(originalX, originalY, 0)
        }
    }
}

d:: {
    global lastPressTimeD
    currentTime := A_TickCount
	
    if (currentTime - lastPressTimeD > cooldown) {
        lastPressTimeD := currentTime
        
        MouseGetPos(&originalX, &originalY)
        MouseMove(CenterX + 500, CenterY, 0)
        Click("R")
        MouseMove(originalX, originalY, 0)
        
        if (CheckScreenUnchanged()) {
            MouseGetPos(&originalX, &originalY)
            MouseMove(CenterX + 50, CenterY, 0)
            Click("R")
            MouseMove(originalX, originalY, 0)
        }
    }
}

CheckScreenUnchanged() {
    BeforeBitmap := CaptureScreen(RegionX, RegionY, RegionWidth, RegionHeight)
    ;Gdip_SaveBitmapToFile(BeforeBitmap, "C:\BeforeBitmap.png")
	
    Sleep(50)  ; Short delay to allow for screen changes
	
    AfterBitmap := CaptureScreen(RegionX, RegionY, RegionWidth, RegionHeight)
    ;Gdip_SaveBitmapToFile(AfterBitmap, "C:\AfterBitmap.png")

    result := Gdip_CompareBitmap(BeforeBitmap, AfterBitmap)
    
    Gdip_DisposeImage(BeforeBitmap)
    Gdip_DisposeImage(AfterBitmap)
    
    return result
}

CaptureScreen(x, y, width, height) {
    return Gdip_BitmapFromScreen(x "|" y "|" width "|" height)
}

Gdip_CompareBitmap(bitmap1, bitmap2) {
    w1 := Gdip_GetImageWidth(bitmap1)
    h1 := Gdip_GetImageHeight(bitmap1)
    w2 := Gdip_GetImageWidth(bitmap2)
    h2 := Gdip_GetImageHeight(bitmap2)

    ; Ensure that the bitmaps are of the same dimensions
    if (w1 != w2 || h1 != h2) {
        return false
    }

    x := 0
    y := 0

    while (y < h1) {
        while (x < w1) {
            pixel1 := Gdip_GetPixel(bitmap1, x, y)
            pixel2 := Gdip_GetPixel(bitmap2, x, y)

            if (pixel1 != pixel2) {
                return false ; Difference found
            }

            x++ ; Increment x
        }
        x := 0 ; Reset x for the next row
        y++ ; Increment y
    }

    return true ; No differences found
}

#HotIf
