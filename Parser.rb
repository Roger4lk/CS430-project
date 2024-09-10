class Parser
  def initialize() {

  }
  
  def advance
    @i += 1
  end

  def parse 
    levelN
  end

  def level1
    left = levelN
    while has(:percent)
      advance
      right = levelN
      left = Ast::Intersect(left, right)
    end
    return left
  end

  def levelN
    if has(:left_curly)
      advance
      ids = []
      while has(:identifier)
        ids
      end
      if !has(:right_curly)
        throw syntax error
      end
    end
  end
end