# encoding: UTF-8

require_relative 'recipe'
require_relative 'cookbook'
require_relative 'view'
require_relative 'controller'

require "open-uri"
require "nokogiri"
require 'pry-byebug'



cookbook = Cookbook.new("recipes.csv")
controller = Controller.new(cookbook)

def search(key_word)
  # return list of recipe for keyword
  # url = "http://www.marmiton.org/recettes/recherche.aspx?aqt=#{key_word}"
  url = "#{key_word}.html"
  doc = Nokogiri::HTML(open(url).read)

  results_card = doc.xpath("//div[@class='m_item recette_classique']/div[@class='m_contenu_resultat']")

  array_of_recipies = results_card.each_with_object([]) do |result, array|
    name = result.xpath("div[@class='m_titre_resultat']/a").text.strip
    description = result.xpath("div[@class='m_texte_resultat']").text.strip
    cooking_time_path = result.xpath("div[@class='m_detail_time']/div/div[@class='m_cooking_time']")
    cooking_time = cooking_time_path[0].respond_to?(:parent) ? cooking_time_path[0].parent.text : "n.a."
    difficulty = result.xpath("div[@class='m_note_resultat']/div[@class='m_recette_note1']").count

    recipe = Recipe.new(name, description, cooking_time, difficulty, 'false')
    array << recipe
  end
end


p search('fraise')
