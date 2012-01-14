#!/bin/bash
# \author Sébastien Boisvert

user=$1


mkdir -p repositories-$user

# fetch the list

curl http://github.com/api/v2/json/repos/show/$user > data.txt

sed -i 's/,/ /g' data.txt

for i in $(cat data.txt)
do
	echo $i
done|grep 'name":' > list.txt

sed -i 's/"/ /g' list.txt
sed -i 's/name :/ /g' list.txt

# convert the list

for i in $(cat list.txt)
do
	echo $i
done > projects.txt

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
