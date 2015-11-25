#!/bin/bash
csplit -q ../desertbus.log "/^---/" "{*}";

for file in $(ls x*); do
    LOG_DATE=$(grep -Po "Nov \d\d (\d\d:\d\d:\d\d )?2015" $file | sed 's/11:00:17 //');
    sed "s/^/$LOG_DATE /" $file > "d$file";
done;

cat dx* > ../desertbus.dates.log;
