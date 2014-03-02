USER=enikolaev
BASE=graph
PSQL="psql $BASE $USER"

psql postgres postgres -c "create user $USER"
psql postgres postgres -c "create database $BASE owner $USER"
$PSQL -c "create language plpgsql"
$PSQL -f init.sql
