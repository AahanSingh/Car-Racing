local composer = require( "composer" )
local scene = composer.newScene()
print( "RESTART" )
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------

local bg

-- "scene:create()"
local function touch(event)
    
    --composer.removeScene( "restart")
    print( "touch" )
    rem()
    --composer.gotoScene("game")
end
function rem()
    bg:removeEventListener("tap",touch)
    composer.removeScene( "restart")
    composer.gotoScene("game")
end
function scene:create( event )

    
        local sceneGroup = self.view
        dh=display.contentHeight
        dw=display.contentWidth
        bg=display.newRect(0, 0, dw, dh )
        bg.anchorX,bg.anchorY=0,0
        local res=display.newRect( 0, dh/2, dw, 500 )
        res.fill={type="image",filename="Restart.png"}
        res.anchorX=0
        res.anchorY=0
        sceneGroup:insert(bg)   
        sceneGroup:insert(res)
        bg:addEventListener("tap",touch)
end

-- "scene:show()"
function scene:show( event )
    if(event.phase=="did")then
        --Runtime:addEventListener("tap",touch)
    end
end





function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


-- -------------------------------------------------------------------------------

return scene