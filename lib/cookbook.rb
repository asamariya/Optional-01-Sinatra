require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []

    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def find(index)
    @recipes[index]
  end

  private

  def update_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[name prep_time difficulty description]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.prep_time, recipe.difficulty, recipe.description]
      end
    end
  end

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, options) do |row|
      @recipes << Recipe.new(row)

      # CSV.foreach(@csv_file_path, options) do |name, prep_time, difficulty, description|
      # @recipes << Recipe.new(name: name, prep_time: prep_time, difficult: difficulty, description: description)
    end
  end
end
