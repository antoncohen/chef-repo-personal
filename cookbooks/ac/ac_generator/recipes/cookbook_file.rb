# Cookbook Name: ac_generator
# Recipe: cookbook_file
# License: MIT

context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)
files_dir = File.join(cookbook_dir, 'files', 'default')
cookbook_file_path = File.join(cookbook_dir, 'files', 'default', context.new_file_basename)

directory files_dir do
  recursive true
end

source_file = context.content_source

if source_file
  file cookbook_file_path do
    content(IO.read(source_file))
  end
else
  template cookbook_file_path do
    source 'cookbook_file.erb'
    helpers(ChefDK::Generator::TemplateHelper)
  end
end
