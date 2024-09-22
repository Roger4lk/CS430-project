require_relative 'treetraversal/Evaluator'
require_relative 'treetraversal/Serializer'
require_relative 'grid/Grid'
require_relative 'treetraversal/AbstractSyntaxTree'
 

grid = Grid.new()
payload = Runtime.new(grid)
zero = AbstractSyntaxTree::IntPrim.new(0)
one = AbstractSyntaxTree::IntPrim.new(1)
two = AbstractSyntaxTree::IntPrim.new(2)
three = AbstractSyntaxTree::IntPrim.new(3)
four = AbstractSyntaxTree::IntPrim.new(4)
seven = AbstractSyntaxTree::IntPrim.new(7)
twelve = AbstractSyntaxTree::IntPrim.new(12)

op1 = AbstractSyntaxTree::Modulo.new(AbstractSyntaxTree::Add.new(AbstractSyntaxTree::Multiply.new(seven, four), three), twelve)
op2 = AbstractSyntaxTree::Multiply.new(AbstractSyntaxTree::RValue.new(AbstractSyntaxTree::CellAddr.new(3, 1)), AbstractSyntaxTree::Negate.new(AbstractSyntaxTree::RValue.new(AbstractSyntaxTree::CellAddr.new(2, 1))))
op3 = AbstractSyntaxTree::LshiftBitw.new(AbstractSyntaxTree::RValue.new(AbstractSyntaxTree::CellAddr.new(AbstractSyntaxTree::Add.new(one, one).traverse(Evaluator.new(), payload).value, 4)), three)
op4 = AbstractSyntaxTree::LessThan.new(AbstractSyntaxTree::RValue.new(AbstractSyntaxTree::CellAddr.new(0, 0)), AbstractSyntaxTree::RValue.new( AbstractSyntaxTree::CellAddr.new(0, 0)))
op5 = AbstractSyntaxTree::NotLog.new(AbstractSyntaxTree::GreaterThan.new(AbstractSyntaxTree::FloatPrim.new(3.3), AbstractSyntaxTree::FloatPrim.new(3.2)))
op6 = AbstractSyntaxTree::Sum.new(AbstractSyntaxTree::CellAddr.new(1, 2), AbstractSyntaxTree::CellAddr.new(5, 3))
op7 = AbstractSyntaxTree::Mean.new(AbstractSyntaxTree::CellAddr.new(1, 2), AbstractSyntaxTree::CellAddr.new(5, 3))
op8 = AbstractSyntaxTree::Max.new(AbstractSyntaxTree::CellAddr.new(1, 2), AbstractSyntaxTree::CellAddr.new(5, 3))
op9 = AbstractSyntaxTree::Min.new(AbstractSyntaxTree::CellAddr.new(1, 2), AbstractSyntaxTree::CellAddr.new(5, 3))
op10 = AbstractSyntaxTree::Divide.new(AbstractSyntaxTree::IntToFloat.new(seven), two)

payload.setCell(AbstractSyntaxTree::CellAddr.new(3, 1), four)
payload.setCell(AbstractSyntaxTree::CellAddr.new(2, 1), four)
payload.setCell(AbstractSyntaxTree::CellAddr.new(2, 4), four)
payload.setCell(AbstractSyntaxTree::CellAddr.new(0, 0), four)
payload.setCell(AbstractSyntaxTree::CellAddr.new(0, 1), four)


payload.setCell(AbstractSyntaxTree::CellAddr.new(1, 2), op1)
payload.setCell(AbstractSyntaxTree::CellAddr.new(2, 2), op2)
payload.setCell(AbstractSyntaxTree::CellAddr.new(3, 2), op3)
payload.setCell(AbstractSyntaxTree::CellAddr.new(4, 2), op4)
payload.setCell(AbstractSyntaxTree::CellAddr.new(5, 2), op5)
payload.setCell(AbstractSyntaxTree::CellAddr.new(6, 3), op6)
payload.setCell(AbstractSyntaxTree::CellAddr.new(6, 3), op7)
payload.setCell(AbstractSyntaxTree::CellAddr.new(6, 3), op8)
payload.setCell(AbstractSyntaxTree::CellAddr.new(6, 3), op9)
payload.setCell(AbstractSyntaxTree::CellAddr.new(5, 3), op10)

puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 2)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(2, 2)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(3, 2)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(4, 2)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(5, 2)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(6, 3)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(6, 3)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(6, 3)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(6, 3)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
puts "#{grid.getCell(AbstractSyntaxTree::CellAddr.new(5, 3)).traverse(Serializer.new(), payload)}  =  #{grid.getCell(AbstractSyntaxTree::CellAddr.new(1, 1)).traverse(Evaluator.new(), payload)}"
