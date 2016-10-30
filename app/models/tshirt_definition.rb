class TshirtDefinition < ActiveRecord::Base
  def nice_name
    self.name + ' (' + self.produced + ')'
  end
end
