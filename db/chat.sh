#!/bin/bash
cat desertbus.log | \
grep -P  "... ... \d\d 2015 \d\d:\d\d:\d\d((<@?.+> .*)|( \* .*))" | \
sed -rn 's/^(... ... [0-9]{2} 2015 [0-9]{2}:[0-9]{2}:[0-9]{2})((<(@| )?([^ <>]+)>)|( (\*) ([^ ]+))) (.*)$/INSERT INTO chat ("time", "user", action, content) VALUES ('"'\1'"', coalesce((SELECT id FROM "user" WHERE username = '"'\5\8'"'), 0), '"'\7'"' = '"'*'"', $chatMessage$\9$chatMessage$);/p' > chat.sql