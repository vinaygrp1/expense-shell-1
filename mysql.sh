#!/bin/bash

source ./common.sh

check_root 

echo "Please enter DB password:"
read  mysql_root_password

dnf install mysql-server -y &>>$LOGFILE

systemctl enable mysqld &>>$LOGFILE

systemctl start mysqld &>>$LOGFILE


# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "Setting up root password"

#Below code will be useful for idempotent nature
mysql -h database.vinaydevops.online -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
   
else #if [$? eq 0]
    echo -e "MySQL Root Password is already setup...$Y SKKIPING $N"
fi