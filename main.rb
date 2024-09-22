require_relative 'treetraversal/Evaluator'
require_relative 'grid/Grid'
require_relative 'treetraversal/AbstractSyntaxTree'
 

grid = Grid.new()
payload = Runtime.new(grid)
one = AbstractSyntaxTree::IntPrim.new(1)
two = AbstractSyntaxTree::IntPrim.new(2)
three = AbstractSyntaxTree::IntPrim.new(3)
four = AbstractSyntaxTree::IntPrim.new(4)
five = AbstractSyntaxTree::IntPrim.new(5)
six = AbstractSyntaxTree::IntPrim.new(6)
op1 = AbstractSyntaxTree::Add.new(one, two)
op2 = AbstractSyntaxTree::Multiply.new(five, two)
op3 = AbstractSyntaxTree::Divide.new(op1, one)
op4 = AbstractSyntaxTree::Modulo.new(six, five)
op5 = AbstractSyntaxTree::Negate.new(three)
op6 = AbstractSyntaxTree::Subtract.new(one, op3)

grid.setCell(AbstractSyntaxTree::CellAddr.new(1, 1), op1)
grid.setCell(AbstractSyntaxTree::CellAddr.new(1, 2), op2)
grid.setCell(AbstractSyntaxTree::CellAddr.new(1, 3), op3)
grid.setCell(AbstractSyntaxTree::CellAddr.new(2, 1), op4)
grid.setCell(AbstractSyntaxTree::CellAddr.new(2, 2), op5)
grid.setCell(AbstractSyntaxTree::CellAddr.new(2, 3), op6)

puts grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 2)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 3)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(2, 1)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(2, 2)).value
puts grid.getCell(AbstractSyntaxTree::CellAddr.new(2, 3)).value
puts "sum: #{AbstractSyntaxTree::Mean.new(AbstractSyntaxTree::CellAddr.new(1, 1), AbstractSyntaxTree::CellAddr.new(2, 3)).traverse(Evaluator.new(), payload).value}"

