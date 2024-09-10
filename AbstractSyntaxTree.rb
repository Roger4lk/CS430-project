module AbstractSyntaxTree
  class IntegerPrim
    attr_reader :left, :right
    
    def initialize(left, right) 
      @left = left
      @right = right
    end

    def serialize
      //output as string
    end

    def evaluate 
      //evalutae and return intersecct of two sets or issue a type error
    end
  end

  class doublePrim
    //repeat
  end

end