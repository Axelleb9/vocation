class WordsController < ApplicationController

  def index
    policy_scope(Word)
    @words = current_user.lists.first.words
    base = "https://twinword-word-graph-dictionary.p.rapidapi.com/"
    infos = ["example/?", "difficulty/?", "definition/?", "reference/?"]
    infos.each do |info|
    end
  end

end
