archiva-liatrio Cookbook
========================
A wrapper cookbook that installs and configures archiva with three created users that can push artifacts and be used as a local mirror.

Requirements
------------
Ensure the ChefDK is installed from https://downloads.chef.io/chef-dk/

Ensure the vagrant-berkshelf plugin is installed: `vagrant plugin install vagrant-berkshelf`

Usage
-----
#### archiva-liatrio::default
`vagrant up`

Browse to http://localhost:18081/

The following users are created:
- admin :: admin1
- deploy :: deploy1
- snapshots :: snapshots1

Repositories:
- snapshots (user snapshots with r/w access)
- internal (user deploy with r/w access)

License and Authors
-------------------
Authors: drew@liatrio.com
