require "open-uri"
require "nokogiri"
require_relative "recipe"

class ServiceNavigator
  def search(keyword)
    url = "http://www.marmiton.org/recettes/recherche.aspx?aqt=#{keyword}"
    doc = Nokogiri::HTML(open(url).read)

    results_card = doc.xpath("//div[@class='m_item recette_classique']/div[@class='m_contenu_resultat']")

    array_of_recipes = results_card.each_with_object([]) do |result, array|

      name = result.xpath("div[@class='m_titre_resultat']/a").text.strip

      description = result.xpath("div[@class='m_texte_resultat']").text.strip

      cooking_time_path = result.xpath("div[@class='m_detail_time']/div/div[@class='m_cooking_time']")
      cooking_time = cooking_time_path[0].respond_to?(:parent) ? cooking_time_path[0].parent.text : "n.a."

      difficulty = result.xpath("div[@class='m_note_resultat']/div[@class='m_recette_note1']").count

      recipe = Recipe.new(name, description, cooking_time, difficulty, 'false')
      array << recipe
    end
  end
end
