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
        raise ArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_SUB
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value - right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f - right.value.to_f)
      else
        raise ArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when A_MULT
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT && "#{right.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value * right.value)
      elsif "#{left.class}" == P_FLT && "#{right.class}" == P_FLT || "#{left.class}" == P_FLT && "#{right.class}" == P_INT || "#{left.class}" == P_INT && "#{right.class}" == P_FLT
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f * right.value.to_f)
      else
        raise ArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
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
          raise ArgumentError, "Expexted: (IntPrim/FloatPrim) \n Actual: (#{evalNode.class})"
        end
      end
    when A_DIVIDE
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if ("#{left.class}" == P_INT || "#{left.class}" == P_FLT) && ("#{right.class}" == P_INT || "#{right.class}" == P_FLT)
        return AbstractSyntaxTree::FloatPrim.new(left.value.to_f / right.value.to_f)
      else
        raise ArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
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
        raise ArgumentError, "Expexted: (IntPrim/FloatPrim, IntPrim/FloatPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_AND
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(left.value && right.value)
      else
        raise ArgumentError, "Expexted: (BoolPrim, BoolPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_OR
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_BOOL || "#{left.class}" == P_BOOL
        return AbstractSyntaxTree::BoolPrim.new(left.value || right.value)
      else
        raise ArgumentError, "Expexted: (BoolPrim, BoolPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when L_NOT
      if ("#{node.class}" == P_BOOL)
        return AbstractSyntaxTree::BoolPrim.new(!node.value)
      else
        value = self.visit(node.value, payload)
        if ("#{value.class}" == P_BOOL)
          return AbstractSyntaxTree::BoolPrim.new(!value.value)
        else
          raise ArgumentError, "Expected: (BoolPrim) \nActual: (#{value.class})" 
        end
      end
    when LVAL
      if ("#{node.class}" == P_CELL_ADDR)
        return AbstractSyntaxTree::CellAddr.new(node.value)
      else
        addr = self.visit(node.addr, payload)
        if ("#{addr.class}" == P_CELL_ADDR)
          return AbstractSyntaxTree::CellAddr.new(node.value)
        else
          raise ArgumentError, "Expected: (CellAddr) \nActual: (#{addr.class})" 
        end
      end
    when RVAL
      if ("#{node.class}" == P_CELL_ADDR)
        puts payload.class
        return payload.lookUpCell(node)
      else
        addr = self.visit(node.addr, payload)
        if ("#{addr.class}" == P_CELL_ADDR)
          return payload.lookUpCell(addr).evaluatedValue
        else
          raise ArgumentError, "Expected: (CellAddr) \nActual: (#{addr.class})" 
        end
      end
    when B_AND
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value & right.value)
      else
        raise ArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_OR
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value | right.value)
      else
        raise ArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_RSHIFT
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim(left.value >> right.value)
      else
        raise ArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_LSHIFT
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if "#{left.class}" == P_INT || "#{left.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(left.value << right.value)
      else
        raise ArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when B_NOT
      value = self.visit(node.left, payload)
      if "#{value.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(~value)
      else
        raise ArgumentError, "Expexted: (IntPrim, IntPrim) \n Actual: (#{left.class}, #{right.class})"
      end
    when R_EQ
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if right.value == left.value
        return AbstractSyntaxTree::BoolPrim.new(true)
      else 
        return AbstractSyntaxTree::BoolPrim.new(false)
      end
    when R_NOT_EQ
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if right.value == left.value
        return BoolPrim.new(false)
      else 
        return BoolPrim.new(true)
      end
    when R_LESS
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if left.value < right.value
        return AbstractSyntaxTree::BoolPrim.new(true)
      else 
        return AbstractSyntaxTree::BoolPrim.new(false)
      end
    when R_LESS_EQ
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if left.value <= right.value
        return BoolPrim.new(true)
      else 
        return BoolPrim.new(false)
      end
    when R_GREATER
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if ("#{left.class}" == P_FLT || "#{left.class}" == P_INT) && ("#{right.class}" == P_FLT || "#{right.class}" == P_INT)
        return AbstractSyntaxTree::BoolPrim.new(left.value > right.value)
      else 
        raise ArgumentError, "Expected: (FLoatPrim/IntPrim, FLoatPrim/IntPrim) \nActual: (#{left.class}, #{right.class})"
      end
    when R_GREATER_EQ
      left = self.visit(node.left, payload)
      right = self.visit(node.right, payload)
      if left.value >= right.value
        return BoolPrim.new(true)
      else 
        return BoolPrim.new(false)
      end
    when C_FLT_TO_INT
      if "#{node.value.class}" == P_FLT
        return AbstractSyntaxTree::IntPrim.new(node.value.value.to_i)
      else 
        evalValNode = self.visit(Evaluator.new(), payload)
        if "#{node.value.class}" == P_FLT
          return AbstractSyntaxTree::IntPrim.new(evalValNode.value.to_i)
        else
          raise ArgumentError, "Expected: (FLoatPrim) \nActual: (#{evalValNode.class})"
        end
      end
    when C_INT_TO_FLT
      if "#{node.value.class}" == P_INT
        return AbstractSyntaxTree::IntPrim.new(node.value.value.to_f)
      else 
        evalValNode = self.visit(Evaluator.new(), payload)
        if "#{node.value.class}" == P_INT
          return AbstractSyntaxTree::IntPrim.new(evalValNode.value.to_f)
        else
          raise ArgumentError, "Expected: (IntPrim) \nActual: (#{evalValNode.class})"
        end
      end
    when S_MAX
      addrOne = node.left.addr.traverse(self, payload)
      addrTwo = node.right.addr.traverse(self, payload)
      puts addrOne.row
      if "#{addrOne.class}" != P_CELL_ADDR || "#{addrTwo.class}" != P_CELL_ADDR
        raise ArgumentError, "Expected: (CellAddr, CellAddr) \nActual: (#{addrOne.class}, #{addrTwo.class})"
      end
      max = payload.lookUpCellBlock(addrOne, addrTwo) do |max, curr, numElements|
        max.nil? || curr > max ? curr : max
      end
      return AbstractSyntaxTree::FloatPrim.new(max)
    when S_MIN
      addrOne = node.left.addr.traverse(self, payload)
      addrTwo = node.right.addr.traverse(self, payload)
      if "#{addrOne.class}" != P_CELL_ADDR || "#{addrTwo.class}" != P_CELL_ADDR
        raise ArgumentError, "Expected: (CellAddr, CellAddr) \nActual: (#{addrOne.class}, #{addrTwo.class})"
      end
      min = payload.lookUpCellBlock(addrOne, addrTwo) do |min, curr|
        min.nil? || curr < min ? curr : min
      end
      return AbstractSyntaxTree::FloatPrim.new(min)
    when S_MEAN
      addrOne = node.left.addr.traverse(self, payload)
      addrTwo = node.right.addr.traverse(self, payload)
      if "#{addrOne.class}" != P_CELL_ADDR || "#{addrTwo.class}" != P_CELL_ADDR
        raise ArgumentError, "Expected: (CellAddr, CellAddr) \nActual: (#{addrOne.class}, #{addrTwo.class})"
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
      addrOne = node.left.addr.traverse(self, payload)
      addrTwo = node.right.addr.traverse(self, payload)
      if "#{addrOne.class}" != P_CELL_ADDR || "#{addrTwo.class}" != P_CELL_ADDR
        raise ArgumentError, "Expected: (CellAddr, CellAddr) \nActual: (#{addrOne.class}, #{addrTwo.class})"
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
      raise ArgumentError, "illegal arg type: (#{node.class})"
    end
  end
end
