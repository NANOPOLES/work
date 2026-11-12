. /home/oracle/.bash_profile

echo "Delete in progress" > /var/log/lastdelete

sqlplus " / as sysdba " @/home/oracle/rm_archive.sql > /tmp/con.log 2> /tmp/con.err

chmod 775 /tmp/arch_remove.sh

/tmp/arch_remove.sh > /tmp/arch_remove.log 2> /tmp/arch_remove.err

echo "Delete Complete" >> /var/log/lastdelete

date >> /var/log/lastdelete
