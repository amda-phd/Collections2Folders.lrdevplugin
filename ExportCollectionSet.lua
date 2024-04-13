local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'

local ExportCollection = require 'ExportCollection'
local Utils = require 'Utils'

local function exportCollectionSet(collectionSet, path, exportSettingsPath)
  local exportSettings = Utils.loadExportSettings(exportSettingsPath)

  local childCollectionSets = collectionSet:getChildCollectionSets()
  local childCollections = collectionSet:getChildCollections()
  local outputPath = Utils.defineDestination(path, collectionSet:getName())

  for _, childCollectionSet in ipairs(childCollectionSets) do
    exportCollectionSet(childCollectionSet, outputPath, exportSettingsPath)
  end

  for _, childCollection in ipairs(childCollections) do
    ExportCollection.exportCollection(childCollection, outputPath, exportSettings)
  end
end

local function exportCollectionSets(collectionSets, path, exportSettingsPath)
    for _, collectionSet in ipairs(collectionsSets) do
        exportCollectionSet(collection, path, exportSettingsPath)
    end
end

return {
  exportCollectionSet = exportCollectionSet,
  exportCollectionSets = exportCollectionSets
}


