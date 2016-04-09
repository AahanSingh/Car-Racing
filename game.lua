local composer = require( "composer" )
local physics=require "physics"

dh=display.contentHeight
dw=display.contentWidth
local scene = composer.newScene()
local pix=0
local no=0

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
local score
local ScoreText
local abc



local carmoving = audio.loadSound( "carstarted.mp3" )
backgroundMusicChannel2 = audio.play( carmoving, { channel=2, fadein=0 } )
local gear=audio.loadSound("chgGear.mp3")
backgroundMusicChannel2=audio.play( gear,{ channel=4, loops=-1, fadein=13 } )
audio.setVolume( 0.3, { channel=2 } )
audio.setVolume( 0.3, { channel=4 } )
audio.setVolume( 0.3, { channel=3 } )
-- "scene:create()"
function scene:create( event )
    print("Scene:create")
    sceneGroup = self.view
    physics.start()
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
    car.name="hello"
    randomobject1()
    randomobject2()

    ------SCORE--------
    
    scoreText = display.newText( "", 130, 10, "Helvetica", 32 )
    scoreText.anchorX,scoreText.anchorY=0,0
    score = 1000
    sceneGroup:insert(scoreText)
    
    
end
local function lerp( v0, v1, t )
    return v0 + t * (v1 - v0)
end
local function showScore( target, value, duration, fps )
    if value == 0 then
        return
    end
    local newScore = 0
    local passes = duration / fps
    local increment = lerp( 0, value, 1/passes )

    local count = 0
    
    local function updateText()
        if count < passes then
            newScore = newScore + increment
            target.text = string.format( "%07d", newScore )
            abc = math.floor(newScore)
            count = count + 1
        else
          
            target.text = string.format( "%07d", value )
            abc = math.floor(value)
            Runtime:removeEventListener( "enterFrame", updateText )
        end
    end

    Runtime:addEventListener( "enterFrame", updateText )
end
local duration = 2000
local fps = 0.2

-- "scene:show()"
function scene:show( event )
    
    if(event.phase=="did") then
        print("Scene:show")
        
        addList()
        showScore( scoreText, score, duration, fps )
    end
end




local function onLocalCollision(self, event )
    print( "collision" )
    print(self.name)
    print(abc)
    audio.stop( backgroundMusicChannel2 )
    Runtime:removeEventListener("collision",onLocalCollision)
    local crash = audio.loadSound( "crash.mp3" )
    backgroundMusicChannel3 = audio.play( crash, { channel=3, fadein=0 } )
   
    value = abc
    composer.setVariable( "fin", abc )

    composer.removeScene( "game",false)
    
    composer.gotoScene( "restart")
    
    
end

local function touchScreen(event)
    print("touchScreen")
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

local function moveRoad(self,event)
    if(self.y==nil) then
        return
    end
    if self.y > dh-25 then
        self.y=25
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
        if(self.name=="obj1") then
            self:removeSelf()  
            self=nil 
            randomobject1()
        else
            self:removeSelf()  
            self=nil
            randomobject2()
        end
    else
        self.y=self.y+self.speed+roadCopy.speed
    end
end

function randomobject1(event)
    --print("randomobject1")
    math.randomseed( os.time() )
    opp=display.newRect( center-dw/4.75, -100, dw/8, dw/4.5 )
    
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
    physics.addBody(opp,"static",{density=1, bounce=0.1, friction=0.2,radius=2})
    opp.gravityScale=0
    opp.enterFrame=moveoppcar
    opp.name="obj1"
    Runtime:addEventListener("enterFrame", opp)
end


function randomobject2(event)
    --print("randomobject1")
    math.randomseed( os.time() )
    opp1=display.newRect( center-dw/4.75, -100, dw/8, dw/4.5 )
    
    local position = math.random(1, 3)
    local cartype = math.random(1, 3)

    if(position==prevP) then
        position=(prevP+2)%3
    end 
    
    if position==1 then
        opp1.x=center-dw/4.75
    end
    if position == 2 then
        opp1.x=center
    end
    if position == 3 then
        opp1.x=center+dw/4.75
    end
    if cartype == 1 then
        opp1.fill={type="image", filename="car_green_1.png"}
    end
    if cartype == 2 then
        opp1.fill={type="image", filename="car_blue_1.png"}
    end
    if cartype == 3 then
        opp1.fill={type="image", filename="car_red_1.png"}
    end
    opp1.speed=math.random(1,10)
    
    sceneGroup:insert(opp1)
    prevP=position
    prevS=opp.speed
    local r=opp.width
    physics.addBody(opp1,"static",{density=1, bounce=0.1, friction=0.2,radius=2})
    opp1.gravityScale=0
    opp1.enterFrame=moveoppcar
    opp1.name="obj2"
    Runtime:addEventListener("enterFrame", opp1)
end



function addList()
    car.collision = onLocalCollision
    car:addEventListener( "collision", car )
    road.enterFrame=moveRoad
    Runtime:addEventListener( "enterFrame", road)
    roadCopy.enterFrame=moveRoad
    Runtime:addEventListener( "enterFrame", roadCopy)
    Runtime:addEventListener("tap",touchScreen)
    --roadCopy:addEventListener("tap",touchScreen)
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
    
    car:removeEventListener( "collision", car )
    Runtime:removeEventListener( "enterFrame", road)
    Runtime:removeEventListener( "enterFrame", roadCopy)
    Runtime:removeEventListener( "enterFrame", moveoppcar)
    road:removeSelf()
    car:removeSelf()
    opp:removeSelf()
    opp1:removeSelf()
    roadCopy:removeSelf()
    audio.stop( 2 )
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene