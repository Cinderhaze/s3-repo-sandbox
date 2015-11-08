# setup s3-yum-plugin
#repo - https://github.com/jbraeuer/yum-s3-plugin

#$iam = false
$iam = true

case $iam {
  true: {
    $repo_path = '/git/yum-s3-iam'
    $repo = 'https://github.com/seporaitis/yum-s3-iam/' 
    $revision = 'v4_signature'
  }
  default: {
    $repo_path = '/git/yum-s3-plugin'
    $repo = 'https://github.com/jbraeuer/yum-s3-plugin'
    $revision = 'master'
  }
} 

file { '/git':
  ensure => directory,
} 
vcsrepo{ $repo_path:
  ensure => 'present',
  provider => 'git',
  source => $repo,
  revision => $revision,
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
  yumrepo { 's3-iam':
    #baseurl        => 'https://dawiest-repo.s3.amazonaws.com/noarch',
    baseurl        => 'https://dawiest-repo.s3-eu-central-1.amazonaws.com/noarch',
    ensure         => 'present',
    descr          => 'S3 iam - Testing - $basearch - Source',
    enabled        => '1',
    gpgcheck       => '0',
    s3_enabled     => true,
  }
  yumrepo { 's3-plugin':
    ensure => 'absent',
  }
} else {
  #place py file
  file { '/usr/lib/yum-plugins/s3iam.py':
    ensure => absent,
  }
  file { '/usr/lib/yum-plugins/s3.py':
    ensure => present,
    source => "${repo_path}/s3.py",
    require => Vcsrepo[$repo_path],
  }
  #place config
  file { '/etc/yum/pluginconf.d/s3iam.conf':
    ensure => absent,
  }
  file { '/etc/yum/pluginconf.d/s3.conf':
    ensure => present,
    source => "${repo_path}/s3.conf",
    require => Vcsrepo[$repo_path],
  }
  #create yumrepo
  yumrepo { 's3-plugin':
    baseurl        => 'http://dawiest-repo.s3.amazonaws.com/noarch',
    ensure         => 'present',
    descr          => 'S3 plugin - Testing - $basearch - Source',
    enabled        => '1',
    gpgcheck       => '0',
    s3_enabled     => true,
  }
  yumrepo { 's3-iam':
    ensure => 'absent',
  }
}
