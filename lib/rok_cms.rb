require "rok_cms/engine"

# Require all dependencies, watch out as this could break when you add a new gem
Gem.loaded_specs['rok_cms'].dependencies.each do |d|
  require d.name
end

module RokCms
end
