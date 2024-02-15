### variables
text_field, confirm, cancel, #v0-6 message, logger, sqlite:
They hold the corresponding node of *new library* menu.


### functions
\_confirm:
~~emits the *new_pressed* signal with the text of the *text_field* as a parameter~~
#v0-6 Checks if there is already a library with the chosen game and creates one if it doesn't..

\_clear_text:
Clears the text field when the user leaves this UI.

update_message(text):
Updates the text of the message with the given value.