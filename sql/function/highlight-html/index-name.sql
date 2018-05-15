CREATE TABLE memos (
  tags text
);

CREATE INDEX pgrn_index ON memos
 USING pgroonga (tags)
  WITH (tokenizer = 'TokenNgram("loose_symbol", true, "report_source_location", true)',
        normalizer = 'NormalizerNFKC100("unify_kana", true)');

SELECT pgroonga_highlight_html(
  'この八百屋のリンゴはおいしい。' ||
  '連絡先は０９０-12345678だそうだ。',
  ARRAY['りんご', '（090）1234５６７８'],
  'pgrn_index');

DROP TABLE memos;
