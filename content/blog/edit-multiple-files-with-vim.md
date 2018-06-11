title: editing multiple files with Vim
tags: comp
category: comp
date: 2018-06-11
modified: 2018-06-11
status: draft

g/pattern/command
read get command content and append to file
s/pattern/new replace pattern with new
for i in $(ls content/*.md); do vim -c "g/date\:/read !grep "date\:" %" -c "s/date/modified" -c "wq" $i; done;
