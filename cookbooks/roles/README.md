# Role Cookbooks

"Roles" in Chef provide duplicate functionality to "Cookbooks". Instead of using both, this repo uses "Role Cookbooks". The role cookbooks should include other cookbooks and set attributes, but should not do configuration themselves.

Each node should have *only one* role assigned to it. 

Role cookbooks are used as a major unit of testing, where Test Kitchen can be used to fully test a role.

Cookbooks in this directory should be prefixed with `role_`.

More info on role cookbooks:

- https://blog.chef.io/2013/11/19/chef-roles-arent-evil/
- http://dougireton.com/blog/2013/02/16/chef-cookbook-anti-patterns/
- http://bytearrays.com/chef-cookbook-patterns/