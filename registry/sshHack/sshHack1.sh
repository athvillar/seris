#!/usr/bin/expect -f
set timeout 5
spawn ssh [lrange $argv 2 2]@[lrange $argv 0 0] -p[lrange $argv 1 1]
expect "*password:"
send "[lrange $argv 3 3]\r"
expect {
  "*password:" { exit 1 }
  "*denied*" { exit 1 }
  "*Connection closed*" { exit 1 }
  "successful" { exit 0 }
}
