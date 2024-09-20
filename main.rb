require_relative 'treetraversal/Evaluator'
require_relative 'grid/Grid'
require_relative 'treetraversal/AbstractSyntaxTree'
 

grid = Grid.new()
one = AbstractSyntaxTree::IntPrim.new(1)
two = AbstractSyntaxTree::IntPrim.new(2)
three = AbstractSyntaxTree::IntPrim.new(3)
four = AbstractSyntaxTree::IntPrim.new(4)
five = AbstractSyntaxTree::IntPrim.new(5)
six = AbstractSyntaxTree::IntPrim.new(6)
op1 = AbstractSyntaxTree::Add.new(one, two)
op2 = AbstractSyntaxTree::Multiply.new(five, two)
op3 = AbstractSyntaxTree::Divide.new(op1, op2)
op4 = AbstractSyntaxTree::Modulo.new(six, five)
op5 = AbstractSyntaxTree::Negate.new(three)

grid.setCell(AbstractSyntaxTree::CellAddr.new(17, 1), op1)
grid.setCell(AbstractSyntaxTree::CellAddr.new(2, 6), op2)
grid.setCell(AbstractSyntaxTree::CellAddr.new(10, 17), op3)
grid.setCell(AbstractSyntaxTree::CellAddr.new(16, 1), op4)
grid.setCell(AbstractSyntaxTree::CellAddr.new(9, 1), op5)

puts grid.getCell(AbstractSyntaxTree::CellAddr.new(17, 1)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(2, 6)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(10, 17)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(16, 1)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(9, 1)).value

