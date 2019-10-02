#!/bin/bash
json_convert()
{
    str=$1
    echo "{"
    echo "\"cookbook_list\" : {"
    IFS=',' read -ra arr <<< "$str"
    size=${#arr[@]}
    i=0
    for v in "${arr[@]}"
    do
        i=$((i+1))
        name=`echo $v | awk -F@ '{ print $1 }' | awk '{$1=$1};1'`
        version=`echo $v | awk -F@ '{ print $2 }' | awk '{$1=$1};1'`
        if [ $i -eq $size ]; then
            echo "\"$name\" : \"$version\""
        else
            echo "\"$name\" : \"$version\","
        fi
    done
    echo "}"
    echo "}"
}


check_permission=`sudo touch -c /var/log/chef/client.log 2>&1 | grep "Permission denied"`
if !($check_permission)
then
    echo "No permission"
else
    echo "Have permission"
    output=`sudo cat /var/log/chef/client.log | grep -i "Loading cookbooks"`
    cookbook_list=`echo $output | cut -d "[" -f2 | cut -d "]" -f1`
    final_output=`json_convert "$cookbook_list"`
    echo $final_output | jq
fi

