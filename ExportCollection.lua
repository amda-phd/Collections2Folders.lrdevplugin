local LrExportSession = import 'LrExportSession'
local Utils = require 'Utils'

local function exportCollection(collection, path) 
  local photos = collection:getPhotos()

  if (Utils.len(photos) == 0) then
    return
  end

  local folderName = collection:getName():gsub("/", '-'):gsub(":", "-"):gsub("!", ""):gsub("?", ""):gsub("¿", ""):gsub("¡", "")
  local outputPath = Utils.defineDestination(path, folderName)

  local exportSettings = {
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

  local exportSession = LrExportSession({
    photosToExport = photos,
    exportSettings = exportSettings,
    outputPath = outputPath,
  })

  exportSession:doExportOnCurrentTask()
end

return {
  exportCollection = exportCollection
}

