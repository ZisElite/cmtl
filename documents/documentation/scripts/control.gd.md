### variables
**main, new_lib, open_lib, view_lib, sqlite :
They hold the corresponding node of the application.


### functions
\_main_menu, \_new_library, \_open_library, \_view_library(lib): 
It switched the *corresponding* UI on and disables the other UIs.

\_check_new(lib):
Creates new library if it doesn't exist, and switches to that library's view.

#v0-6 **removed** 
~~\_remove_lib(lib):
Removes the selected library, deleting the .*db* file.~~

\_free_esc:
set *free_esc* flag to true.

\_input(event):
Checks if the *esc* button is pressed and closes the application. If a pop-up is active, disable this.