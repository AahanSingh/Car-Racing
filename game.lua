local composer = require( "composer" )
local physics=require "physics"
physics.start()
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
	----CAR--------
    car1=display.newRect( dw/2, 0, dw/8, dw/4.5 )
    car1.fill={type="image", filename="car_red_1.png"}
    car1.anchorY=1
    center=dw/2
    car1.posA=center-dw/4.75
    car1.posB=center
    car1.posC=center+dw/4.75
    car1.current=car1.posB
	 car1.speed=5
    sceneGroup:insert(car)
    --print(dw/2)
	 
	 physics.addBody(car,"dynamic",{density=0.1, bounce=0.1, friction=0.1, radius=50})
	 physics.addBody(car1,"static",{density=1, bounce=0, friction=0.1, radius=20})
	 car.gravityScale = 0
end


-- "scene:show()"
function scene:show( event )
	print("show")
    road.enterFrame=moveRoad
    Runtime:addEventListener( "enterFrame", road)
    roadCopy.enterFrame=moveRoad
    Runtime:addEventListener( "enterFrame", roadCopy)
	 car1.enterFrame=moveCar
    Runtime:addEventListener( "enterFrame", car1)
end
function moveCar(self,event)
   math.randomseed( 100 )
	local q=math.random()
	--print(q)
	print(math.ceil(q)*1000 %3)
	if((math.ceil(q)*1000 %3) ==1) then
		car1.speed=math.random()%10*10
		print(car1.speed)
		car1.y=car1.y+car1.speed
	end
	if(self.y>dh) then
		self.y=0
		end
end

function touchScreen(event)
    print("applied")
    print(car.current)
    if event.x < dw/2 then
        
        if car.current==car.posB then
            car.x=car.posA
            car.current=car.posA
        elseif car.current == car.posC then
            car.x=car.posB
            car.current=car.posB    
        end
    else

        if car.current==car.posB then
            car.x=car.posC
            car.current=car.posC
        elseif car.current == car.posA then
            car.x=car.posB
            car.current=car.posB    
        end

    end
end    
function moveRoad(self,event)
    if self.y > dh-20 then
        self.y=20
			--print("back")
        pix=pix+10
        if pix > 500 then 
            road.speed=road.speed+1
            roadCopy.speed=roadCopy.speed+1
            pix=0
        else
            --print("less")
        end
    else
        self.y=self.y+self.speed 
        pix=pix+10
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
Runtime:addEventListener("tap",touchScreen)
-- -------------------------------------------------------------------------------

return scene