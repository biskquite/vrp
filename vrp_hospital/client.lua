---------------------------------------------------------------
--                   Made by buskquite                       --
--                Script Name : vrp_hospital                 --
---------------------------------------------------------------

vRP = Proxy.getInterface("vRP")
vRPg = Proxy.getInterface("vrp_spital")

local cheal = {
    {242.34744262695,-1377.2564697266,39.534381866455}
}

local ped = {
    {240.0131072998,-1379.9099121094,38.534381866455,"Doctor",320.77,0xD47303AC,"s_m_m_doctor_01"}
}

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local P = PlayerPedId(-1)
        local PC = GetEntityCoords(P)
        for k,v in pairs(cheal) do
        local dis = GetDistanceBetweenCoords(PC.x, PC.y, PC.z, v[1], v[2], v[3], true)
        if dis < 5 then 
            if (Vdist(PC.x, PC.y, PC.z, v[1], v[2], v[3])) then 
                Draw3DText(PC.x, PC.y, PC.z + 1, "Press 'E' for ~g~Heal", 0.3)
                DrawMarker(1, v[1],v[2],v[3] - 1 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,198,30, 200, 0, 0, 0, 1, 0, 0, 0)
                if dis < 3 then
                    if IsControlJustPressed(0, 38) then 
                        vRP.teleport({241.32814025879,-1378.6741943359,39.549819946289}) 
                        TaskStartScenarioInPlace(P, 'WORLD_HUMAN_PICNIC', 0, true)
                        TriggerServerEvent("healnoty")
                        Wait(10000)
                        TriggerServerEvent("heal")
                        vRP.teleport({242.34744262695,-1377.2564697266,39.534381866455}) 
                        ClearPedTasks(P)
                        Wait(60000)
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()

    for _,v in pairs(ped) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)


function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(1.0*scale, 2.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(""..text)
        DrawText(_x,_y)
    end
end