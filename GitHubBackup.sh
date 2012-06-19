#!/bin/bash
# \author Sébastien Boisvert

user=$1


mkdir -p repositories-$user

# fetch the list

# API v2
#curl http://github.com/api/v2/json/repos/show/$user > data.txt

# API v3
curl -k https://api.github.com/users/$user/repos > data.txt

grep '"name":' data.txt |awk '{print $2}' |sed 's/",//g'|sed 's/"//g'> projects.txt

# clone each repository

for i in $(cat projects.txt)
do
	cd repositories-$user
	git clone git://github.com/$user/$i.git
	cd ..
done

# pull each repository

for i in $(cat projects.txt)
do
	cd repositories-$user/$i
	git pull
	cd ..
	cd ..
done

# add an entry in the log

date >> Log.txt
