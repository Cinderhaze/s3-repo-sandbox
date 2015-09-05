# setup s3-yum-plugin
#repo - https://github.com/jbraeuer/yum-s3-plugin

$iam = true

case $iam {
  true: {
    $repo_path = '/git/yum-s3-iam'
    $repo = 'https://github.com/seporaitis/yum-s3-iam/' 
  }
  default: {
    $repo_path = '/git/yum-s3-plugin'
    $repo = 'https://github.com/jbraeuer/yum-s3-plugin'
  }
} 

file { '/git':
  ensure => directory,
} 
vcsrepo{ $repo_path:
  ensure => 'present',
  provider => 'git',
  source => $repo,
  revision => 'master',
  require => File['/git'],
} 
#sing us a lullabye at night... lullabye at night - that's what the kids in the cigna comercial say

if $iam {
  #place py file
  file { '/usr/lib/yum-plugins/s3iam.py':
    ensure => present,
    source => "${repo_path}/s3iam.py",
    require => Vcsrepo[$repo_path],
  }
  file { '/usr/lib/yum-plugins/s3.py':
    ensure => absent,
  }
  #place config
  file { '/etc/yum/pluginconf.d/s3iam.conf':
    ensure => present,
    source => "${repo_path}/s3iam.conf",
    require => Vcsrepo[$repo_path],
  }
  file { '/etc/yum/pluginconf.d/s3.conf':
    ensure => absent,
  }
  
  #create yumrepo
} else {
  #place py file
  file { '/usr/lib/yum-plugins/s3iam.py':
    ensure => absent,
  }
  #place config
  file { '/etc/yum/pluginconf.d/s3iam.conf':
    ensure => absent,
  }
  #create yumrepo
}
