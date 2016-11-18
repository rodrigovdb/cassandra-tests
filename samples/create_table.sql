CREATE TYPE IF NOT EXISTS stdt(
  date varchar
);

CREATE TYPE IF NOT EXISTS st(
  id        int,
  ctry      varchar,
  en        varchar,
  st        varchar,
  stdt      frozen<stdt>,
  defaultSt boolean
);

CREATE TYPE IF NOT EXISTS lab(
  id    int,
  ctry  varchar,
  nm    varchar,
  p     varchar
);

CREATE TABLE IF NOT EXISTS roydashes_stash (
  id      int PRIMARY KEY,
  title   varchar,
  dur     decimal,
  num     int,
  vol     int,
  ex      boolean,
  aId     int,
  aNm     varchar,
  tbId    int,
  tbNm    varchar,
  img     varchar,
  als     varchar,
  prev    varchar,
  st      set<frozen<st>>,
  str     boolean,
  right   boolean,
  md      varchar,
  lab     set<frozen<lab>>,
  p       int,
  fUd     frozen<stdt>,
  ma      boolean,
  rnk     decimal,
  tasort  int,
  rtId    varchar,
  rrId    varchar
) WITH bloom_filter_fp_chance = 0.01
  AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
  AND comment = 'RoyDash reports'
  AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '31', 'min_threshold': '4'}
  AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
  AND crc_check_chance = 1.0
  AND dclocal_read_repair_chance = 0.1
  AND default_time_to_live = 0
  AND gc_grace_seconds = 864000
  AND max_index_interval = 2048
  AND memtable_flush_period_in_ms = 0
  AND min_index_interval = 128
  AND read_repair_chance = 0.0
  AND speculative_retry = '99PERCENTILE';


