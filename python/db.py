import sqlite3
import os

con = None

def init(path):
    db_path = os.path.join(path, "databases")
    print(db_path)
    con = sqlite3.connect(db_path)
    cur = con.cursor()
    cur.execute("""create table if not exists users
                        (
                            id integer primary key autoincrement,
                            username string unique not null,
                            password_hash string not null
                        )""")
