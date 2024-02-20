#v0-7
-Added loading screens for when loading a library and when applying filters.
-Fixed a bug where clearing filters did not work.
-Fixed a bug where the library in the selection screen would appear deselected, but it would still be considered selected.

#v0-6 
-Added message fields to the various screens to display the success/failure of different operations.
-Fixed a bug where newly created libraries couldn't be deleted without restarting the application
-Fixed a bug where removing a tag from any file would reset the containers, deleting everything from the file list.
-Fixed a bug where if a tag was selected and a tag was removed from one of the filtered files, it would remove all filters.
-When trying to create new tags and paths, it first checks if the provided entry already exists in the database. This way it can differentiate between the unique constraint and other errors.
-All main scenes had a ScrollContainer at the top for some reason, so i removed it and fixed the paths in the get_node() calls.
-Added new Guide screen, with screenshots and instructions on what each element of the UI is.
-Added print messages for logging.