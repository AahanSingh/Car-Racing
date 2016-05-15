local composer = require( "composer" )

local scene = composer.newScene()


--local enginestart = audio.loadSound( "enginestart.mp3" )
--backgroundMusicChannel = audio.play( enginestart, { channel=1, loops=-1, fadein=5000 } )


local widget = require( "widget" )


 
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function handleChangeButton( event )
    if event.phase == "ended" then
        composer.removeHidden()
        composer.gotoScene( "game")
        composer.removeHidden()
        composer.removeScene( "restart",false)
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
        label = "Restart",
        fontSize=30,
         onEvent = handleChangeButton
    })
    sceneGroup:insert( changeButton )
    changeButton.x = display.contentCenterX
    changeButton.y = display.contentCenterY
    local a = composer.getVariable( "fin" )
    local max
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
        local num1 = tonumber( contents )
        local num2 = tonumber(a)
        if num1>num2 then
            max=num1
        else
            max=num2
        end
        io.close( file )
    end
    file = nil


    -- Path for the file to write
    local path = system.pathForFile( "myfile.txt", system.DocumentsDirectory )

    -- Open the file handle
    local file, errorString = io.open( path, "w" )

    if not file then
        -- Error occurred; output the cause
        print( "File error: " .. errorString )
    else
        -- Write data to file
        file:write(max)
        -- Close the file handle
        io.close( file )
    end

    file = nil






    local scoreText = display.newText( "Final score : "..a, 130, 100, "Helvetica", 32 )
    sceneGroup:insert(scoreText)
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
    --myTextObject:removeSelf();
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