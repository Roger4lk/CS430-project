require_relative 'AbstractSyntaxTree'
require_relative 'Visitor'

class Evaluator include Visitor
  def visit(node, payload=nil)
    case "#{node.class}"
    when P_INT
      return node
    when P_FLT
      return node
    when P_BOOL
      return node
    when P_STRING
      return node
    when P_CELL_ADDR
      return node
    when A_ADD
      
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value + right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value + right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when SUB
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value - right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value - right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_MULT
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value * right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value * right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_DIVIDE
      left = self.visit(node.left)
      right = self.visit(node.right)
      if ("#{left.class}" == P_INT || "#{left.class}" == P_FLT) && ("#{right.class}" == P_INT || "#{right.class}" == P_FLT)
        return AbstractSyntaxTree::FloatPrim.new(left.value / right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_MOD
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{right.class}" == P_INT && "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value % right.value)
      end
      if ("#{left.class}" == P_INT || "#{left.class}" == P_FLT) && ("#{right.class}" == P_INT || "#{right.class}" == P_FLT)
        return AbstractSyntaxTree::FloatPrim.new(left.value % right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_AND
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(left.value && right.value)
      else
        raise IllegalArgumentError, "Expexted: (BoolPrim, BoolPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_OR
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(left.value || right.value)
      else
        raise IllegalArgumentError, "Expexted: (BoolPrim, BoolPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_NOT
      value = self.visit(node.value)
      if "#{left.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(!left.value)
      else
        raise IllegalArgumentError, "Expexted: (BoolPrim) \n Actual: (#{left.class})"
      end
    when LVAL
      raise NotImplementedError
    when RVAL
      raise NotImplementedError
    when B_AND
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value & right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_OR
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value | right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_RSHIFT
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value >> right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_LSHIFT
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value << right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_NOT
      value = self.visit(node.left)
      if "#{value.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(~value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when R_EQ
      return "(#{self.visit(node.left)} == #{self.visit(node.right)})"
    when R_NOT_EQ
      return "(#{self.visit(node.left)} != #{self.visit(node.right)})"
    when R_LESS
      return "(#{self.visit(node.left)} < #{self.visit(node.right)})"
    when R_LESS_EQ
      return "(#{self.visit(node.left)} <= #{self.visit(node.right)})"
    when R_GREATER
      return "(#{self.visit(node.left)} > #{self.visit(node.right)})"
    when R_GREATER_EQ
      return "(#{self.visit(node.left)} >= #{self.visit(node.right)})"
    when C_FLT_TO_INT
      return "(Int) #{self.visit(node.left)})"
    when C_INT_TO_FLT
      return "(Float)#{self.visit(node.left)})"
    when S_MAX
      return "MAX(#{self.visit(node.left)}, #{self.visit(node.right)})"
    when S_MIN
      return "MIN(#{self.visit(node.left)}, #{self.visit(node.right)})"
    when S_MEAN
      return "AVERAGE(#{self.visit(node.left)}, #{self.visit(node.right)})"
    when S_SUM
      return "SUM(#{self.visit(node.left)}, #{self.visit(node.right)})"
    else
      raise "Illegal Arguments: #{node.class} is not a valid arg type"
    end
  end

  
end

puts AbstractSyntaxTree::Add.new(AbstractSyntaxTree::IntPrim.new(2), AbstractSyntaxTree::IntPrim.new(3)).traverse(Evaluator.new()).value