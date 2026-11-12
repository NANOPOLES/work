echo -n "Importing new archives... " > /var/log/lastrun
rsync -avz 192.168.100.80:/u03/orabkp/archive/ORCL/ /u03/orabkp/archive/ORCL/


echo -n "Applying Archives... " >> /var/log/lastrun

. /home/oracle/.bash_profile

sqlplus /nolog << EOF

connect / as sysdba

spool /var/log/lastarchived.lst;

shutdown normal;

set autorecovery on;

startup nomount;

select to_char(sysdate,'mm/dd/yyyy hh24:mi:ss') fecha from dual;

alter database mount standby database;

recover automatic standby database;

select 'Ultimo archive aplicado/transportado => 1_'|| max(sequence#) ||'_727650116.dbf' archive from v\$log_history;

shutdown immediate;

spool off;

exit

EOF

echo -n "Done... " >> /var/log/lastrun

date >> /var/log/lastrun
