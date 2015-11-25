#!/bin/bash
cat desertbus.dates.log | \
grep -P "... \d\d 2015 \d\d:\d\d:\d\d((<@?.+> .*)|( \* .*))" | \
sed -rn 's/^(... [0-9]{2} 2015 [0-9]{2}:[0-9]{2}:[0-9]{2})((<(@| )?([^ <>]+)>)|(( )(\*) ([^ ]+))) (.*)$/INSERT INTO "user"(op, username) VALUES ('"'\4\7'"' = '"'@'"', '"'\5\9'"') ON CONFLICT (username) DO UPDATE SET username = EXCLUDED.username;/p' | \
sort | \
uniq > users.sql
