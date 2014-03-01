USER=enikolaev
BASE=graph

psql postgres postgres -c "create user $USER"
psql postgres postgres -c "create database $BASE owner $USER"
