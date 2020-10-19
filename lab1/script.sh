#!/bin/bash

# 1
mkdir ~/test && cd ~/test

# 2
{
	find /etc/*/ -maxdepth 0 -type d;
	find /etc/.*/ -maxdepth 0 -type d -not -path "/etc/\./" -not -path "/etc/\.\./*";
	find /etc -maxdepth 1 -type f;
} > list

# 3
find /etc -maxdepth 1 -type d -not -path "/etc" | wc -l >> list
find /etc -maxdepth 1 -type f -name ".*" | wc -l >> list

# 4
mkdir links

# 5
ln ./list ./links/list_hlink

# 6
ln -s ~/test/list links/list_slink

# 7
ls -Ul ./links/list_hlink ./list ./links/list_slink | awk '{print $2}'

# 8
cat ./list | wc -l >> ./links/list_hlink

# 9
cmp -s ./links/list_hlink ./links/list_slink && echo "YES"

# 10
mv list list1

# 11
cmp -s ./links/list_hlink ./links/list_slink && echo "YES"

# 12
cd ~ && ln -s ./test/links

# 13
find /etc -name "*.conf" -type f > list_conf

# 14
find /etc -name "*.d" -type d > list_d

# 15
cat list_conf list_d > list_conf_d

# 16
mkdir ~/test/.sub

# 17
cp list_conf_d test/.sub/list_conf_d

# 18
cp --backup list_conf_d test/.sub/list_conf_d

# 19
find ~/test -not -path "/test"

# 20
man man > man.txt

# 21
split -b 1024 man.txt man.txt_

# 22
mkdir test/man.dir

# 23
mv man.txt_* test/man.dir/

# 24
cat test/man.dir/man.txt_* > test/man.dir/man.txt

# 25
cmp -s man.txt test/man.dir/man.txt && echo "YES"

# 26
{
	for i in {1..3}
	do
		head /dev/urandom | tr -dc a-z0-9 | head -c 32; echo ""
	done
	cat man.txt
	for i in {1..3}
	do
		head /dev/urandom | tr -dc a-z0-9 | head -c 32; echo ""
	done
} > temp.txt
cat temp.txt > man.txt
rm temp.txt

# 27
diff -u test/man.dir/man.txt man.txt> man_diff.txt

# 28
mv man_diff.txt test/man.dir/

# 29
cd test/man.dir && patch -s man.txt man_diff.txt

# 30
cd ~  && cmp -s man.txt test/man.dir/man.txt && echo "YES"
