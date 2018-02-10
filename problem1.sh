#!/bin/sh
sum=0
max=10
for i in $@
do
        if [ $i -gt 10 ];then
                sum=`expr $i + $sum`
        fi
done

printf "Sum = %s\n" $sum
echo "new line   "
