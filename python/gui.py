import typing
from tkinter import *
from tkinter import ttk
#import pyqt6_tools

class MainWindow:

    def __init__(self, root: Tk):

        root.title("File tagger")
        width = root.winfo_screenwidth() // 2
        height = root.winfo_screenheight() // 2
        root.geometry(str(width) + 'x' + str(height) + "+" + str(width // 2) + "+" + str(height // 2))
        root.option_add('*tearOff', FALSE)
        menubar = Menu(root)
        menu_file = Menu(menubar)
        menu_edit = Menu(menubar)
        menubar.add_cascade(menu = menu_file, label = "File")
        menubar.add_cascade(menu = menu_edit, label = "Edit")
        root["menu"] = menubar


def main():
    root = Tk()
    MainWindow(root)
    root.mainloop()


if __name__ == "__main__":
    main()
