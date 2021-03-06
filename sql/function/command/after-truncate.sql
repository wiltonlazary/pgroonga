CREATE TABLE memos (
  content text
);

CREATE INDEX pgroonga_index ON memos USING pgroonga (content);

TRUNCATE memos;

INSERT INTO memos VALUES ('PostgreSQL is a RDBMS.');
INSERT INTO memos VALUES ('Groonga is fast full text search engine.');
INSERT INTO memos VALUES ('PGroonga is a PostgreSQL extension that uses Groonga.');

SELECT pgroonga_command('select ' ||
                        pgroonga_table_name('pgroonga_index') ||
                        ' --output_columns content')::json->>1
    AS body;

DROP TABLE memos;
