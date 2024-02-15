### variables
confirm, delete, cancel, scroll:
They hold the corresponding node of *open library* menu
scroll is the container with all the libraries.

lib_pre:
Preloads the *library.tscn*.

selected:
Holds the last selected *library*.

### functions
populate_list(files):
Populates the *scroll* container by calling the *add_single_lib* function for each file found in the user data.

add_single_lib(title):
Has a string *title* as a parameter.
Creates a new *lib_pre* instance, gives it the appropriate text and connects its signal to *self* function *\_select*.

\_select(nam):
It is called when a *library* is selected and it saves it.

\_clear_buttons:
Clears the *selected* variable.

\_check_pressed:
If there is a selected *library*, send signal to *control* to load that library.

#v0-6 **removed**
~~\_send_for_deletion:
Check if there is a selected library and send it for deletion.~~

#v0-6 **updated** remove_lib(lib):
Checks if there is a selected library, then deletes it from the user files. If everything goes well, the library is removed from the list.