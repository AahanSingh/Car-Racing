local composer = require( "composer" )

local scene = composer.newScene()

local widget = require( "widget" )
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function handleChangeButton( event )
    if event.phase == "ended" then
        audio.stop( 1 )
         
        composer.gotoScene( "menu", { effect = "crossFade", time = 500 } )
    end
    return true
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view


        -- Path for the file to read
    local path = system.pathForFile( "myfile.txt", system.DocumentsDirectory )

    -- Open the file handle
    local file, errorString = io.open( path, "r" )

    if not file then
        -- Error occurred; output the cause
        print( "File error: " .. errorString )
    else
        -- Read data from file
        local contents = file:read( "*a" )
        -- Output the file contents
        print( "Contents of " .. path .. "\n" .. contents )
        -- Close the file handle

        local scoreText = display.newText( "Highest score : "..contents, 130, 100, "Helvetica", 32 )
        sceneGroup:insert(scoreText)

        io.close( file )
    end

    file = nil


    local changeButton = widget.newButton({
         left = 100,
        top = 200,
        id = "button1",
        label = "Back",
        fontSize=30,
         onEvent = handleChangeButton
    })
    sceneGroup:insert( changeButton )
    changeButton.x = display.contentCenterX
    changeButton.y = display.contentCenterY 
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