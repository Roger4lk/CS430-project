module AbstractSyntaxTree
  class IntegerPrim
    attr_reader :left, :right
    
    def initialize(left, right) 
      @left = left
      @right = right
    end

    def traverse(visitor)
      visitor.visitSetPrimitive(self)
    end
  end

  class doublePrim
    //repeat
  end

end