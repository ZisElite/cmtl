### variables
entry_pre, container_pre:
They preload the *entry.tscn* and *entries_container.tscn*, respectively, for later use

container:
Holds the container that has the file entries

selected:
A list with all the selected files




### functions
populate_files(files):
Run *add_single_file* for each file in files

add_single_file(file):
Create new *entry* node, configure it and add it to the scene.