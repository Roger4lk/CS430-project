require_relative 'treetraversal/Visitor'
require_relative 'treetraversal/AbstractSyntaxTree'

class Serializer include Visitor
  def visit(node)
    case node.class
    when AbstractSyntaxTree::IntPrim
      return "#{node.value}"
    when AbstractSyntaxTree::FloatPrim
      return "#{node.value}"
    when AbstractSyntaxTree::BoolPrim
      return "#{node.value}"
    when AbstractSyntaxTree::StringPrim
      return "#{node.value}"
    when AbstractSyntaxTree::CellAddr
      return "#{node.value}"
    when AbstractSyntaxTree::Add
      return "(#{self.visit(node.left)} + #{self.visit(node.right)})"
    when AbstractSyntaxTree::Subtract
      return "(#{self.visit(node.left)} - #{self.visit(node.right)})"
    when AbstractSyntaxTree::Multiply
      return "(#{self.visit(node.left)} * #{self.visit(node.right)})"
    when AbstractSyntaxTree::Divide
      return "(#{self.visit(node.left)} / #{self.visit(node.right)})"
    when AbstractSyntaxTree::Modulo
      return "(#{self.visit(node.left)} % #{self.visit(node.right)})"
    when AbstractSyntaxTree::AndLog
      return "(#{self.visit(node.left)} && #{self.visit(node.right)})"
    when AbstractSyntaxTree::OrLog
      return "(#{self.visit(node.left)} || #{self.visit(node.right)})"
    when AbstractSyntaxTree::NotLog
      return "(!#{self.visit(node.left)})"
    when AbstractSyntaxTree::LValue
      return "LVALUE: (#{self.visit(node.row)}, #{self.visit(node.collumn)})"
    when AbstractSyntaxTree::RValue
      return "RVALUE: (#{self.visit(node.row)}, #{self.visit(node.collumn)})"
    when AbstractSyntaxTree::AndBitw
      return "(#{self.visit(node.left)} & #{self.visit(node.right)})"
    when AbstractSyntaxTree::OrBitw
      return "(#{self.visit(node.left)} | #{self.visit(node.right)})"
    when AbstractSyntaxTree::RshiftBitw
      return "(#{self.visit(node.left)} >> #{self.visit(node.right)})"
    when AbstractSyntaxTree::LshiftBitw
      return "(#{self.visit(node.left)} << #{self.visit(node.right)})"
    when AbstractSyntaxTree::NotBitw
      return "(~#{self.visit(node.value)})"
    when AbstractSyntaxTree::Equal
      return "(#{self.visit(node.left)} == #{self.visit(node.right)})"
    when AbstractSyntaxTree::NotEqual
      return "(#{self.visit(node.left)} != #{self.visit(node.right)})"
    when AbstractSyntaxTree::LessThan
      return "(#{self.visit(node.left)} < #{self.visit(node.right)})"
    when AbstractSyntaxTree::LessEqual
      return "(#{self.visit(node.left)} <= #{self.visit(node.right)})"
    when AbstractSyntaxTree::GreaterThan
      return "(#{self.visit(node.left)} > #{self.visit(node.right)})"
    when AbstractSyntaxTree::GreaterEqual
      return "(#{self.visit(node.left)} >= #{self.visit(node.right)})"
    when AbstractSyntaxTree::FloatToInt
      return "(Int) #{self.visit(node.left)})"
    when AbstractSyntaxTree::IntToFloat
      return "(Float)#{self.visit(node.left)})"
    when AbstractSyntaxTree::Max
      return "MAX(#{self.visit(node.left)}, #{self.visit(node.right)})"
    when AbstractSyntaxTree::Min
      return "MIN(#{self.visit(node.left)}, #{self.visit(node.right)})"
    when AbstractSyntaxTree::Mean
      return "AVERAGE(#{self.visit(node.left)}, #{self.visit(node.right)})"
    when AbstractSyntaxTree::Sum
      return "SUM(#{self.visit(node.left)}, #{self.visit(node.right)})"
    else
      raise "Illegal Arguments: #{node.class} is not a valid arg type"
    end
  end

  
end
product = AbstractSyntaxTree::Multiply.new(AbstractSyntaxTree::Add.new(AbstractSyntaxTree::IntPrim.new(2), AbstractSyntaxTree::IntPrim.new(4)), AbstractSyntaxTree::IntPrim.new(3))
puts product.traverse(Serializer.new())
