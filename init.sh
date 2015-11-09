#!/bin/bash

#TODO have this create a bucket, pull down some rpm's, pull down rpmrepo to build
# the repository, have it upload to the bucket (based on the instance-id or something)
# and then query the bucket
cd ~/
sudo yum install -y git puppet3
sudo puppet module install puppetlabs-vcsrepo
sudo puppet resource yumrepo > initialrepos.pp
sudo mv /etc/yum.repos.d/* /tmp/
git clone https://github.com/Cinderhaze/s3-repo-sandbox
sudo puppet apply ~/s3-repo-sandbox/s3_plugin.pp
yum search epel
#restore the repos with this command, possibly remove the custom repo first
#sudo mv /tmp/*.repo /etc/yum.repos.d/
