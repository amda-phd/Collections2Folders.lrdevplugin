return {
  LrSdkVersion = 13.0,
  LrSdkMinimumVersion = 13.0, -- Minimum SDK version required
  LrToolkitIdentifier = "com.amda.Collections2Folders", -- Unique identifier for your plugin
  LrPluginName = "Collections2Folders",
  LrPluginInfoUrl = "https://github.com/amda/Collections2Folders", -- URL for more info (replace with your GitHub URL)
  LrPluginAuthor = "amda",
  LrPluginVersion = "0.1.0",
  LrPluginDescription = "Export collections and collection sets hierarchy as folders.",
  -- LrInitPlugin = "Init.lua", -- The entry point for your plugin
  LrExportMenuItems = {
      {
          title = "Export Collections and Sets as Folders",
          file = "ExportCollectionSet.lua", -- Replace with the name of your Lua file containing export functionality
      },
  },
  UUID = "C728DAA1-036A-4C0A-94D2-7ABECD0EB4C6", -- Generated UUID for your plugin
  UUIDs = {
      main = "C728DAA1-036A-4C0A-94D2-7ABECD0EB4C6", -- Main UUID for the plugin
      ["ExportCollections.lua"] = "AB28E7DE-3C61-4AAE-B73D-5DF3C92FFBA1", -- UUID for your export Lua file
  },
}
