CREATE TABLE memos (
  tags text
);

INSERT INTO memos VALUES ('グルンガ');

CREATE INDEX pgrn_index ON memos
 USING pgroonga (tags)
  WITH (normalizer = 'NormalizerNFKC100("unify_kana", true)');

SELECT jsonb_pretty(
  pgroonga_command('select',
                   ARRAY[
                     'table', 'Lexicon' || 'pgrn_index'::regclass::oid || '_0',
                     'limit', '-1',
                     'sort_keys', '_key',
                     'output_columns', '_key',
                     'command_version', '3'
                   ])::jsonb->1->'records'
);

DROP TABLE memos;