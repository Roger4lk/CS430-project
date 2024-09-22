require_relative 'AbstractSyntaxTree'
require_relative 'Visitor'
require_relative '../Runtime'

class Evaluator include Visitor
  def visit(node, payload)
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
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value + right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f + right.value.to_f)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_SUB
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value - right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f - right.value.to_f)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_MULT
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
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
        evalNode = self.visit(node.value, payload)
        if "#{evalNode.class}" == P_INT
          return AbstractSyntaxTree::IntPrim.new(-evalNode.value)
        elsif "#{evalNode.class}" == P_FLT
          return AbstractSyntaxTree::FloatPrim.new(-evalNode.value)
        else
          raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim) \n Actual: (#{evalNode.class})"
        end
      end
    when A_DIVIDE
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if ("#{left.class}" == P_INT || "#{left.class}" == P_FLT) && ("#{right.class}" == P_INT || "#{right.class}" == P_FLT)
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f / right.value.to_f)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_MOD
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{right.class}" == P_INT && "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value % right.value)
      end
      if ("#{left.class}" == P_INT || "#{left.class}" == P_FLT) && ("#{right.class}" == P_INT || "#{right.class}" == P_FLT)
        return AbstractSyntaxTree::FloatPrim.new(left.value % right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_AND
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(left.value && right.value)
      else
        raise IllegalArgumentError, "Expexted: (BoolPrim, BoolPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_OR
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(left.value || right.value)
      else
        raise IllegalArgumentError, "Expexted: (BoolPrim, BoolPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_NOT
      value = self.visit(node.value, payload)
      if "#{value.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(!left.value)
      else
        raise IllegalArgumentError, "Expexted: (BoolPrim) \n Actual: (#{left.class})"
      end
    when LVAL
      collumn = self.visit(node.collumn, payload)
      row = self.visit(node.row, payload)
      if ("#{collumn.class}" == P_INT && "#{row.class}" == P_INT)
        return AbstractSyntaxTree::CellAddr.new(row, collumn)
      else
        raise IllegalArgumentError, "Expected: (IntPrim, IntPrim) \nActual: (#{collumn.class}, #{row.class})" 
      end
    when RVAL
      collumn = self.visit(node.collumn, payload)
      row = self.visit(node.row, payload)
      if ("#{collumn.class}" == P_INT && "#{row.class}" == P_INT)
        return payload[row][collumn]
      else
        raise IllegalArgumentError, "Expected: (IntPrim, IntPrim) \nActual: (#{collumn.class}, #{row.class})" 
      end
    when B_AND
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value & right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_OR
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value | right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_RSHIFT
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value >> right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_LSHIFT
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value << right.value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_NOT
      value = self.visit(node.left, payload)
      if "#{value.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(~value)
      else
        raise IllegalArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when R_EQ
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if right.value == left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when R_NOT_EQ
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if right.value == left.value
        return BoolPrim.new(False)
      else 
        return BoolPrim.new(True)
      end
    when R_LESS
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if right.value < left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when R_LESS_EQ
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if right.value <= left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when R_GREATER
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if right.value > left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when R_GREATER_EQ
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if right.value >= left.value
        return BoolPrim.new(True)
      else 
        return BoolPrim.new(False)
      end
    when C_FLT_TO_INT
      value = self.visit(node, payload).value
    when C_INT_TO_FLT
    when S_MAX
      addrOne = node.left.traverse(self, payload)
      addrTwo = node.right.traverse(self, payload)
      if "#{addrOne.class}" != P_CELL_ADDR || "#{addrTwo.class}" != P_CELL_ADDR
        raise IllegalArgumentError, "Expected: (CellAddr, CellAddr) \nActual: (#{addrOne.class}, #{addrTwo.class})"
      end
      max = payload.lookUpCellBlock(addrOne, addrTwo) do |max, curr, numElements|
        max.nil? || curr > max ? curr : max
      end
      return AbstractSyntaxTree::FloatPrim.new(max)
    when S_MIN
      addrOne = node.left.traverse(self, payload)
      addrTwo = node.right.traverse(self, payload)
      if "#{addrOne.class}" != P_CELL_ADDR || "#{addrTwo.class}" != P_CELL_ADDR
        raise IllegalArgumentError, "Expected: (CellAddr, CellAddr) \nActual: (#{addrOne.class}, #{addrTwo.class})"
      end
      min = payload.lookUpCellBlock(addrOne, addrTwo) do |min, curr|
        min.nil? || curr < min ? curr : min
      end
      return AbstractSyntaxTree::FloatPrim.new(min)
    when S_MEAN
      addrOne = node.left.traverse(self, payload)
      addrTwo = node.right.traverse(self, payload)
      if "#{addrOne.class}" != P_CELL_ADDR || "#{addrTwo.class}" != P_CELL_ADDR
        raise IllegalArgumentError, "Expected: (CellAddr, CellAddr) \nActual: (#{addrOne.class}, #{addrTwo.class})"
      end
      sum = payload.lookUpCellBlock(addrOne, addrTwo) do |sum, curr|
        if !sum.nil? && !curr.nil?
          sum += curr
        elsif sum.nil?
          sum = 0.0
        end
      end
      numElements = payload.lookUpCellBlock(addrOne, addrTwo) do |num, curr|
        num.nil? ? 1 : num
        !num.nil? ? num + 1 : num
      end
      return AbstractSyntaxTree::FloatPrim.new(sum/ numElements)
    when S_SUM
      addrOne = node.left.traverse(self, payload)
      addrTwo = node.right.traverse(self, payload)
      if "#{addrOne.class}" != P_CELL_ADDR || "#{addrTwo.class}" != P_CELL_ADDR
        raise IllegalArgumentError, "Expected: (CellAddr, CellAddr) \nActual: (#{addrOne.class}, #{addrTwo.class})"
      end
      sum = payload.lookUpCellBlock(addrOne, addrTwo) do |sum, curr, numElements|
        if !sum.nil? && !curr.nil?
          sum += curr
        elsif sum.nil?
          sum = 0.0
        end
      end
      return AbstractSyntaxTree::FloatPrim.new(sum)
    else
      
    end
  end

  
end
