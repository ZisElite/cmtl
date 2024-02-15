### variables
entries_node, tags_node, paths_node, controller, scanning, sqlite:
They hold the corresponding node of the application.

new_files, new_tag, remove_tag, apply_filter, clear_filter, clear_filter, apply_tag_to_files, remove_tag_from_files, back_button:
They hold the corresponding buttons of the *library view* UI.

entry_pre:
Preloads the *entry.tscn* scene for later use.

paths_list, active_tag, active_path:
Hold the respective data.

filters_active:
flag to keep track of if filters are applied.

paths, tags:
Dictionaries that keep which files belong to each tag/path filter.

total_scanned_subs, total_scanned_files:
Counter for respective values.

formats:
A list with all the possible music file formats.

thread:
Holds the thread object.




### functions
setup(lib):
Take the appropriate steps to load the *library view* with the data of the selected library.

create_path_dict(results):
Create the *paths* dictionary's keys.

create_tag_dict(results):
Create the *tags* dictionary's keys and populate them.

\_main_menu:
Reset the *library view* before returning to the main menu UI.

\_open_files_dialogue:
enables the dialogue to select a file/dictionary.

\_add_path(path, type):
If the path is not already in the library, add it, scan it for files and add them to the files container.

\_remove_path(id, nam):
Try to remove the selected path from the databse, if it succeeds, clean the leftover data in the *library view*.

\_start_scanning(mode="all", path=null):
Start the scanning process by making a thread and starting it.

scan_paths(mode="all", single_path=null):
Enable the scanning UI and scan all the paths in paths_list or in the single path.

scan_single_path(path):
Scans a single path for files and add them to the scene.

\_scan_complete:
Apply filters and disable the scanning UI.

\_update_scanning_screen(which, number):
Update the scanning UI text according to *which*, subdirs or files.

\_add_tag:
enables the *new tag* dialogue.

\_new_tag_confirmed:
If a tag is providedm add it to the *library view*.

\_remove_tag:
enables the *remove tag* dialogue.

\_remove_tag_confirmed:
If a tag is provided, remove it from the *library view*.

\_apply_filters:
Checks if tag/path is selected, add the corresponding file ids in a list and send it to the *entries manager*.

\_clear_filters:
Remove all filters.

\_apply_tag_to_files:
If a tag is selected, apply it to all the selected files.

\_remove_tag_from_files:
If a tag is selected, remove it from al selected files.

filters:
Selectes how to apply the filters.

\_exit_tree:
clean up the completed threads.