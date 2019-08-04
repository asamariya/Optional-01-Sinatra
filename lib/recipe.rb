class Recipe
  attr_reader :name, :description, :path, :prep_time, :difficulty
  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @path = attributes[:path]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] == "true"
    @difficulty = attributes[:difficulty]
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end