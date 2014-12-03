def word_splitter(string)
    @word_array = string.split(",").map do |word|
    word.strip
    end
    @word_array
  end

  def word_creator(array)
    words = []
    array.each {|word| words << Word.find_or_create_by(name: word) }
    words
  end