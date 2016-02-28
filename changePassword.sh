#!/usr/bin/expect -f

spawn asadmin change-admin-password --user admin
expect "Enter admin password>"
send "\r"
expect "Enter new admin password>"
send "adminadmin\r"
expect "Enter new admin password again>"
send "adminadmin\r"
expect "Command change-admin-password executed successfully."
send "\r"
