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
              title = string.rep('¨¨..', 10),  -- Add a long string of non-breaking spaces to make the dialog a bit wider...
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
          }

          local result = LrDialogs.presentModalDialog({
            title = "Select Collection Set",
            contents = contents,
          })

          if result == 'ok' then
            LrTasks.startAsyncTask(function()
              ExportCollectionSet.exportCollectionSet(properties.collectionSet, properties.rootPath)
            end)
          end
        end
      )
	end)
end

showExportDialog()
