archiva-liatrio Cookbook
========================
A wrapper cookbook that installs and configures archiva. Berkshelf is used to satisfy cookbook dependencies with Vagrant.

Requirements
------------
Ensure the ChefDK is installed from https://downloads.chef.io/chef-dk/

Ensure the vagrant-berkshelf plugin is installed: `vagrant plugin install vagrant-berkshelf`

Usage
-----
#### archiva-liatrio::default
`vagrant up`

Browse to http://localhost:18081/

or

Just include `archiva-liatrio` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[archiva-liatrio]"
  ]
}
```

License and Authors
-------------------
Authors: drew@liatrio.com
