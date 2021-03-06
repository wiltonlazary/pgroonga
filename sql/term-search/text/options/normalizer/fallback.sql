CREATE TABLE tags (
  name text
);

CREATE INDEX pgrn_index ON tags
  USING pgroonga (name pgroonga_text_term_search_ops_v2)
  WITH (normalizer = 'NormalizerNFKC51');

SELECT entry->>7 AS normalizer
  FROM jsonb_array_elements((pgroonga_command('table_list')::jsonb#>'{1}') - 0)
       AS entry
 WHERE entry->>1 = 'Lexicon' || 'pgrn_index'::regclass::oid || '_0';

DROP TABLE tags;
