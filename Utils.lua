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
  local exportSettings = {}

  if not path then
    exportSettings = {
      LR_format = "JPEG",
      LR_jpeg_quality = 1,
      LR_export_colorSpace = "AdobeRGB",
      LR_minimizeEmbeddedMetadata = false,
      LR_size_resolution = 300,
      LR_size_doConstrain = false,
      LR_size_doNotEnlarge = true,
      LR_metadata_keywordOptions = "lightroomHierarchical",
      LR_removeLocationMetadata = false,
      LR_export_destinationType = "specificFolder",
      LR_export_useSubfolder = false,
      LR_reimportExportedPhoto = false,
      LR_export_destinationPathPrefix = outputPath,
      LR_collisionHandling = "overwrite",
      LR_initialSequenceNumber = 1,
      LR_renamingTokensOn = true,
      LR_tokens = "{{date_YY}}{{date_MM}}{{date_DD}}_{{naming_sequenceNumber_3Digits}} - {{com.adobe.title}}"
    }
  else
    local file
    file = io.open(path, 'r')
  
    if file then
      for line in file:lines() do
        local key, value = string.match(line, "(.-)=(.*)")
        if key == 'LR_jpeg_quality' or key == 'LR_size_resolution' or key == 'LR_initialSequenceNumber' then
          value = tonumber(value)  -- Convert to number
        elseif key == 'LR_minimizeEmbeddedMetadata' or key == 'LR_size_doConstrain' or key == 'LR_size_doNotEnlarge' or key == 'LR_export_useSubfolder' or key == 'LR_reimportExportedPhoto' or key == 'LR_renamingTokensOn' then
          value = value == 'true'  -- Convert to boolean
        elseif key == 'LR_export_destinationType' or key == 'LR_export_destinationPathPrefix' or key == 'LR_export_useSubfolder' then
          
        else
          value = tostring(value)
        end
        exportSettings[key] = value
      end
      file:close()
    end
  end
  
  return exportSettings
end

return {
  createFolder = createFolder,
  defineDestination = defineDestination,
  len = len,
  loadExportSettings = loadExportSettings
}