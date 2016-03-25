local composer = require( "composer" )


local scene = composer.newScene()
local pix=0
local no=0
local physics=require "physics"
physics.start()
local x=2000
local prevP=0
local prevS=5
local count=1
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------

local opp1
local opp
local sceneGroup
local roadCopy
local road
local car

function removeAllListeners(self)
  self._functionListeners = nil
  self._tableListeners = nil
end



local function touchScreen(event)
    print("touchScreen")
    --print(car.current)
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

local function removeListeners()
    removeAllListeners(road)
    removeAllListeners(roadCopy)
    removeAllListeners(opp)
    removeAllListeners(car)
    road:removeEventListener("tap",touchScreen)
    roadCopy:removeEventListener("tap",touchScreen)
    car:removeEventListener( "collision",onLocalCollision)
    --[[print("removeListeners")
    Runtime:removeEventListener( "enterFrame", road)
    Runtime:removeEventListener( "enterFrame", roadCopy)
    Runtime:removeEventListener("tap",touchScreen)
    Runtime:removeEventListener("enterFrame", opp)
    Runtime:removeEventListener( "enterFrame", car ) ]]
    composer.removeScene( "game")
    composer.gotoScene( "restart")
end
function onLocalCollision( event )
    print( "collision" )
    road:removeEventListener("tap",touchScreen)
    roadCopy:removeEventListener("tap",touchScreen)
    car:removeEventListener( "collision",onLocalCollision)
    car:removeSelf( )
    composer.removeScene( "game")
    composer.gotoScene( "restart")
    --removeListeners()
end


local function moveRoad(self,event)
    --print("moveRoad")
    
    if self.y > dh-20 then
        self.y=20
        pix=pix+10
        if pix > 100 then 
            road.speed=road.speed+1
            roadCopy.speed=roadCopy.speed+1
            pix=0
        else
            --print("less")
        end
    else
        self.y=self.y+self.speed 
        pix=pix+1
         if pix > 100 then 
            road.speed=road.speed+1
            roadCopy.speed=roadCopy.speed+1
            pix=0
        else
            --print("less")
        end
    end
    if road.speed>30 or roadCopy.speed>30 then
        road.speed=30
        roadCopy.speed=30
    end
    --print(road.speed)
    --print(roadCopy.speed)
end

local function moveoppcar(self, event)
    --print("moveoppcar")
    --print(self.y)
    if(self.y==nil)then
        return
    end
    if(self.y>dh) then
        Runtime:removeEventListener( "enterFrame", self )
        self:removeSelf()  
        self=nil 
        randomobject1()
        --[[print( "removed" )
        count1=count1+1
        if(count1==2)then
            randomobject()
            count1=0
        end]]
    else
        --print( "else" )
        self.y=self.y+self.speed+roadCopy.speed
    end
end

function randomobject1(event)
    --print("randomobject1")
    math.randomseed( os.time() )
    opp=display.newRect( center-dw/4.75, 30, dw/8, dw/4.5 )
    
    local position = math.random(1, 3)
    local cartype = math.random(1, 3)

    if(position==prevP) then
        position=(prevP+2)%3
    end 
    
    if position==1 then
        opp.x=center-dw/4.75
    end
    if position == 2 then
        opp.x=center
    end
    if position == 3 then
        opp.x=center+dw/4.75
    end
    if cartype == 1 then
        opp.fill={type="image", filename="car_green_1.png"}
    end
    if cartype == 2 then
        opp.fill={type="image", filename="car_blue_1.png"}
    end
    if cartype == 3 then
        opp.fill={type="image", filename="car_red_1.png"}
    end
    opp.speed=math.random(1,10)
    
    sceneGroup:insert(opp)
    prevP=position
    prevS=opp.speed
    local r=opp.width
    physics.addBody(opp,"static",{density=1, bounce=0.1, friction=0.2,radius=5})
    opp.gravityScale=0
    opp.enterFrame=moveoppcar
    Runtime:addEventListener("enterFrame", opp)
end





-- "scene:create()"
function scene:create( event )
    print("Scene:create")
    sceneGroup = self.view


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
    physics.addBody(car,"dynamic",{density=1, bounce=0.1, friction=0.2})
    car.gravityScale=0
    --[[randomobject1()
    randomobject1()]]
end



-- "scene:show()"
function scene:show( event )
    
    if(event.phase=="did") then
        print("Scene:show")
        
        addList()
        randomobject1()
        randomobject1()
        --[[car.collision=onLocalCollision
        Runtime:addEventListener( "collision", car )  
        road.enterFrame=moveRoad
        Runtime:addEventListener( "enterFrame", road)
        roadCopy.enterFrame=moveRoad
        Runtime:addEventListener( "enterFrame", roadCopy)
        Runtime:addEventListener("tap",touchScreen)]]
    end
end


function addList()
    --car.collision=onLocalCollision
    --Runtime:addEventListener( "collision", car )  
    car.collision = onLocalCollision
    car:addEventListener( "collision", car )
    road.enterFrame=moveRoad
    Runtime:addEventListener( "enterFrame", road)
    roadCopy.enterFrame=moveRoad
    Runtime:addEventListener( "enterFrame", roadCopy)
    road:addEventListener("tap",touchScreen)
    roadCopy:addEventListener("tap",touchScreen)
end



-- "scene:hide()"
function scene:hide( event )
    print("Scene:hide")
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
    print("Scene:destroy")
    local sceneGroup = self.view
    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end






--[[function touchScreen(event)
    --print("touchScreen")
    --print(car.current)
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
end]]

--[[function moveRoad(self,event)
    --print("moveRoad")
    
    if self.y > dh-20 then
        self.y=20
        pix=pix+10
        if pix > 100 then 
            road.speed=road.speed+1
            roadCopy.speed=roadCopy.speed+1
            pix=0
        else
            --print("less")
        end
    else
        self.y=self.y+self.speed 
        pix=pix+1
         if pix > 100 then 
            road.speed=road.speed+1
            roadCopy.speed=roadCopy.speed+1
            pix=0
        else
            --print("less")
        end
    end
    if road.speed>30 or roadCopy.speed>30 then
        road.speed=30
        roadCopy.speed=30
    end
    --print(road.speed)
    --print(roadCopy.speed)
end]]


--[[function randomobject(event)
   -- print("randomobject")
    math.randomseed( os.time() )
    opp=display.newRect( center-dw/4.75, 30, dw/8, dw/4.5 )
    opp1=display.newRect( center-dw/4.75, 30, dw/8, dw/4.5 )
    local position = math.random(1, 3)
    local cartype = math.random(1, 3)
    
    --physics.addBody(opp,"static",{density=1, bounce=0.1, friction=0.2})
    opp.gravityScale=0

    
    local position1=math.random(1,3)
    local cartype1 = math.random(1, 3)
    
    --physics.addBody(opp1,"static",{density=1, bounce=0.1, friction=0.2})
    opp1.gravityScale=0

    if(position==prevP) then
        position=(prevP+1)%3
    end 
    if(count==1) then
        position1=(position+1)%3
        count=2
    else
        position1= 6 - position - prevP
    end
    if position==1 then
        opp.x=center-dw/4.75
    end
    if position == 2 then
        opp.x=center
    end
    if position == 3 then
        opp.x=center+dw/4.75
    end
    if cartype == 1 then
        opp.fill={type="image", filename="car_green_1.png"}
    end
    if cartype == 2 then
        opp.fill={type="image", filename="car_blue_1.png"}
    end
    if cartype == 3 then
        opp.fill={type="image", filename="car_red_1.png"}
    end
    opp.speed=math.random(1,10)
    


    if position1==1 then
        opp1.x=center-dw/4.75
    end
    if position1 == 2 then
        opp1.x=center
    end
    if position1 == 3 then
        opp1.x=center+dw/4.75
    end
    if cartype1 == 1 then
        opp1.fill={type="image", filename="car_green_1.png"}
    end
    if cartype1 == 2 then
        opp1.fill={type="image", filename="car_blue_1.png"}
    end
    if cartype1 == 3 then
        opp1.fill={type="image", filename="car_red_1.png"}
    end
    opp1.speed=math.random(1,10)
    
    sceneGroup:insert(opp)
    sceneGroup:insert(opp1)
    prevP=position
    prevS=opp.speed
    Runtime:addEventListener("enterFrame", opp)
    Runtime:addEventListener("enterFrame", opp1)
end
]]



--[[function randomobject1(event)
    --print("randomobject1")
    math.randomseed( os.time() )
    opp=display.newRect( center-dw/4.75, 30, dw/8, dw/4.5 )
    
    local position = math.random(1, 3)
    local cartype = math.random(1, 3)

    if(position==prevP) then
        position=(prevP+2)%3
    end 
    
    if position==1 then
        opp.x=center-dw/4.75
    end
    if position == 2 then
        opp.x=center
    end
    if position == 3 then
        opp.x=center+dw/4.75
    end
    if cartype == 1 then
        opp.fill={type="image", filename="car_green_1.png"}
    end
    if cartype == 2 then
        opp.fill={type="image", filename="car_blue_1.png"}
    end
    if cartype == 3 then
        opp.fill={type="image", filename="car_red_1.png"}
    end
    opp.speed=math.random(1,10)
    
    sceneGroup:insert(opp)
    prevP=position
    prevS=opp.speed
    local r=opp.width
    physics.addBody(opp,"static",{density=1, bounce=0.1, friction=0.2,radius=r})
    opp.gravityScale=0
    opp.enterFrame=moveoppcar
    Runtime:addEventListener("enterFrame", opp)
end]]



--[[function moveoppcar(self, event)
    --print("moveoppcar")
    --print(self.y)
    if(self.y==nil)then
        return
    end
    if(self.y>dh) then
        Runtime:removeEventListener( "enterFrame", self )
        self:removeSelf()   
        randomobject1()
        print( "removed" )
        count1=count1+1
        if(count1==2)then
            randomobject()
            count1=0
        end
    else
        --print( "else" )
        self.y=self.y+self.speed+roadCopy.speed
    end
end]]


--[[function removeListeners()
    --print("removeListeners")
    Runtime:removeEventListener( "enterFrame", road)
    Runtime:removeEventListener( "enterFrame", roadCopy)
    Runtime:removeEventListener("tap",touchScreen)
    Runtime:removeEventListener("enterFrame", opp)
    Runtime:removeEventListener("enterFrame", opp1)
    Runtime:removeEventListener( "enterFrame", car ) 
    opp:removeSelf() 
    opp=nil
    if(opp==nil)then
        print("deleted opp")
    end
    composer.removeScene( "game")
    composer.gotoScene( "restart")
end]]
-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--Runtime:addEventListener("tap",touchScreen)

-- -------------------------------------------------------------------------------

return scene