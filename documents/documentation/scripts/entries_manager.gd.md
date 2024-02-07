### variables
entry_pre, container_pre:
They preload the *entry.tscn* and *entries_container.tscn*, respectively, for later use

master_container, container1, container2:
Holds the containers that handle the file entries

selected:
A list with all the selected files

filters_on:
Boolean flag to know if there are filters used


### functions
populate_files(files):
Run *add_single_file* for each file in files

add_single_file(file):
Create new *entry* node, configure it and add it to the scene

reset_container:
Create the 3 containers if they don't exist, otherwise clear them of their children

filter_files(ids=null, mode="unhide"):
If mode is "unhide", move all entries t ocontainer1 and it.
Else if mode is "filter", hide container1, unhide container2 and move the filtered entries t ocontainer2

remove_entries(path_id):
Unhide everything and remove from scene all entries that much the *path_id*

\_file_selected(file):
Add/remove the clicked entry to the *selected* list