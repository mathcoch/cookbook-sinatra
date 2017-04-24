require_relative 'recipe'
require 'table_print'

class View
  def display_recipes(recipes)
    tp recipes.each_with_index.map { |r, index| {index: index + 1,
                                                 status: r.status,
                                                 name: r.name,
                                                 description: r.description,
                                                 time: r.cooking_time,
                                                 difficulty: r.difficulty} }
  end

  def ask_new_recipe
    name = ask('name')
    description = ask('description')
    cooking_time = ask('cooking_time')
    difficulty = ask('difficulty')
    is_done = "false"
    return Recipe.new(name, description, cooking_time, difficulty, is_done)
  end

  def ask_recipes_index
    return ask('index').to_i - 1
  end

  def ask_keyword
    return ask('keyword')
  end

  private

  def ask(topic)
    puts ""
    puts "What is the #{topic}?"
    print "> "
    name = gets.chomp
  end
end
