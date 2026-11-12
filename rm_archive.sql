shutdown normal;

startup nomount;

alter database mount standby database;

set pagesize 200

set heading off

set feedback off

spool /tmp/arch_remove.sh

select 'rm -f /u03/orabkp/archive/ORCL/1_'|| lh.sequence# ||'_727650116.dbf'
  from v$log_history  lh
 where lh.sequence# is not null
   and trunc(lh.first_time) < ( trunc( sysdate) - 1 );

spool off

shutdown immediate;

exit;

