require_relative './Visitor'
require_relative './AbstractSyntaxTree'

class Serializer include Visitor
  
  def visit(node, payload = nil)
    case "#{node.class}"
    when P_INT
      return "#{node.value}"
    when P_FLT
      return "#{node.value}"
    when P_BOOL
      return "#{node.value}"
    when P_STRING
      return "#{node.value}"
    when P_CELL_ADDR
      return "#{node.value}"
    when A_ADD
      return "(#{self.visit(node.left)} + #{self.visit(node.right)})"
    when SUB
      return "(#{self.visit(node.left)} - #{self.visit(node.right)})"
    when A_MULT
      return "(#{self.visit(node.left)} * #{self.visit(node.right)})"
    when A_DIVIDE
      return "(#{self.visit(node.left)} / #{self.visit(node.right)})"
    when A_MOD
      return "(#{self.visit(node.left)} % #{self.visit(node.right)})"
    when L_AND
      return "(#{self.visit(node.left)} && #{self.visit(node.right)})"
    when L_OR
      return "(#{self.visit(node.left)} || #{self.visit(node.right)})"
    when L_NOT
      return "(!#{self.visit(node.left)})"
    when LVAL
      return "LVALUE: (#{self.visit(node.row)}, #{self.visit(node.collumn)})"
    when RVAL
      return "RVALUE: (#{self.visit(node.row)}, #{self.visit(node.collumn)})"
    when B_AND
      return "(#{self.visit(node.left)} & #{self.visit(node.right)})"
    when B_OR
      return "(#{self.visit(node.left)} | #{self.visit(node.right)})"
    when B_RSHIFT
      return "(#{self.visit(node.left)} >> #{self.visit(node.right)})"
    when B_LSHIFT
      return "(#{self.visit(node.left)} << #{self.visit(node.right)})"
    when B_NOT
      return "(~#{self.visit(node.value)})"
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
