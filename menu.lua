local composer = require( "composer" )

local scene = composer.newScene()

local enginestart = audio.loadSound( "enginestart.mp3" )


local widget = require( "widget" )
local splash

dh=display.contentHeight
dw=display.contentWidth

backgroundMusicChannel = audio.play( enginestart, { channel=1, loops=-1, fadein=2000 } )
audio.setVolume( 1, { channel=1 } )
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function handleChangeButton( event )
    if event.phase == "ended" then
        audio.stop( 1 )
        composer.gotoScene( "game", { effect = "crossFade", time = 500 } )
    end
    return true
end

local function handlehighscore( event )
    if event.phase == "ended" then
        audio.stop( 1 )
        composer.gotoScene( "highscore", { effect = "crossFade", time = 500 } )
    end
    return true
end

local function handleinstruction( event )
    if event.phase == "ended" then
        audio.stop( 1 )
        composer.gotoScene( "instruction", { effect = "crossFade", time = 500 } )
    end
    return true
end


-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    
    local changeButton = widget.newButton({
         left = 100,
        top = 200,
        id = "button1",
        label = "New Game",
        fontSize=30,
         onEvent = handleChangeButton
    })
    sceneGroup:insert( changeButton )
    changeButton.x = display.contentCenterX
    changeButton.y = display.contentCenterY -100

    local highscore = widget.newButton({
         left = 100,
        top = 200,
        id = "button2",
        label = "Highest Score",
        fontSize=30,
         onEvent = handlehighscore
    })
    sceneGroup:insert( highscore )
    highscore.x = display.contentCenterX
    highscore.y = display.contentCenterY 


    local instruction = widget.newButton({
         left = 100,
        top = 200,
        id = "button3",
        label = "Instructions",
        fontSize=30,
         onEvent = handleinstruction
    })
    sceneGroup:insert( instruction )
    instruction.x = display.contentCenterX
    instruction.y = display.contentCenterY + 100

   
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
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