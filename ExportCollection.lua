local LrTasks = import 'LrTasks'
local LrExportSession = import 'LrExportSession'
local LrApplication = import 'LrApplication'
local LrPathUtils = import 'LrPathUtils'
local LrFileUtils = import 'LrFileUtils'

local catalog = LrApplication.activeCatalog()
local rootPath = "/path/to/your/photos"

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

local function exportCollection(collection, path) 
  local photos = collection:getPhotos()

  if (len(photos) == 0) then
    return
  end

  local folderName = collection:getName():gsub("/", '-'):gsub(":", "-"):gsub("!", ""):gsub("?", ""):gsub("¿", ""):gsub("¡", "")
  local outputPath = defineDestination(path, folderName)

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

local function exportCollectionSet(collectionSet, path)
  local childCollectionSets = collectionSet:getChildCollectionSets()
  local childCollections = collectionSet:getChildCollections()
  local outputPath = defineDestination(path, collectionSet:getName())

  for _, childCollectionSet in ipairs(childCollectionSets) do
    exportCollectionSet(childCollectionSet, outputPath)
  end

  for _, childCollection in ipairs(childCollections) do
    exportCollection(childCollection, outputPath)
  end
end

LrTasks.startAsyncTask(
  function()
    
    -- local collections = catalog:getChildCollections()
    -- exportCollection(collections[1])

    local collectionSets = catalog:getChildCollectionSets()
    -- exportCollectionSet(collectionSets[6], rootPath)
    for _, collectionSet in ipairs(collectionSets) do
      if collectionSet:getName() == "Móvil - Compacta" then
        exportCollectionSet(collectionSet, rootPath)
      end
    end

    -- Iterate through all collections
    -- for _, collection in ipairs(collections) do
    --   -- Check if it's a collection folder (optional)
    --   if collection:getCollectionType() == "folder" then
    --     exportCollection(collection)
    --   end
    -- end
  end
)


