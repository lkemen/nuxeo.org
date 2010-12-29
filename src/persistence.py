"""
Common code for both the crawler and the server.
"""

import os, sqlite3

DB_FILENAME = "data/nuxeoorg.db"

SCHEMA = """
create table source (
    name text primary key,
    source_url text,
    home_url text,
    title text
);

create table event (
    class text,
    uid text primary key,
    url text,
    title text,
    created time,
    author text
);
"""


def delete_db():
    if os.path.exists(DB_FILENAME):
        os.unlink(DB_FILENAME)

def get_db_connection():
    db_is_new = os.path.exists(DB_FILENAME)
    db = sqlite3.connect(DB_FILENAME)
    db.row_factory = sqlite3.Row
    if not db_is_new:
        db.executescript(SCHEMA)
        db.commit()
    return db


# Poor man's OR

class PersistenceManager(object):
    def __init__(self):
        self.registry = {}

    def register(self, class_):
        self.registry[class_.__name__] = class_

    def save(self, obj):
        db = get_db_connection()
        c = db.cursor()
        c.execute("select count(*) from %s where uid=?" % obj.table_name, (obj.uid,))
        row = c.fetchone()
        if row[0]:
            return

        class_name = obj.__class__.__name__
        print "Saving event:", (class_name, obj.uid, obj.url, obj.title, obj.created, obj.author)
        with db:
            db.execute("insert into event values (?, ?, ?, ?, ?, ?)",
                       (class_name, obj.uid, obj.url, obj.title, obj.created, obj.author))


    def revive(self, cursor, row):
        """Instantiates object from db row."""
        columns = [ c[0] for c in cursor.description ]
        type = row[0]
        class_ = self.registry[type]
        obj = apply(class_)
        for i in range(1, len(columns)):
            setattr(obj, columns[i], row[i])
        return obj

pm = PersistenceManager()

def get_pm():
    return pm