module AbstractSyntaxTree
  class IntPrim
    attr_reader :value
    
    def initialize(value) 
      @value = value
    end

    def traverse(visitor)
      visitor.visit(self)
    end
  end

  class FloatPrim
    attr_reader :value
    
    def initialize(value) 
      @value = value
    end

    def traverse(visitor)
      visitor.visit(self)
    end
  end

  class BoolPrim
    attr_reader :value
    
    def initialize(value) 
      @value = value
    end

    def traverse(visitor)
      visitor.visit(self)
    end
  end

  class StringPrim
    attr_reader :value
    
    def initialize(value) 
      @value = value
    end

    def traverse(visitor)
      visitor.visit(self)
    end
  end

  class CellAddr
    attr_reader :addr, :right
    
    def initialize(addr) 
      @addr = addr
    end

    def traverse(visitor)
      visitor.visit(self)
    end
  end

  class addition
    def initialize(addand1, addand2)
      @addand1 = addand1
      @addand2 = addand2
    end

    def traverse(visitor) {
      visitor.visit(self);
    }


  end

  class subtraction
    
  end
  
  class multiplication
    
  end
  
  class division
    
  end 
  
  class modulo
    
  end
  
  class exponentiation
    
  end
  
  class negation

  end
end