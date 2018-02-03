#!/bin/sh
ls $1 | while read folder
do
        if [ -d $1/$folder ]
        then
                files=`ls $1/$folder | wc -l`
                echo $files
                if [ $files -eq 0 ]
                then
                        echo $folder >> output.txt
                fi
        fi
done
