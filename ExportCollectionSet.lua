local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'

local ExportCollection = require 'ExportCollection'
local Utils = require 'Utils'

-- local rootPath = "E:\\Pics\\Test"
-- local catalog = LrApplication.activeCatalog()

local function exportCollectionSet(collectionSet, path)
  local childCollectionSets = collectionSet:getChildCollectionSets()
  local childCollections = collectionSet:getChildCollections()
  local outputPath = Utils.defineDestination(path, collectionSet:getName())

  for _, childCollectionSet in ipairs(childCollectionSets) do
    exportCollectionSet(childCollectionSet, outputPath)
  end

  for _, childCollection in ipairs(childCollections) do
    ExportCollection.exportCollection(childCollection, outputPath)
  end
end

-- LrTasks.startAsyncTask(
--   function()
    
--     -- local collections = catalog:getChildCollections()
--     -- exportCollection(collections[1])

--     local collectionSets = catalog:getChildCollectionSets()
--     -- exportCollectionSet(collectionSets[6], rootPath)
--     for _, collectionSet in ipairs(collectionSets) do
--       if collectionSet:getName() == "Curso de Iluminación" then
--         exportCollectionSet(collectionSet, rootPath)
--       end
--     end
--   end
-- )

local function exportCollectionSets(collectionSets, path)
    -- Iterate through all collections
    for _, collectionSet in ipairs(collectionsSets) do
        exportCollectionSet(collection, path)
    end
end

return {
  exportCollectionSet = exportCollectionSet,
  exportCollectionSets = exportCollectionSets
}


