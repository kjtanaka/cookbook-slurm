name             'slurm'
maintainer       'FutureGrid'
maintainer_email 'kj.tanaka@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures slurm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'build-essential'
depends 'selinux'
depends 'munge'
