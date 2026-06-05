from contextlib import contextmanager
from pathlib import Path

import psycopg2
import psycopg2.extras
from psycopg2.pool import SimpleConnectionPool

from config import Config

_pool = None


def _connection_kwargs():
    if Config.DATABASE_URL:
        kwargs = {"dsn": Config.DATABASE_URL}
        if "localhost" not in Config.DATABASE_URL and "127.0.0.1" not in Config.DATABASE_URL:
            kwargs["sslmode"] = "require"
        return kwargs

    return {
        "host": Config.DB_HOST,
        "port": Config.DB_PORT,
        "database": Config.DB_NAME,
        "user": Config.DB_USER,
        "password": Config.DB_PASSWORD,
    }


def init_pool():
    global _pool
    if _pool is None:
        _pool = SimpleConnectionPool(minconn=1, maxconn=5, **_connection_kwargs())
    return _pool


def close_pool():
    global _pool
    if _pool is not None:
        _pool.closeall()
        _pool = None


@contextmanager
def get_connection():
    pool = init_pool()
    conn = pool.getconn()
    try:
        yield conn
    finally:
        pool.putconn(conn)


@contextmanager
def get_cursor(commit=False):
    with get_connection() as conn:
        cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        try:
            yield cur
            if commit:
                conn.commit()
        except Exception:
            conn.rollback()
            raise
        finally:
            cur.close()


def init_db():
    schema_path = Path(__file__).with_name("schema.sql")
    with schema_path.open("r", encoding="utf-8") as schema_file:
        schema = schema_file.read()

    with get_cursor(commit=True) as cur:
        cur.execute(schema)
