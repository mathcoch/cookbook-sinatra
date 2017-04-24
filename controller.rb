require_relative 'view'
require_relative 'service_navigator'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @navigator = ServiceNavigator.new
  end

  def list
    display
  end

  def create
    recipe = @view.ask_new_recipe
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display
    index = @view.ask_recipes_index
    @cookbook.remove_recipe(index)
  end

  def import
    # Demander mot clé
    keyword = @view.ask_keyword
    # Lancer navigator sur la recherche
    recipes = @navigator.search(keyword)
    # Afficher résultat et demander recette
    @view.display_recipes(recipes)
    index = @view.ask_recipes_index
    # Ajouter recette
    @cookbook.add_recipe(recipes[index])
  end

  def done
    # Afficher les recettes
    display
    # Demander index
    index = @view.ask_recipes_index
    # Changer status de la recette
    @cookbook.recipes[index].change_status
  end

  private

  def display
    @view.display_recipes(@cookbook.all)
  end
end
