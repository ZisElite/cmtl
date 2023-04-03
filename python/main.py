import os

import db


def main():
    db.init(os.getcwd())
    
if __name__ == "__main__":
    main()