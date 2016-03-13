local composer = require( "composer" )

local scene = composer.newScene()
local pix=0
local no=0
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    dh=display.contentHeight
    dw=display.contentWidth
    --print( dh )
    --print( dw )
    x=display.contentCenterX
    --print(x)
    --print(dw/2)
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    ---------ROAD---------
    road=display.newRect( 0, 0, dw, dh )
    road.fill={type="image",filename="road.png"}
    road.anchorX,road.anchorY=0,0
    road.contentHeight=dh
    sceneGroup:insert(road)
    road.speed=5

    roadCopy=display.newRect( 0, 0, dw, dh )
    roadCopy.fill={type="image",filename="road.png"}
    roadCopy.anchorX,roadCopy.anchorY=0,1
    roadCopy.contentHeight=dh
    sceneGroup:insert(roadCopy)
    roadCopy.speed=5
    ----PLAYER CAR--------
    car=display.newRect( dw/2, dh-10, dw/8, dw/4.5 )
    car.fill={type="image", filename="player.png"}
    car.anchorY=1
    center=dw/2
    car.posA=center-dw/4.75
    car.posB=center
    car.posC=center+dw/4.75
    car.current=car.posB
    sceneGroup:insert(car)
    --print(dw/2)
end


-- "scene:show()"
function scene:show( event )
    road.enterFrame=moveRoad
    Runtime:addEventListener( "enterFrame", road)
    roadCopy.enterFrame=moveRoad
    Runtime:addEventListener( "enterFrame", roadCopy)
    Runtime:addEventListener("tap",touchScreen)
end
function moveCar(moveTo)
    car.x=moveTo
    car.current=moveTo
end
function touchScreen(event)
    print("TOUCHED")
    print(no)
    if no==0 then
        no=no+1
        if event.phase == "ended" then
            x=event.x
            if x>center and car.current==car.posA then
                --move to B
                moveCar(car.posB)
            elseif x>center and car.current==car.posB then
                --move to C
                moveCar(car.posC)
            elseif x<center and car.current==car.posC then
                --move to B
                moveCar(car.posB)
            elseif x<center and car.current==car.posB then
                --move to A
                moveCar(car.posA)
            else
                print("crash")
            end
        end
    end
end
function moveRoad(self,event)
    if self.y > dh-10 then
        self.y=0
        pix=pix+1
        if pix > 500 then 
            road.speed=road.speed+1
            roadCopy.speed=roadCopy.speed+1
            pix=0
        else
            --print("less")
        end
    else
        self.y=self.y+self.speed 
        pix=pix+1
         if pix > 500 then 
            road.speed=road.speed+1
            roadCopy.speed=roadCopy.speed+1
            pix=0
        else
            --print("less")
        end
    end
    if road.speed>20 or roadCopy.speed>20 then
        road.speed=20
        roadCopy.speed=20
    end
    --print(road.speed)
    --print(roadCopy.speed)
end


-- "scene:hide()"
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