require_relative 'grid/Grid'
require_relative 'treetraversal/visitor'

class Runtime
  attr_reader :grid

  def initialize(grid=Grid.new()) 
    @grid = grid
  end

  def setCell(cellAddr, astNode)
    @grid.setCell(cellAddr, astNode, self)
  end

  def lookUpCell(cellAddr) 
    return @grid.getCell(cellAddr)
  end

  def lookUpCellBlock(addrOne, addrTwo)
    if (addrOne.row > addrTwo.row)
      bigRowNum = addrOne.row
      smallRowNum = addrTwo.row
    else
      bigRowNum = addrTwo.row
      smallRowNum = addrOne.row
    end
    
    if (addrOne.collumn < addrTwo.collumn)
      leftCol = addrOne.collumn
      rightCol = addrTwo.collumn
    else
      leftCol = addrTwo.collumn
      rightCol = addrOne.collumn
    end
    acc = 0.0

    for row in smallRowNum..bigRowNum
      for collumn in leftCol..rightCol
        currCell = grid.getCell(AbstractSyntaxTree::CellAddr.new(row, collumn))
        currNode = currCell.astNode.traverse(Evaluator.new(), self)
        if ("#{currNode.class}" != Visitor::P_INT && "#{currNode.class}" != Visitor::P_FLT) || acc.nil? || currNode.nil?
          raise ArgumentError, "some cells are of illegal type or nil"
        else
          acc = yield(acc, currNode.value)
        end
      end
    end
    return acc
  end

  


end