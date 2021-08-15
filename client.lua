TGIANN = {}

TGIANN.positionx = 0.002 -- -0.15 left of screen, 0.0 Side of the map , 0.3 Middle of the screen,  0.6 or 0.7 Right of screen
TGIANN.positiony = -0.03 -- 0.0 Bottom of the screen, -0.3 Middle of the screen, -0.9 Top of the screen

local w, h = GetActiveScreenResolution()
local flattire = false
local compass = {
    ticksBetweenCardinals = 9.0, -- Ara Çizgiler
    tickColour = {r = 255, g = 255, b = 255, a = 255},
    tickSize = {w = 0.0006, h = 0.003},
    cardinal = {
        textSize = 0.40,
        textOffset = -0.014 ,
        textColour = {255, 255, 255, 255},
        tickSize = {w = 0.013, h = 0.022 },
        tickColour = {r = 0, g = 0, b = 0, a = 100},
    },
    intercardinal = {
        textSize = 0.26,
        textOffset = -0.013,
        textColour = {255, 255, 255, 255},
        tickSize = {w = 0.0005, h = 0.005},
        tickColour = {r = 255, g = 255, b = 255, a = 255},
    }
}

-- LOCATION AND TIME PARAMETERS
local locationColorText = {255, 255, 255}   -- Color used to display location and time
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

-- Globals
local PlayerPed = nil
local pedInVeh = true
local timeText = ""
local locationText = ""
local currentFuel = 0.0
local currSpeed = 0.0
local cruiseSpeed = 999.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local cruiseIsOn = false
local seatbeltIsOn = false
local zorlaMaxHizSiniri = {}
local zorlaHizSabitle = {}

-- Main thread
Citizen.CreateThread(function()
    if w == 1920 and h == 1080 then
        screenPosX = 0.165                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1680 and h == 1050 then
        screenPosX = 0.195                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1600 and h == 1200 then
        screenPosX = 0.190                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1600 and h == 1024 then
        screenPosX = 0.190                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882 
    elseif w == 1600 and h == 900 then
        screenPosX = 0.190                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882 
    elseif w == 1440 and h == 900 then
        screenPosX = 0.190                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1366 and h == 768 then
        screenPosX = 0.175                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1360 and h == 768 then
        screenPosX = 0.170                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1280 and h == 1024 then
        screenPosX = 0.240                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1280 and h == 960 then
        screenPosX = 0.220                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1280 and h == 800 then
        screenPosX = 0.190                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1280 and h == 768 then
        screenPosX = 0.185                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1280 and h == 720 or w == 1176 and h == 664 then
        screenPosX = 0.175                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 1152 and h == 864 or w == 1024 and h == 768  then
        screenPosX = 0.215                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)
    elseif w == 800 and h == 600 then
        screenPosX = 0.220                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.852      
    else
        screenPosX = 0.165                    -- X coordinate (top left corner of HUD)
        screenPosY = 0.882                    -- Y coordinate (top left corner of HUD) 
    end  

    while true do
        Citizen.Wait(1)
        PlayerPed = PlayerPedId()
        local position = GetEntityCoords(PlayerPed)
        local vehicle = GetVehiclePedIsIn(PlayerPed, false)
        -- Set vehicle states
        if IsPedInAnyVehicle(PlayerPed, false) then
            pedInVeh = true
        else
            pedInVeh = true
            cruiseIsOn = false
            seatbeltIsOn = false
        end

        -- Get time and display
        local pxDegree = 0.06 / 180
        local playerHeadingDegrees = 0
        local playerHeadingDegrees = 360.0 - GetEntityHeading(PlayerPed)
        local tickDegree = playerHeadingDegrees - 180 / 2
        local tickDegreeRemainder = compass.ticksBetweenCardinals - (tickDegree % compass.ticksBetweenCardinals)
        local tickPosition = screenPosX + 0.005 + tickDegreeRemainder * pxDegree
        tickDegree = tickDegree + tickDegreeRemainder
        --[[
        Draw2DText(.5, .3, "~r~The tickDegree is: ~b~" .. tostring(tickDegree), 1.0, 1);
        Draw2DText(.5, .5, "~r~The tickDegree % 90.0 is: ~b~" .. tostring((tickDegree % 90)), 1.0, 1);
        Draw2DText(.5, .7, "~r~The tickDegree % 45.0 is: ~b~" .. tostring((tickDegree % 45)), 1.0, 1);
        ]]--

        while tickPosition < screenPosX + 0.0325 do
            if (tickDegree % 90.0) == 0 then
                -- OLD:
                --DrawRect(tickPosition + TGIANN.positionx, screenPosY + 0.095 + TGIANN.positiony, compass.cardinal.tickSize.w, compass.cardinal.tickSize.h, compass.cardinal.tickColour.r, compass.cardinal.tickColour.g, compass.cardinal.tickColour.b, compass.cardinal.tickColour.a )
                --drawText(degreesToIntercardinalDirection(tickDegree), 4, compass.cardinal.textColour, 0.4, tickPosition, screenPosY + 0.095 + compass.cardinal.textOffset, true, true)
            
                DrawRect(tickPosition + TGIANN.positionx, screenPosY + 0.1025 + TGIANN.positiony, compass.intercardinal.tickSize.w, compass.intercardinal.tickSize.h, compass.intercardinal.tickColour.r, compass.intercardinal.tickColour.g, compass.intercardinal.tickColour.b, compass.intercardinal.tickColour.a )
                drawText(degreesToIntercardinalDirection(tickDegree), 4, compass.cardinal.textColour, 0.26, tickPosition, screenPosY + 0.095 + compass.intercardinal.textOffset, true, true)
            elseif (tickDegree % 45.0) == 0 then
                -- OLD:
                --DrawRect(tickPosition + TGIANN.positionx, screenPosY + 0.1025 + TGIANN.positiony, compass.intercardinal.tickSize.w, compass.intercardinal.tickSize.h, compass.intercardinal.tickColour.r, compass.intercardinal.tickColour.g, compass.intercardinal.tickColour.b, compass.intercardinal.tickColour.a )
                --drawText(degreesToIntercardinalDirection(tickDegree), 4, compass.cardinal.textColour, 0.26, tickPosition, screenPosY + 0.095 + compass.intercardinal.textOffset, true, true)
                
                DrawRect(tickPosition + TGIANN.positionx, screenPosY + 0.095 + TGIANN.positiony, compass.cardinal.tickSize.w, compass.cardinal.tickSize.h, compass.cardinal.tickColour.r, compass.cardinal.tickColour.g, compass.cardinal.tickColour.b, compass.cardinal.tickColour.a )
                drawText(degreesToIntercardinalDirection(tickDegree), 4, compass.cardinal.textColour, 0.4, tickPosition, screenPosY + 0.095 + compass.cardinal.textOffset, true, true)
            elseif  (tickDegree % 90.0) == 81.0 or (tickDegree % 90.0) == 72.0 or (tickDegree % 90.0) == 9.0 or (tickDegree % 90.0) == 18.0 then
                DrawRect(tickPosition + TGIANN.positionx, screenPosY + 0.104 + TGIANN.positiony, compass.tickSize.w, compass.tickSize.h, compass.tickColour.r, compass.tickColour.g, compass.tickColour.b, compass.tickColour.a )
            end

            tickDegree = tickDegree + compass.ticksBetweenCardinals
            tickPosition = tickPosition + pxDegree * compass.ticksBetweenCardinals        
        end

        if pedInVeh then
            drawText(locationText, 4, locationColorText, 0.40, screenPosX + 0.040, screenPosY + 0.082, true)
        end
    end   
end)            

Citizen.CreateThread(function()
    while true do
        local time = 2000
        local hour = GetClockHours()
        local minute = GetClockMinutes()
        timeText = hour .. ":" .. minute
        if pedInVeh then
            time = 1000
            local position = GetEntityCoords(PlayerPed)
            local vehicle = GetVehiclePedIsIn(PlayerPed, false)

            local zoneName = zones[GetNameOfZone(position.x, position.y, position.z)]
            if zoneName ~= nil then
                zoneNameFull = "[".. zoneName .. "]" 
            else
                zoneNameFull = "[Unknown]"
            end
            
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            locationText = (streetName == "" or streetName == nil) and (locationText) or (streetName)
            locationText = (zoneNameFull == "" or zoneNameFull == nil) and (locationText) or (locationText .. " | " .. zoneNameFull)
            if vehicle ~= 0 then currentFuel = GetVehicleFuelLevel(vehicle) end
        end
        Citizen.Wait(time)
    end
end)

-- Helper function to draw text to screen
function drawText(text, font, colour, scale, x, y, outline, centered)
    if not IsHudHidden() then
    if font == nil then font = 4 end
    if scale == nil then scale = 1.0 end
	    SetTextFont(font)
	    SetTextScale(0.0, scale)
	    SetTextProportional(1)
        SetTextOutline()
    if colour then
        SetTextColour(colour[1], colour[2], colour[3], colour[4] ~= nil and colour[4] or 255)
    else 
        SetTextColour(255, 255, 255, 255)
    end
        SetTextDropShadow(0, 0, 0, 0, 255)
	if centered then SetTextCentre(true) end
        SetTextEntry("STRING")
	    AddTextComponentString(text)
	    DrawText(x + TGIANN.positionx, y + TGIANN.positiony)
    end
end

function Draw2DText(x, y, text, scale, center)
    if not IsHudHidden() then
        SetTextFont(4)
        SetTextProportional(7)
        SetTextScale(scale, scale)
        SetTextOutline()
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

function degreesToIntercardinalDirection( dgr )
	dgr = dgr % 360.0
	
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "NE" -- Originally E
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "E" -- Originally SE
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "SE" -- Originally S
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "S" -- Originally SW
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "SW" -- Originally W
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "W" -- Originally NW
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "NW" -- Originally N
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "N" -- Originally NE
	end
end
