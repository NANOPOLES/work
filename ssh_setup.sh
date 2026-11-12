if [ `whoami` != "oracle" ]
then
echo "You must execute this as oracle!!!";exit
fi

LOCAL=`hostname`
REMOTE=`sed -n 2p $HOME/nodeinfo`


ssh $REMOTE rm -rf /home/oracle/.ssh

rm -rf /home/oracle/.ssh

ssh-keygen -t rsa  -f $HOME/.ssh/id_rsa -N '' -q

touch $HOME/.ssh/authorized_keys
chmod 600  $HOME/.ssh/authorized_keys
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
chmod 400  $HOME/.ssh/authorized_keys

ssh -o StrictHostKeyChecking=no -q $LOCAL /bin/true
scp -o StrictHostKeyChecking=no -q -r $HOME/.ssh $REMOTE:

# and now add the host keys for the FQDN  hostnames
ssh -o StrictHostKeyChecking=no -q ${LOCAL} /bin/true
ssh -o StrictHostKeyChecking=no -q ${REMOTE} /bin/true

ssh -o StrictHostKeyChecking=no -q ${LOCAL} /bin/true
ssh -o StrictHostKeyChecking=no -q ${REMOTE} /bin/true

scp -q $HOME/.ssh/known_hosts $REMOTE:$HOME/.ssh/known_hosts
echo "Configuration sucessfully...."
exit;