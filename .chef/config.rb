# See https://docs.chef.io/config_rb.html for more options

current_dir = File.dirname(__FILE__)
chef_repo = File.expand_path(File.join(current_dir, '..'))

log_level :info
log_location STDOUT

chef_repo_path chef_repo
cookbook_path Dir.glob(File.join(chef_repo_path, 'cookbooks', '*')).select { |f| File.directory? f }

data_bag_encrypt_version 2

cookbook_copyright 'Anton Cohen'
cookbook_license 'mit'
cookbook_email 'anton+chef@antoncohen.com'

# Configure a custom generator
if defined?(ChefDK::CLI)
  chefdk.generator_cookbook File.join(chef_repo, 'cookbooks', 'ac', 'ac_generator')
  # Set defaults, command line can override
  chefdk.generator.copyright_holder 'Anton Cohen'
  chefdk.generator.email 'anton+chef@antoncohen.com'
end
