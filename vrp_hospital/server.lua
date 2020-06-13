---------------------------------------------------------------
--                   Made by buskquite                       --
--                Script Name : vrp_hospital                 --
---------------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_hospital")

RegisterServerEvent('healnoty')
AddEventHandler('healnoty', function()
    local ID = vRP.getUserId({source})
    local P = vRP.getUserSource({ID})
    print(GetPlayerName(source).. " este la spital")
    vRPclient.notify(P, {GetPlayerName(source).. " ai inceput analiza! ~r~Stai nemiscat!"})
end)

RegisterServerEvent('heal')
AddEventHandler('heal', function()
    local ID = vRP.getUserId({source})
    local P = vRP.getUserSource({ID})
    vRPclient.setHealth(P, {200})
    print(GetPlayerName(source).. " a plecat de la spital")
    vRPclient.notify(P, {GetPlayerName(source).. " ai luat pastila de la doctor! ~g~Acum esti mai bine"})
    vRPclient.notify(P, {"~g~Te poti vindeca o data la 60 secunde!"})
end)