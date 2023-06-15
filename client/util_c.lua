----------------------------------------
-- Global elements & tables
vehicles = {}

----------------------------------------
--get vehicles table
---------------------------------------
function getVehTable(t)
    vehicles = t

    if guiGetVisible(gui.main.elm) then 
        guiGridListClear(gui.list.elm)
        for k,v in ipairs(vehicles) do 
            local row  = guiGridListAddRow(gui.list.elm,v.veh_name)
            guiGridListSetItemData(gui.list.elm,row,1,v.data)
        end
    end
end
----------------------------------------
--    on off
----------------------------------------
function on_off()
    local state = not guiGetVisible(gui.main.elm)
    guiSetVisible(gui.main.elm,state)
    showCursor(state)
    if state then 
        guiGridListClear(gui.list.elm)
        for k,v in ipairs(vehicles) do 
            local row  = guiGridListAddRow(gui.list.elm,v.veh_name)
            guiGridListSetItemData(gui.list.elm,row,1,v.data)
        end
    end
end

function close()
    guiSetVisible(gui.main.elm,false)
    showCursor(false)
end
---------------------------------------
--- get vehicle
---------------------------------------
function getVehicle()
    if source == gui.getVeh.elm then 
        local selected = guiGridListGetSelectedItem(gui.list.elm)
        if selected == -1 then 
            guiAlertAnim(gui.list.elm,false)
            outputChatBox(language[language_selection]["please_select_list"],255,0,0)
            return 
        end
        triggerServerEvent("isb-veh_save:loadVehicle",localPlayer,guiGridListGetItemData(gui.list.elm,selected,1))
    end
end
---------------------------------------
-- save vehicles
---------------------------------------
function saveVehicle()
    if source == gui.setVeh.elm then 
        local text = guiGetText(gui.vehname.elm)
        if not isPedInVehicle(localPlayer) then 
            outputChatBox(language[language_selection]["not_vehicle"],255,0,0)
            return 
        end
        if text == "" then 
            guiAlertAnim(gui.vehname.elm,false)
            outputChatBox(language[language_selection]["type_veh_name"],255,0,0)
            return
        end
        triggerServerEvent("isb-veh_save:saveVehicle",localPlayer,text)
    end
end
---------------------------------
-- delete vehicle
----------------------------------
function deleteVehicle()
    if source == gui.delete_veh_btn.elm then 
        local selected = guiGridListGetSelectedItem(gui.list.elm)
        if selected == -1 then 
            guiAlertAnim(gui.list.elm,false)
            outputChatBox(language[language_selection]["please_select_list"],255,0,0)
            return 
        end
        triggerServerEvent("isb-veh_save:deleteVehicle",localPlayer,guiGridListGetItemText(gui.list.elm,selected,1))
    end
end
--------------------------------------------
-- remove vehicle
------------------------------------------
function removeVehicle()
    if source == gui.remove_veh_btn.elm then 
        triggerServerEvent("isb-veh_save:removeVehicle",localPlayer)
    end
end

----------------------------------------
--Add Gui Events
----------------------------------------

addEventHandler("onClientResourceStart",resourceRoot,function()
    functions_client = {
        -------------
        ["setVeh"] = saveVehicle,
        ["getVeh"] = getVehicle,
        ["delete_vehicle"] = deleteVehicle,
        ["remove_vehicle"] = removeVehicle,
    }
    
    --we add bindkey for panel 


    for k,v in pairs(gui) do
        if v.language_row and functions_client[v.language_row] then 
    
            addEventHandler("onClientGUIClick",v.elm,functions_client[v.language_row])
            --[[
            here i used the language row name to choose which guin goes to which function. 
            Otherwise, there would be another unnecessary variable.
            ]]--
        end
    end




    events = {
        {event_name="f4-isb:modification_save_btn",func =on_off},
        {event_name="isb-f4:closed",func =close},
        {event_name = "isb-save:send_player_vehicles",func = getVehTable}

    }
    
    for k,v in ipairs(events) do
        if v.event_name and v.func then 
            addEvent(v.event_name,true)
            addEventHandler(v.event_name,localPlayer,v.func)
        end
    end
    
end)
