import os

import db
import users

def main():
    db.init()
    users.init()
    
if __name__ == "__main__":
    main()