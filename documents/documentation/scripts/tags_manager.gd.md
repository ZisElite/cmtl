### variables
container, add, remove, master:
They hold the corresponding nodes

master is the library_view node

tag_pre:
Preloads the *tag.tscn* scene for later use

group:
Holds all the created *tags* nodes

selected:
Holdes the currenty selected *tags* node



### functions
connect_buttons_to_master(node):
Connect the buttons for adding/removing tags with the *library manager*

\_select_tag(button):
Toggles whether the button is selected or not

add_tag(tag):
Create new *tag* node, configure it and add it to the scene

remove_tag(id):
Removes the *tag* node from the database and the scene tree