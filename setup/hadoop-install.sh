# download
cd ~
wget http://mirrors.koehn.com/apache/hadoop/common/hadoop-3.2.0/hadoop-3.2.0.tar.gz

# unzip and move to /usr/local/bin/hadoop
sudo tar -xvzf hadoop-3.2.0.tar.gz -C /usr/local/bin/
sudo mv /usr/local/bin/hadoop-3.2.0 /usr/local/bin/hadoop/

# export path variables
echo "export JAVA_HOME=/usr" >> /home/vagrant/.bashrc
echo "export HADOOP_LOG_DIR=/hadoop_logs" >> /home/vagrant/.bashrc
echo "export PATH=\$PATH:/usr/local/bin/hadoop/bin:/usr/local/bin/hadoop/sbin" >> /home/vagrant/.bashrc
source ~/.bashrc

# set JAVA_HOME, log directory location for Hadoop
echo "export JAVA_HOME=/usr" | sudo tee --append /usr/local/bin/hadoop/etc/hadoop/hadoop-env.sh
echo "export HADOOP_LOG_DIR=/hadoop_logs" | sudo tee --append /usr/local/bin/hadoop/etc/hadoop/hadoop-env.sh
echo "export HDFS_NAMENODE_USER=\"vagrant\"" | sudo tee --append /usr/local/bin/hadoop/etc/hadoop/hadoop-env.sh
echo "export HDFS_DATANODE_USER=\"vagrant\"" | sudo tee --append /usr/local/bin/hadoop/etc/hadoop/hadoop-env.sh
echo "export HDFS_SECONDARYNAMENODE_USER=\"vagrant\"" | sudo tee --append /usr/local/bin/hadoop/etc/hadoop/hadoop-env.sh
echo "export YARN_RESOURCEMANAGER_USER=\"vagrant\"" | sudo tee --append /usr/local/bin/hadoop/etc/hadoop/hadoop-env.sh
echo "export YARN_NODEMANAGER_USER=\"vagrant\"" | sudo tee --append /usr/local/bin/hadoop/etc/hadoop/hadoop-env.sh

# fix issue with start-dfs.sh not running
# https://stackoverflow.com/questions/48978480/hadoop-permission-denied-publickey-password-keyboard-interactive-warning/49960886
ssh-keygen -t rsa -P '' -f /home/vagrant/.ssh/id_rsa
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa.pub