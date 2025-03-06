local CutsceneObjects = {}
CutsceneObjects.isInit = false
CutsceneObjects.lastStop = os.time()

function CutsceneObjects.Init()
    if Archipelago.IsConnected() and not CutsceneObjects.isInit then
        CutsceneObjects.isInit = true
        CutsceneObjects.Shotgun()
        CutsceneObjects.Lockpick()
        CutsceneObjects.OverrideKey()
        CutsceneObjects.CultureSample()
    end

    -- if the last check for cutscene objects was X time ago or more, trigger another removal
    if os.time() - CutsceneObjects.lastStop > 15 then -- 15 seconds
        CutsceneObjects.isInit = false
    end
end

function CutsceneObjects.Shotgun()
    local shotgunObject = Helpers.gameObject("0503_sm44_404_ES_ShotgunCase01A_gimmick")
    if not shotgunObject then
        return
    end
    local shotgunComponent = Helpers.component(shotgunObject, "gimmick.action.EsGimmickOpenObject")
    shotgunComponent:set_field("bGetItemForce", false)
end

function CutsceneObjects.Lockpick()
    local lockpickObject = Helpers.gameObject("EventPlay_EV322_k")
    if not lockpickObject then
        return
    end
    local lockpickComponent = Helpers.component(lockpickObject, "gimmick.option.AddItemToInventorySettings")
    lockpickComponent:set_field("Enable", false)
end

function CutsceneObjects.OverrideKey()
    local overrideObject = Helpers.gameObject("sm42_503_ES_LabMonitor04A_00_gimmick")
    if not overrideObject then
        return
    end
    local overrideComponent = Helpers.component(overrideObject, "gimmick.option.AddItemToInventorySettings")
    overrideComponent:set_field("Enable", false)
end

function CutsceneObjects.CultureSample()
    local cultureObject = Helpers.gameObject("st05_0107_sm41_426_ES_GrowthMachine01A_gimmick")
    if not cultureObject then
        return
    end
    local cultureComponent = Helpers.component(cultureObject, "gimmick.option.AddItemToInventorySettings")
    cultureComponent:set_field("Enable", false)
end

function CutsceneObjects.TestTube()
    -- Retrieve the inventory settings component
    local inventorySettings = Helpers.component(Helpers.gameObject("st05_0110_sm41_427_ES_VaccineFreezer01A_gimmick"), "gimmick.option.AddItemsToInventorySettings")

    -- Check if the inventory settings were successfully retrieved
    if not inventorySettings then
        print("Failed to retrieve inventory settings")
        return
    end

    -- Retrieve the SettingList from the inventory settings
    local settingList = inventorySettings:get_field("SettingList")

    -- Check if SettingList is valid and not empty
    if not settingList or #settingList == 0 then
        print("SettingList is empty or missing")
        return
    end

    -- Access the first element in the SettingList (index 1 in Lua)
    local firstSetting = settingList[1]

    -- Check if the firstSetting is valid and has the PopEnable field
    if not firstSetting then
        print("First setting is missing")
        return
    end

    -- Set the PopEnable field to false
    local success = firstSetting:set_field("PopEnable", false)

    -- Check if the field was successfully set
    if success then
        print("PopEnable set to false for first inventory setting")
    else
        print("Failed to set PopEnable for first inventory setting")
    end
end

return CutsceneObjects