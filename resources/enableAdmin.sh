#!/usr/bin/expect -f

spawn asadmin enable-secure-admin --user admin
expect "Enter admin password for user \"admin\">"
send "adminadmin\r"
expect "You must restart all running servers for the change in secure admin to take effect.\n
Command enable-secure-admin executed successfully."
