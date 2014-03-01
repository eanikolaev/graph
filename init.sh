USER=enikolaev
BASE=graph
PSQL="psql $BASE $USER"

psql postgres postgres -c "create user $USER"
psql postgres postgres -c "create database $BASE owner $USER"
$PSQL -f init.sql
