return {
  LrSdkVersion = 13.0,
  LrSdkMinimumVersion = 13.0,
  LrToolkitIdentifier = "com.amda.Collections2Folders", 
  LrPluginName = "Collections2Folders",
  LrPluginInfoUrl = "https://github.com/amda/Collections2Folders", -- URL for more info (replace with your GitHub URL)
  LrPluginAuthor = "amda",
  LrPluginVersion = "0.1.0",
  LrPluginDescription = "Export collections and collection sets hierarchy as folders.",
  LrExportMenuItems = {
      {
          title = "Select and export one collection set",
          file = "ExportCollectionSetGUI.lua",
      },
      {
        title = "Export all the collection sets in the catalog",
        file = "ExportAllCollectionSetsGUI.lua",
    },
  },
  UUID = "C728DAA1-036A-4C0A-94D2-7ABECD0EB4C6",
  UUIDs = {
      main = "C728DAA1-036A-4C0A-94D2-7ABECD0EB4C6",
      ["ExportCollections.lua"] = "AB28E7DE-3C61-4AAE-B73D-5DF3C92FFBA1",
  },
}
