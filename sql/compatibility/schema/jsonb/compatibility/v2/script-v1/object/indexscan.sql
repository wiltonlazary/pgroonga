CREATE TABLE logs (
  id int,
  record jsonb
);

INSERT INTO logs VALUES (1, '{"message": {"code": 100, "content": "hello"}}');
INSERT INTO logs VALUES (1, '{"message": "hello"}');
INSERT INTO logs VALUES (1, '{"message": ["hello", "world"]}');

CREATE INDEX pgroonga_index ON logs
  USING pgroonga (record pgroonga.jsonb_ops_v2);

SET enable_seqscan = off;
SET enable_indexscan = on;
SET enable_bitmapscan = off;

SELECT id, record
  FROM logs
 WHERE record @@ 'paths @ ".message" && type == "object"'
 ORDER BY id;

DROP TABLE logs;
