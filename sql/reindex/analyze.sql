CREATE TABLE memos (
  id integer,
  content text
);

INSERT INTO memos VALUES (1, 'PostgreSQL is a RDBMS.');
INSERT INTO memos VALUES (2, 'Groonga is fast full text search engine.');
INSERT INTO memos VALUES (3, 'PGroonga is a PostgreSQL extension that uses Groonga.');

CREATE INDEX pgrn_index ON memos USING pgroonga (content);

SELECT pgroonga.command(
         'object_exist ' ||
           'Sources' || (SELECT oid
                           FROM pg_class
                          WHERE relname = 'pgrn_index'))::jsonb->1;
SELECT pgroonga.command(
         'object_exist ' ||
           'Sources' || (SELECT relfilenode
                           FROM pg_class
                          WHERE relname = 'pgrn_index'))::jsonb->1;

REINDEX INDEX pgrn_index;

ANALYZE;

SELECT pgroonga.command(
         'object_exist ' ||
           'Sources' || (SELECT oid
                           FROM pg_class
                          WHERE relname = 'pgrn_index'))::jsonb->1;
SELECT pgroonga.command(
         'object_exist ' ||
           'Sources' || (SELECT relfilenode
                           FROM pg_class
                          WHERE relname = 'pgrn_index'))::jsonb->1;

SET enable_seqscan = off;
SET enable_indexscan = on;
SET enable_bitmapscan = off;

SELECT id, content
  FROM memos
 WHERE content %% 'PGroonga' AND content %% 'Groonga';

DROP TABLE memos;
