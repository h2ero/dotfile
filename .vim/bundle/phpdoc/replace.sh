#!/bin/sh
### BEGIN INFO
# 
# author h2ero <122750707@qq.com> 
# create date 2013-07-09 23:11:27
# last update date 2013-07-09 23:11:40
# 
### END INFO
 
for file in $(find *txt); do
bakfile=$file.bak
mv $file $bakfile
sed -e '1s/\(\w\+\)/*\1*/' $bakfile > $file
rm $bakfile
echo "$file replace success \n"
done
