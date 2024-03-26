

gui = {}
elm_colors = {}

function createLoginPanel()
    local gsw,gsh = guiGetScreenSize()
    local main = guiCreateWindow((gsw-350)/2, (gsh-295)/2,350,295,language[language_selection]["window"],false)
    gui.main = {
        elm = main,
        language_row = "window",
    }
    local list = guiCreateGridList(10,25,330,180,false,main)

    gui.list = {
        elm = list,

    }
    guiGridListAddColumn(list,language[language_selection]["veh_name_col"],0.92)

    local get_veh_btn = guiCreateButton(10,209,100,35,language[language_selection]["getVeh"],false,main)
    gui.getVeh = {
        elm = get_veh_btn,
        language_row = "getVeh",
    }


    local set_veh_btn = guiCreateButton(240,209,100,35,language[language_selection]["setVeh"],false,main)
    gui.setVeh = {
        elm = set_veh_btn,
        language_row = "setVeh",
    }
    local vehname = guiCreateEdit(125,209,100,35,"",false,main)
    gui.vehname = {
        elm = vehname,
        language_row = "vehname",
    }

    local remove_veh_btn = guiCreateButton(10,251,160,35,language[language_selection]["remove_vehicle"],false,main)
    gui.remove_veh_btn = {
        elm = remove_veh_btn,
        language_row = "remove_vehicle",
    }
    local delete_veh_btn = guiCreateButton(180,251,160,35,language[language_selection]["delete_vehicle"],false,main)
    gui.delete_veh_btn = {
        elm = delete_veh_btn,
        language_row = "delete_vehicle",
    }

    guiSetVisible(main,false)
end


addEventHandler("onClientResourceStart",resourceRoot,createLoginPanel)



--Change language Function
-------------------------------
function change_language(lng)
    language_selection = lng 
    ---------------------
    --Set Text for all gui
    ----------------------
    for k,v in pairs(gui) do 
        if v.language_row then 
            guiSetText(v.elm,language[lng][v.language_row])
        end
        if v.label_elm then 
            guiSetText(v.label_elm,language[lng][v.language_row])
        end
    end
    
end
addEvent("language:change",true)
addEventHandler("language:change",localPlayer,change_language)
