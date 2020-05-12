#!/bin/bash
yum -y install epel-release
yum install sshpass -y
alias app01="sshpass -p 'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@172.16.238.10 "
alias app02="sshpass -p 'Am3ric@' ssh -o StrictHostKeyChecking=no steve@172.16.238.11"
alias app03="sshpass -p 'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12"
alias lb01="sshpass -p 'Mischi3f' ssh -o StrictHostKeyChecking=no loki@172.16.238.14"
alias db01="sshpass -p 'Sp!dy' ssh -o StrictHostKeyChecking=no peter@172.16.239.10"
alias stor01="sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no natasha@172.16.238.15"
alias bkp01="sshpass -p 'H@wk3y3' ssh -o StrictHostKeyChecking=no clint@172.16.238.16"
alias mail01="sshpass -p 'Gr00T123' ssh -o StrictHostKeyChecking=no groot@172.16.238.17"
#jump_host thor mjolnir123
