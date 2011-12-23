user=sebhtml

curl http://github.com/api/v2/json/repos/show/$user > data.txt

sed -i 's/,/ /g' data.txt

for i in $(cat data.txt)
do
	echo $i
done|grep 'name":' > list.txt

sed -i 's/"/ /g' list.txt
sed -i 's/name :/ /g' list.txt

for i in $(cat list.txt)
do
	echo $i
done > projects.txt

for i in $(cat projects.txt)
do
	cd repositories
	git clone git://github.com/$user/$i.git
	cd ..
done

for i in $(cat projects.txt)
do
	cd repositories/$i
	git pull
	cd ..
	cd ..
done
