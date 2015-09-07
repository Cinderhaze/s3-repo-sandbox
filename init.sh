sudo yum install -y git puppet3
sudo puppet module install puppetlabs-vcsrepo
sudo puppet resource yumrepo > initialrepos.p
sudo mv /etc/yum.repos.d/* /tmp/
