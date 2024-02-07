### variables
db:
The sqlite object that performs all the sql stuff

dir:
Acceses the file system



### functions
get_libs:
Retuns  a list of all the *.db* files in the user data folder

check_new(lib):
Checks if the file *lib.bg* exists and returns the result

create_new_library(lib):
Creates a new *.db* file using the lib parameter, then execute queries to create the appropriate tables

open_lib(lib):
Sets the active working *.db* 

remove_lib(lib):
Deletes the provided *.db* file

read_table(table):
Returns the data of a whole table

add_path(path, type):
Inserts a new entry to the *paths* table of the active database

remove_path(path_id):
Deletes the provided entry from *paths* table of the active database

add_new_tag(tag_name):
Inserts a new entry to the *tags* tablr of the active database

create_tag_table(title):
Creates a new table on the active database

remove_tag(tag_name):
Deletes the provided entry from the *tags* table of the active database

add_file(file, path_id):
