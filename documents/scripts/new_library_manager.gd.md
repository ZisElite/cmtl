### variables
text_field, confirm, cancel, #v0-6 message, sqlite:
They hold the corresponding node of *new library* menu.


### functions
\_confirm:
#v0-6 
Checks if there is already a library with the chosen game and creates one if it doesn't.
~~emits the *new_pressed* signal with the text of the *text_field* as a parameter~~

\_clear_text:
Clears the text field when the user leaves this UI.

#v0-7 **removed** 
~~update_message(text):
Updates the text of the message with the given value.~~