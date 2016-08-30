# Cookbook Name: ac_generator
# Recipe: cookbook
# License: MIT

require 'securerandom'

context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)

# cookbook root dir
directory cookbook_dir

# LICENSE
template "#{cookbook_dir}/LICENSE" do
  source "LICENSE.#{context.license}.erb"
  backup false
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# metadata.rb
template "#{cookbook_dir}/metadata.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# readme.md
template "#{cookbook_dir}/README.md" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# chefignore
cookbook_file "#{cookbook_dir}/chefignore"

if context.use_berkshelf
  cookbook_file "#{cookbook_dir}/Berksfile" do
    action :create_if_missing
  end
else
  template "#{cookbook_dir}/Policyfile.rb" do
    source 'Policyfile.rb.erb'
    helpers(ChefDK::Generator::TemplateHelper)
  end
end

# Test-kitchen and InSpec
template "#{cookbook_dir}/.kitchen.yml" do
  if context.use_berkshelf
    source 'kitchen.yml.erb'
  else
    source 'kitchen_policyfile.yml.erb'
  end
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

directory "#{cookbook_dir}/test/integration/default" do
  recursive true
end

template "#{cookbook_dir}/test/integration/default/default_spec.rb" do
  source 'inspec_default_spec.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# ChefSpec
cookbook_file File.join(cookbook_dir, '.rspec') do
  source '.rspec'
  action :create_if_missing
end

directory "#{cookbook_dir}/spec/unit/recipes" do
  recursive true
end

template File.join(cookbook_dir, 'spec', 'spec_helper.rb') do
  source 'spec_spec_helper.rb.erb'
  backup false
  variables(
    use_berkshelf: context.use_berkshelf
  )
  action :create_if_missing
end

template "#{cookbook_dir}/spec/unit/recipes/default_spec.rb" do
  source 'recipe_spec.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Rakefile
cookbook_file File.join(cookbook_dir, 'Rakefile') do
  source 'Rakefile'
  backup false
  action :create_if_missing
end

cookbook_file File.join(cookbook_dir, '.rubocop.yml') do
  source '.rubocop.yml'
  backup false
  action :create_if_missing
end

# Vagrant
directory "#{cookbook_dir}/test/vagrant/nodes" do
  recursive true
end

cookbook_file "#{cookbook_dir}/Vagrantfile" do
  source 'Vagrantfile'
  backup false
  action :create_if_missing
end

template "#{cookbook_dir}/test/vagrant/vagrant.yml" do
  source 'vagrant.yml.erb'
  backup false
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

file "#{cookbook_dir}/test/vagrant/nodes/README.md" do
  content "This directory is required my Chef Zero.\n"
  backup false
  action :create_if_missing
end

# Recipes
directory "#{cookbook_dir}/recipes"

template "#{cookbook_dir}/recipes/default.rb" do
  source 'recipe.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# git
if context.have_git
  unless context.skip_git_init
    execute('initialize-git') do
      command('git init .')
      cwd cookbook_dir
    end
  end

  cookbook_file "#{cookbook_dir}/.gitignore" do
    source 'gitignore'
  end
end
