files='
test-data.zip
'

for file in $files; do
    python3 load_tweets.py --db postgresql://postgres:pass@localhost:22072/postgres --inputs test-data.zip 
done

for file in $files; do
    unzip -p test-data.zip | sed 's/\\u0000//g' | psql  postgresql://postgres:pass@localhost:12072/ -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
done
