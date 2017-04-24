require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes
  def initialize(csv_file_path)
    @path = csv_file_path
    @recipes = []
    CSV.foreach(@path) { |row| @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4]) }
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id)
    update_csv
  end

  def all
    @recipes
  end

  private

  def update_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@path, 'wb', csv_options) do |csv|
      @recipes.each { |r| csv << [r.name, r.description, r.cooking_time, r.difficulty, r.is_done] }
    end
  end
end
