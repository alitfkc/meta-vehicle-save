global_player_vehicle = {}
----------------------------------
-- DEBUGS WRİTER function --SERVER
----------------------------------
function debug(msg,type,r,g,b)
    outputDebugString(getResourceName(getThisResource()).." : - "..msg,type,r,g,b)
end
db = dbConnect( "sqlite", "data.db")
if  db then 
    debug("player_vehicles.db connected ( - player_vehicles.db database bağlantısı başarılı - ).",3)
else
    debug("player_vehicles.db is not connected ( - player_vehicles.db database bağlantısı yok! - ).",1)
end
-------------------------------------------------
--Pull the vehicle chart (Araba tablosunu çekme)
-------------------------------------------------
function get_cars_table()
    if db then 
        local vehicle = dbPoll(dbQuery(db, "SELECT * FROM player_vehicles"),-1)
        return vehicle
    else
        debug("player_vehicles.db is not connected ( - player_vehicles.db database bağlantısı yok! - ).",1)
    end
end
---------------------------------------------
--resource  opened and attached  db table to global table ( - script çalışınca db araç tablosunu global tabloya ekler - )
----------------------------------------------
function resource_start_db()
    local list = get_cars_table()
    if not list then return end
    for k,v in ipairs(list) do
        local p_table = {}
        for g,s in ipairs(list) do 
            if v.account_name == s.account_name then 
                table.insert(p_table,{account_name = s.account_name,veh_name = s.veh_name,data = fromJSON(s.data)})
            end
       end
       global_player_vehicle[v.account_name] = p_table
    end

end
addEventHandler("onResourceStart",resourceRoot,resource_start_db)

--------------------------------------------------------
-- buy vehicle from car bazaar db ( - araç pazarından araç alma - )
-----------------------------------------
function remove_vehicle_db(account_name,veh_name)
    local status = dbExec(db, "DELETE FROM player_vehicles WHERE account_name = ? AND veh_name = ? ",account_name,veh_name)
    return status
end
-------------------------------------------
-- add car to database ( - veritabanına araba ekle - )
-------------------------------------------
function add_vehicle_db(account_name,veh_name,data)
    local status = dbExec(db,"INSERT INTO player_vehicles (account_name,veh_name,data) VALUES(?,?,?)",account_name,veh_name,data)
    return status
end

----------------------------------------------------
-- vehicle name change ( - araç ismi değiştirme - )
-----------------------------------------------------
function  change_data_db(data,veh_name)
    local status = dbExec(db,"UPDATE player_vehicles SET data = ? WHERE  veh_name= ?",data,veh_name)
    return status
end
