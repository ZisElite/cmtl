import sqlite3
import os

root_path = os.getcwd()
con = sqlite3.connect(os.path.join(root_path, "data.db"))

def init():
    cur = con.cursor()
    cur.execute("""create table if not exists users
                        (
                            id integer primary key autoincrement,
                            username string unique not null,
                            password_hash string not null
                        )""")
    cur.execute("""create table if not exists libraries
                        (
                            id integer primary key autoincrement,
                            user_id integer references users (id) on delete cascade not null,
                            name string unique not null
                        )""")
    cur.execute("""create table if not exists paths
                        (
                            user_id integer references users (id) on delete cascade not null,
                            library_id integer references libraries (id) on delete cascade,
                            path string not null
                        )""")
    cur.execute("""create table if not exists tags
                        (
                            user_id integer references users (id) on delete cascade not null,
                            name string not null
                        )""")

def reset(tables):
    cur = con.cursor()
    for i in tables:
        sql = "drop table if exists " + i
        cur.execute(sql)
    init()