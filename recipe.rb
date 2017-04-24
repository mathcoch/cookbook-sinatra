class Recipe
  attr_reader :name, :description, :cooking_time, :difficulty, :is_done
  def initialize(name, description, cooking_time, difficulty, is_done)
    @name = name
    @description = description
    @cooking_time = cooking_time
    @difficulty = difficulty
    @is_done = is_done
  end

  def is_done?
    @is_done == 'true'
  end

  def change_status
    @is_done = 'true'
  end

  def status
    is_done? ? "<span class=\"glyphicon glyphicon-check\" aria-hidden=\"true\"></span>" : "<span class=\"glyphicon glyphicon-unchecked\" aria-hidden=\"true\"></span>"
  end
end
