module AbstractSyntaxTree
  class IntPrim
    attr_reader :value
    
    def initialize(value) 
      @value = value
    end

    def traverse(visitor, payload)
      visitor.visit(self)
    end
  end

  class FloatPrim
    attr_reader :value
    
    def initialize(value) 
      @value = value
    end

    def traverse(visitor, payload)
      visitor.visit(self)
    end
  end

  class BoolPrim
    attr_reader :value
    
    def initialize(value) 
      @value = value
    end

    def traverse(visitor, payload)
      visitor.visit(self)
    end
  end

  class StringPrim
    attr_reader :value
    
    def initialize(value) 
      @value = value
    end

    def traverse(visitor, payload)
      visitor.visit(self)
    end
  end

  class CellAddr
    attr_reader :collumn, :row
    
    def initialize(row, collumn) 
      @row = row
      @collumn = collumn
    end

    def traverse(visitor, payload)
      visitor.visit(self)
    end
  end

  class Add
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class Subtract
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end
  
  class Multiply
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end
  
  class Divide
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end 
  
  class Modulo
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end
  
  class Exponentiate
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end
  
  class Negate
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class AndLog
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class OrLog
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class NotLog
    attr_reader :value

    def initialize(left)
      @value = value
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class LValue 
    attr_reader :row, :collumn

    def initialize(row, collumn) 
      @row = row
      @collumn = collumn
    end

    def travers(visitor, payload)
      visitor.visit(self)
    end
  end

  class RValue 
    attr_reader :row, :collumn

    def initialize(row, collumn) 
      @row = row
      @collumn = collumn
    end

    def travers(visitor, payload)
      visitor.visit(self)
    end
  end

  class AndBitw
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class OrBitw
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class XorBitw
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class LshiftBitw
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class RshiftBitw
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class NotBitw
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class Equal
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class NotEqual
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class LessThan
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class LessEqual
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class GreaterThan
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class GreaterEqual 
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class FloatToInt
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def traverse(visitor, payload)
      visitor.visit(self)
    end
  end  

  class IntToFloat
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def traverse(visitor, payload)
      visitor.visit(self)
    end
  end  

  class Max
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class Min
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class Mean
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end

  class Sum
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def traverse(visitor, payload) 
      visitor.visit(self);
    end
  end
end