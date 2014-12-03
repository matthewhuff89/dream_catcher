def symbol_splitter(string)
    @symbol_array = string.split(",").map do |symbol|
    symbol.strip
    end
    @symbol_array
  end

  def symbol_creator(array)
    symbols = []
    array.each {|symbol| symbols << Symbol.find_or_create_by(name: symbol) }
    symbols
  end