# Personal Generator Cookbook

A special type of Chef cookbook that is designed to generate code (cookbooks, recipes, templates, etc.).

This cookbook is based on [chefdk-julia](https://github.com/Nordstrom/chefdk-julia) which is based on [code_generator](https://github.com/chef/chef-dk/tree/master/lib/chef-dk/skeletons/code_generator).

## How is it better than the basic ChefDK generator?

Generated Cookbooks will contain:

1. Rakefile with RuboCop, Foodcritic, and ChefSpec tasks.
2. RSpec spec_helper.rb file set up to disallow global monkey-patching and allow focusing single tests.
3. .rspec file which auto-requires spec_helper.rb in specs
4. .rubocop.yml file with line length set to 100.
5. [InSpec](https://docs.chef.io/compliance.html#audit-resources) set up for integration testing instead of ServerSpec
6. Flexible Vagrantfile for interactive testing.


## Prerequisites
[ChefDK](https://downloads.chef.io/chef-dk/) version 0.10 or greater must already be installed.

## Installation

### Configure Your `config.rb`:
Add these lines to your `chef-repo/.chef/config.rb`:

```ruby
# Configure a custom generator
if defined?(ChefDK::CLI)
  chefdk.generator_cookbook File.join(chef_repo, 'cookbooks', 'ac', 'ac_generator')
  # Set defaults, command line can override
  chefdk.generator.copyright_holder 'Your Name'
  chefdk.generator.email 'you@example.com'
end
```

## Generating a cookbook
Once ac_generator is installed, you should be able to generate a cookbook with the `chef generate cookbook` command:

```bash
chef generate cookbook cookbooks/ac/ac_example --license mit
```

where '*the_art_of_french_cooking*' is the name of the cookbook you want to create.

## License

ac_generator: A custom cookbook generator based on chefdk-julia and ChefDK's built-in generator.

The MIT License (MIT)

Copyright (c) 2016 Anton Cohen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
