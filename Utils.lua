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

return {
  createFolder = createFolder,
  defineDestination = defineDestination,
  len = len
}