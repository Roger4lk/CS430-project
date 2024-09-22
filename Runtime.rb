require_relative 'grid/Grid'
require_relative 'treetraversal/visitor'

class Runtime
  attr_reader :grid

  def initialize(grid=Grid.new()) 
    @grid = grid
  end

  def lookUpCell(cellAddr) 

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
        cellVal = grid.getCell(AbstractSyntaxTree::CellAddr.new(row, collumn))
        if ("#{cellVal.class}" == Visitor::P_INT || "#{cellVal.class}" == Visitor::P_FLT)
          acc = yield(acc, cellVal.value)
        end
      end
    end
    return acc
  end

  


end