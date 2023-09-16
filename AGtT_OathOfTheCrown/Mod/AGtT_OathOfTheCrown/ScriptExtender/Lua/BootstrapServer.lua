local modGuid = "9ac26df0-2d5b-4a62-b204-ac5ce32f2949"
local subClassGuid = "02dff6ea-ea40-4ab6-9f23-e5b919ddde4a"
local BootStrap = {}

-- If SCF is loaded, use it to load Subclass into Progressions. Otherwise, DIY.
if Ext.Mod.IsModLoaded("67fbbd53-7c7d-4cfa-9409-6d737b4d92a9") then
  local subClasses = {
    AuthorSubclass = {
      modGuid = modGuid,
      subClassGuid = subClassGuid,
      class = "paladin",
      subClassName = "Oath of the Crown"
    }
  }

  local function OnSessionLoaded()
    Mods.SubclassCompatibilityFramework = Mods.SubclassCompatibilityFramework or {}
    Mods.SubclassCompatibilityFramework.API = Mods.SubclassCompatibilityFramework.Api or {}
    Mods.SubclassCompatibilityFramework.API.InsertSubClasses(subClasses)
  end

  Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)
else
  local function InsertSubClass(arr)
    table.insert(arr, subClassGuid)
  end

  local function DetectSubClass(arr)
    for _, value in pairs(arr) do
      if value == subClassGuid then
        return true
      end
    end
  end

  function BootStrap.loadSubClass(arr)
    if arr ~= nil then
      local found = DetectSubClass(arr)
      if not found then
        InsertSubClass(arr)
      end
    end
  end

  BootStrap.loadSubClass(Ext.Definition.Get("b60618d1-c262-42b5-9fdd-2c0f7aa5e5af", "Progression").SubClasses)
  BootStrap.loadSubClass(Ext.Definition.Get("1f5396ad-65e3-4ed5-a339-d76b11af96ea", "Progression").SubClasses)
end
