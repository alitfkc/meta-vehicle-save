created_vehicles = {}

----------------------------------------------------------
--send player vehicles ( - oyuncu araçlarını gönder - )
----------------------------------------------------------
function player_login(_,account)
    local account_name = getAccountName(account)

    local player_vehicles_s = {}
    if global_player_vehicle[account_name] then 
        player_vehicles_s = global_player_vehicle[account_name]
    end
    triggerClientEvent(source,"isb-save:send_player_vehicles",source,player_vehicles_s)

end
local function restart_s()
    for k,v in pairs(getElementsByType("player")) do 
        local account = getPlayerAccount(v)
        if account then 
            local account_name = getAccountName(account)
            local player_vehicles_s = {}
            if global_player_vehicle[account_name] then 
                player_vehicles_s = global_player_vehicle[account_name]
                triggerClientEvent(v,"isb-save:send_player_vehicles",v,player_vehicles_s)
            end
            --triggerClientEvent("send_player_vehicles",v,player_vehicles_s,toJSON(info_vehicle_list))
        end
    end
end
setTimer(restart_s,800,1)
addEventHandler("onPlayerLogin",root,player_login)
---------------------------------------------------------
-- get modified parts
---------------------------------------------------------
function getParts(veh)
    local t = {}
    local upgrades = getVehicleUpgrades(veh)
    for i, v in ipairs(upgrades) do
        t[i] = v
    end
    return t
end

---------------------------------------------------------
-- get vehicle datas
---------------------------------------------------------
function getDatas(veh) 
    local t = {}
    for k,v in ipairs(data_list) do 
        table.insert(t,{data_name = v,data = getElementData(veh,v)})
    end
    return t
end
---------------------------------------------------------
-- Save Vehicle
---------------------------------------------------------
function saveVehicleServer(veh_name) --kod 404
    local veh = getPedOccupiedVehicle(source)
    if not isElement(veh) then return end
    --vehicle data
    local save_t = {}
    save_t.modified_parts = getParts(veh)
    save_t.colors = {getVehicleColor(veh)}
    save_t.location  = {getElementPosition(veh)}
    save_t.rotation = {getVehicleRotation(veh)}
    save_t.handling = getVehicleHandling(veh)
    save_t.element_datas = getDatas(veh)
    save_t.model = getElementModel(veh)
    save_t.dim = getElementDimension(veh)
    save_t.interior = getElementInterior(veh)

    local state = false
    local account_name = getAccountName(getPlayerAccount(source))
    local datas = global_player_vehicle[account_name]
    if datas then
        for k,v in ipairs(datas) do 
            if v.veh_name == veh_name then 
                v.data = save_t
                state = true
            end
        end
    else 
        datas = {}
    end
    triggerClientEvent(source,"isb-save:send_player_vehicles",source,datas)
    if state then 
        global_player_vehicle[account_name] = datas
        change_data_db(toJSON(save_t),veh_name)
        return 
    end
    global_player_vehicle[account_name] =  datas
    table.insert(datas,{account_name = account_name, veh_name = veh_name , data = save_t})
    add_vehicle_db(account_name,veh_name,toJSON(save_t))
end
---------------------------------------------------------
--Load vehicle
---------------------------------------------------------
function loadVehicleServer(data)

    if created_vehicles[source]  then 
        destroyElement(created_vehicles[source].elm)
        created_vehicles[source] = nil 
    end
    local veh = createVehicle(data.model,unpack(data.location),unpack(data.rotation))
    setVehicleColor(veh,unpack(data.colors))
    setElementInterior(veh,data.interior)
    setElementDimension(veh,data.dim)
    setElementPosition(veh,unpack(data.location))
    setElementRotation(veh,unpack(data.rotation))
    for k,v in pairs(data.handling) do 
        setVehicleHandling(veh,k,v)
    end

    for i, v in ipairs(data.modified_parts) do
		addVehicleUpgrade(veh, v)
	end
    setTimer(function(veh,data)
        for k,v in ipairs(data.element_datas) do 
            setElementData(veh,v.data_name,v.data)
        end
    end,20,1,veh,data)
    warpPedIntoVehicle(source,veh)
    created_vehicles[source] = {elm = veh}
end
-------------------------------------------------------------------------
-- remove vehicle
-------------------------------------------------------------------------
function removeVehicle()
    if created_vehicles[source]  then 
        destroyElement(created_vehicles[source].elm)
        created_vehicles[source] = nil 
    end
end

--------------------------------------------------------------------
--deleted vehicle
--------------------------------------------------------------------
function deleteVehicleServer(veh_name)
    local account_name = getAccountName(getPlayerAccount(source))
    local datas = global_player_vehicle[account_name]
    if datas then
        for k,v in ipairs(datas) do 
            if v.veh_name == veh_name then 
                remove_vehicle_db(account_name,veh_name)
                table.remove(datas,k)
                break
            end
        end
        triggerClientEvent(source,"isb-save:send_player_vehicles",source,datas)
        global_player_vehicle[account_name] = datas
    end
end


events = {
    {event_name = "isb-veh_save:saveVehicle",func = saveVehicleServer },
    {event_name = "isb-veh_save:loadVehicle",func = loadVehicleServer },
    {event_name = "isb-veh_save:deleteVehicle",func = deleteVehicleServer },
    {event_name = "isb-veh_save:removeVehicle",func = removeVehicle },


}

for k,v in ipairs(events) do
    if v.event_name and v.func then 
        addEvent(v.event_name,true)
        addEventHandler(v.event_name,root,v.func)
    end
end


