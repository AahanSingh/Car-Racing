-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
dh=display.contentHeight
dw=display.contentWidth
local function listener( event )
    splash:removeSelf();
    composer.gotoScene( "menu" )
end
	composer = require( "composer" )

	splash=display.newRect( 0, 0, dw, dh );
    splash.fill={type="image",filename="splash.jpg"}
    splash.anchorX,splash.anchorY=0,0
    splash.contentHeight=dh

    timer.performWithDelay( 4000, listener )
    