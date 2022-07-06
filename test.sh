awk '{gsub(/map+\_+[a-z+0-9]+\.+yaml/, "'$1'")}1' test.txt > test2.txt
