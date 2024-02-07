### variables
**main, new_lib, open_lib, view_lib, sqlite:**
They hold the corresponding node of the application


### functions
\_main_menu, \_new_library, \_open_library,_view_library: 
It switched the *corresponding* UI on and disables the other UIs

\_check_new(lib):
Creates new library if it doesn't exist, and switches to that library's view

\_remove_lib(lib):
Removes the selected library, deleting the .*db* file

\_input(event):
Checks if the *esc* button is pressed and closes the application