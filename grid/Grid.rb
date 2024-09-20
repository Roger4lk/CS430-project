require_relative '../treetraversal/Evaluator'
require_relative 'Cell'

class Grid
  def initialize() 
    @size = 16 
    @elements = []
    tmpArr = []
    for i in 0..16
      @elements.push([])
    end
  end

  def setCell(cellAddr, astNode)
    if cellAddr.row > @size
      resize(@size*2)
    end
    @elements[cellAddr.row][cellAddr.collumn] = Cell.new(nil, astNode, astNode.traverse(Evaluator.new(), self))
  end

  def getCell(cellAddr)
    return @elements[cellAddr.row][cellAddr.collumn].evaluatedValue
  end

  def resize(addedRows)
    for i in 0..addedRows
      @elements.push([])
    end
  end
end