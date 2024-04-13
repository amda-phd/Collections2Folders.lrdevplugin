# Collections2Folders

![Adobe Lightroom Classic](https://img.shields.io/badge/Adobe%20Lightroom%20Classic-31A8FF.svg?style=for-the-badge&logo=Adobe%20Lightroom%20Classic&logoColor=white)![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

## Description

👋 Hi, Adobe Lightroom Classic user! Have you ever wanted to export all the collections contained in a collection set at once, with the same settings and maintaining the collection set's hierarchy as folders? Yeah, me too. That's what I wrote this simple plugin for.

### Warning

Since I believe that such a basic feature should be provided by Adobe out of the box, I've decided to make this plugin public and available for anyone who might find it useful.

So, if you're a **Lightroom user** 📷, please remember:

- This plugin comes with no warranty at all.
- Read the instructions before using it.
- This plugin has been developed and tested on Lightroom Classic 13 running on Windows 11. I cannot answer for its behavior with other versions or operative systems.

If you're a fellow **developer** 🖥️ frustrated with the poor documentation provided by Adobe for anyone seeking to use its Lightroom SDK to develop a plugin, feel free to fork, explore and copy whatever you need from this project. Of course, there are lots of better plugins out there, but this one is simple enough to learn some of the ropes.

## Instructions

### Installation

Install this plugin like any other Lightroom Classic plugin:

1. Download this repo or clone it using `git clone `. Make sure the resulting folder containing the repo is called `Collections2Folders.lrplugin` and that it's placed in a suitable location in your machine.
2. In Lightroom's plugin manager, add a new plugin and select the folder that you downloaded in the previous step.
3. That's it, the plugin is installed. You should have access to its features in `Archive` -> `Plugin extras` -> `Collections2Folders`. You should see what is displayed in the image below.

![Collections2Folders plugin features](/assets/Collections2Foldes_features.png)

### Use

The plugin offers two basic ways of working, both rather similar.

#### Export the contents from one collection set

![Collections2Folders export one collection set feature](/assets/Collections2Folders_export_one.png)

This dialog will allow you to choose one collection set from your catalog, a destination folder to export it and, optionally, some export settings. Clickin the 'OK' button will trigger:

- The creation of a folder with the collection set's name within the selected destination folder.
- The creation of a subfolder for each collection contained in the set, with the same name as each collection, in which the collection's photographs will be exported.
- The same as in the two previous steps for any collection set contained within the parent set.

#### Export the contents from all the collection sets in the catalog

![Collections2Folders export all collection sets feature](/assets/Collections2Folders_export_all.png)

This dialog works exactly like the previous one, but instead of selecting just one collection set from your catalog, it exports all of them one by one. Obviously, use this feature with care, as for large catalogs such export can be demanding for your equipment.

### Including export settings

Unfortunately, I haven't found a way to access the user's export presets from the Lightroom SDK, so I cannot offer a way to select your export settings as you have them in Lightroom's export dialog.