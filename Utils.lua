local LrPathUtils = import 'LrPathUtils'
local LrFileUtils = import 'LrFileUtils'

local function createFolder(path)
  if not LrFileUtils.exists(path) then
    LrFileUtils.createDirectory(path)
  end
end

local function defineDestination(root, name)
  local outputPath = LrPathUtils.child(root, name)
  createFolder(outputPath)
  return outputPath
end

local function len(array)
  local i=0 for _ in pairs(array) do
    i = i + 1
  end
  return i
end

local function loadExportSettings(path)
  -- Use the default settings file if no path is provided
  if not path then
    return {}
  end

  -- Load the .lrtemplate file
  local file = io.open(path, "r")
  if file then
    local content = file:read("*all")
    file:close()

    -- Load and run the content as a Lua chunk
    local settingsFunc, err = loadstring(content .. "; return s")
    if err then
      print("Error loading settings: " .. err)
      return {}
    end

    if type(settingsFunc) == 'function' then
      local success, settingsTable = pcall(settingsFunc)
      if success and type(settingsTable) == 'table' and settingsTable.value then
        return settingsTable.value
      else
        print("Error running settings function: " .. tostring(settingsTable))
      end
    else
      print("Error: settingsFunc is not a function")
    end
  end

  return {}
end

return {
  createFolder = createFolder,
  defineDestination = defineDestination,
  len = len,
  loadExportSettings = loadExportSettings
}