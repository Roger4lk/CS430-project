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
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f + right.value.to_f)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_SUB
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value - right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f - right.value.to_f)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_MULT
      left = self.visit(node.left)
      right = self.visit(node.right)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value * right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f * right.value.to_f)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_NEG
      if "#{node.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(-node.value)
      elsif "#{node.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(-node.value)
      else
        evalNode = self.visit(node.value)
        if "#{evalNode.class}" == P_INT
          return AbstractSyntaxTree::IntPrim.new(-evalNode.value)
        elsif "#{evalNode.class}" == P_FLT
          return AbstractSyntaxTree::FloatPrim.new(-evalNode.value)
        else
          raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim) \n Actual: (#{evalNode.class})"
        end
      end
    when A_DIVIDE
      left = self.visit(node.left)
      right = self.visit(node.right)
      if ("#{left.class}" == P_INT || "#{left.class}" == P_FLT) && ("#{right.class}" == P_INT || "#{right.class}" == P_FLT)
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f / right.value.to_f)
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
      if "#{value.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(!left.value)
      else
        raise IllegalArgumentError, "Expexted: (BoolPrim) \n Actual: (#{left.class})"
      end
    when LVAL
      collumn = self.visit(node.collumn)
      row = self.visit(node.row)
      if ("#{collumn.class}" == P_INT && "#{row.class}" == P_INT)
        return AbstractSyntaxTree::CellAddr.new(row, collumn)
      else
        raise IllegalArgumentError, "Expected: (IntPrim, IntPrim) \nActual: (#{collumn.class}, #{row.class})" 
      end
    when RVAL
      collumn = self.visit(node.collumn)
      row = self.visit(node.row)
      if ("#{collumn.class}" == P_INT && "#{row.class}" == P_INT)
        return payload[row][collumn]
      else
        raise IllegalArgumentError, "Expected: (IntPrim, IntPrim) \nActual: (#{collumn.class}, #{row.class})" 
      end
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
      left = self.visit(node.left)
      right = self.visit(node.right)
      if right.value == left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when R_NOT_EQ
      left = self.visit(node.left)
      right = self.visit(node.right)
      if right.value == left.value
        return BoolPrim.new(False)
      else 
        return BoolPrim.new(True)
      end
    when R_LESS
      left = self.visit(node.left)
      right = self.visit(node.right)
      if right.value < left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when R_LESS_EQ
      left = self.visit(node.left)
      right = self.visit(node.right)
      if right.value <= left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when R_GREATER
      left = self.visit(node.left)
      right = self.visit(node.right)
      if right.value > left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when R_GREATER_EQ
      left = self.visit(node.left)
      right = self.visit(node.right)
      if right.value >= left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when C_FLT_TO_INT
      value = self.visit(node).value
    when C_INT_TO_FLT
      return "(Float)#{self.visit(node.left)})"
    when S_MAX
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
