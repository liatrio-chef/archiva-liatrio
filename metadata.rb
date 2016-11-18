name             'archiva-liatrio'
maintainer       'Liatrio'
maintainer_email 'drew@liatrio.com'
license          'All rights reserved'
description      'Wrapper cookbook that Installs/Configures archiva-liatrio'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.3'

source_url 'https://github.com/liatrio-chef/archiva-liatrio'
issues_url 'https://github.com/liatrio-chef/archiva-liatrio/issues'

depends 'java'
depends 'archiva', '~> 1.1.0'
