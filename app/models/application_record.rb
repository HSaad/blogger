class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  config.assets.initialize_on_precompile = false
end
