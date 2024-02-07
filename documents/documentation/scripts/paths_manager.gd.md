### variables
container, add, remove, scan, master:
They hold the corresponding nodes

master is the library_view node
scan is the scanning UI

path_pre:
Preloads the *path.tscn* scene for later use

group:
Holds all the created *paths* nodes

selected:
Holdes the currenty selected *path* node

formats:
A list with all the possible music file formats



### functions
get_path_nodes:
Returns all the *path* nodes

populate_paths(paths, initial=false):
Call *add_single_path* for each path in *paths*, and if initial is **true** return a list of all paths

add_single_path(path, ret=false):
Create new *path* node, configure it and add it to the scene. If ret is **true**, return the node

connect_buttons_to_master(node):
Connect the buttons for adding/removing/scanning paths, with the the *library manager*

\_select_path(button):
Toggles whether the button is selected or not

scan_for_files(path):
If path is a file,  return the file name.
Else if path is a directory, recursively scan for directories. In each  iteration, return the files in the directories. Returns the list of all files found

\_remove_path:
If there is a selected *path*, remove the entry from the database and then from the scene