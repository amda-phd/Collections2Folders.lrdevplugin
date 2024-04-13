local LrFunctionContext = import 'LrFunctionContext'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'
local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'

local ExportCollectionSet = require 'ExportCollectionSet'

local function showExportDialog()

	LrFunctionContext.callWithContext( "showExportDialog", function( context )
    local f = LrView.osFactory()
    local properties = LrBinding.makePropertyTable(context)

      LrTasks.startAsyncTask(
        function()
          local catalog = LrApplication.activeCatalog()
          local collectionSets = catalog:getChildCollectionSets()
          local items = {}

          for _, collectionSet in ipairs(collectionSets) do
            table.insert(items, {title = collectionSet:getName(), value = collectionSet})
          end

          
          properties.collectionSet = items[1].value

          local contents = f:column {
            bind_to_object = properties,
            spacing = f:control_spacing(),
            f:static_text {
              title = "Pressing OK will export the selected collection set and all their contents to the selected path.",
              fill_horizontal = 1,
            },
            f:static_text {
              title = "Remember that, depending on the number of nested collections, this might take a while:",
              fill_horizontal = 1,
            },
            f:popup_menu {
              value = LrView.bind('collectionSet'),
              items = items,
            },
            f:push_button {
              title = "Select Folder",
              action = function()
                local result = LrDialogs.runOpenPanel({canChooseDirectories = true, allowsMultipleSelection = false, canChooseFiles = false})
                if result then
                  properties.rootPath = result[1]
                end
              end,
            },
            f:static_text {
              title = LrView.bind('rootPath'),
              fill_horizontal = 1 -- This makes the text line extend horizontally. Otherwise, it's barely visible
            },
            f:static_text {
              title = "A export settings file is optional, but not providing it will use Lightroom's defaults",
              fill_horizontal = 1,
            },
            f:push_button {
              title = "Select Export Settings",
              action = function()
                local result = LrDialogs.runOpenPanel({canChooseFiles = true, allowsMultipleSelection = false, canChooseDirectories = false, prompt = "Select ExportSettings.lrtemplate"})
                if result then
                  local filePath = result[1]
                  if filePath:sub(-11) ~= ".lrtemplate" then
                    LrDialogs.message("Error", "Please select a .lrtemplate file.", "critical")
                  else
                    properties.exportSettingsPath = filePath
                  end
                end
              end,
            },
            f:static_text {
              title = LrView.bind('exportSettingsPath'),
              fill_horizontal = 1,
            },
          }

          local result = LrDialogs.presentModalDialog({
            title = "Select and export one Collection Set",
            contents = contents,
          })

          if result == 'ok' then
            if properties.rootPath then
              LrTasks.startAsyncTask(function()
                ExportCollectionSet.exportCollectionSet(properties.collectionSet, properties.rootPath, properties.exportSettingsPath)
              end)
            else
              LrDialogs.message("Error", "Please select a folder before proceeding.", "critical")
            end
          end
        end
      )
	end)
end

showExportDialog()
