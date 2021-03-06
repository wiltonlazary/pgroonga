CREATE TABLE fruits (
  id int,
  items jsonb
);

INSERT INTO fruits VALUES (1, '{"name": "apple"}');
INSERT INTO fruits VALUES (2, '{"type": "apple"}');
INSERT INTO fruits VALUES (3, '{"name": "peach"}');
INSERT INTO fruits VALUES (4, '{"like": "banana"}');

SET enable_seqscan = on;
SET enable_indexscan = off;
SET enable_bitmapscan = off;

SELECT id, items
  FROM fruits
 WHERE items &@~ 'apple OR banana'
 ORDER BY id;

DROP TABLE fruits;
