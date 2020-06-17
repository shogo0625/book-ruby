class WordSynth
  def initialize
    @effects = []
  end

  def add_effect(effect)
    @effects << effect
  end

  def play(original_words)
    # effect が行われた後のwordに別のeffectを繰り返すためinjectメソッド
    @effects.inject(original_words) do |words, effect|
      effect.call(words)
    end
  end
end