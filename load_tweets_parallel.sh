#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time sh -c 'ls data/* | parallel sh load_denormalized.sh {}'

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time sh -c 'ls data/* | parallel python3 load_tweets.py --db=postgresql://postgres:pass@localhost:5079/postgres --inputs={}'

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time sh -c 'ls data/* | parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:6079/postgres --inputs={}'

