import db

users = []

class User():
    def __init__(self, username, libraries, tags):
        self.username = username
        self.libraries = libraries
        self.tags = tags



def init():
    users = db.get_all_users()
    if users:
        return True
    return False
