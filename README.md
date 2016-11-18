# Install

```
# echo "deb http://www.apache.org/dist/cassandra/debian 36x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
# curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
# apt update
# apt install cassandra
```

and start it with

```
# service cassandra start
```

and stop it with

```
# service cassandra stop
```

and watch the logs with

```
# tail -F /var/log/cassandra/*
```

# Keyspace

## List

```
DESCRIBE keyspaces;
```

## Create
```
CREATE KEYSPACE Test
       WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 3};
```

Two replication strategies are available:

* SimpleStrategy: Use for a single data center only. If you ever intend more than one data center, use the NetworkTopologyStrategy.
* NetworkTopologyStrategy: Highly recommended for most deployments because it is much easier to expand to multiple data centers when required by future expansion.

and the Replication Factor, required if class is SimpleStrategy; otherwise, not used. The number of replicas of data on multiple nodes.

## Use

```
USE test;
```

## Alter

```
ALTER KEYSPACE Test
      WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 4};
```

## Drop

```
DROP KEYSPACE Test;
```

# Table

## List

```
DESCRIBE tables;
```

## Create

```
CREATE TABLE roydashes(
  publisher_id INT,
  reference_period text,
  PRIMARY KEY (publisher_id)
) WITH comment='RoyDash reports by publisher';
```

```
CREATE TABLE roydashes (
    reference_period text,
    publisher_id text,
    accounts text,
    catalogs text,
    songs text,
    PRIMARY KEY (reference_period, publisher_id)
) WITH CLUSTERING ORDER BY (publisher_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = 'RoyDash reports by publisher'
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
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
```

## Alter

```
ALTER TABLE roydashes ALTER reference_period TYPE set<text>;

ALTER TABLE roydashes ADD some_column some_type;

ALTER TABLE roydashes
      WITH  comment = 'RoyDash reports by publisher'
      AND   read_repair_chance = 0.2;
```

## Drop

```
DROP TABLE IF EXISTS roydashes;
```

## Data Manipulation

## Insert

```
INSERT INTO roydashes
```

# UDT (User-Defined Types)

## Create

```
CREATE TYPE phone (
    country_code int,
    number text,
);

CREATE TYPE address (
       street text,
       city text,
       zip text,
       phones map<text, frozen<phone>>
);

CREATE TABLE user (
    name text PRIMARY KEY,
    addresses map<text, frozen<address>>
);

INSERT INTO user (name, addresses)
VALUES ('z3 Pr3z1den7', {
    'home' : {
        street: '1600 Pennsylvania Ave NW',
        city: 'Washington',
        zip: '20500',
        phones: { 'cell' : { country_code: 1, number: '202 456-1111' },
                  'landline' : { country_code: 1, number: '...' } }
    },
    'work' : {
        street: '1600 Pennsylvania Ave NW',
        city: 'Washington',
        zip: '20500',
        phones: { 'fax' : { country_code: 1, number: '...' } }
    }
})

```

```
CREATE TYPE IF NOT EXISTS sd(
  id int,
  ctry  varchar,
  en    varchar,
  st    varchar
);
```

