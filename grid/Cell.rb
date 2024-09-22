# Represents a Cell in a spreadsheet.
# Each cell has a source code, an abstract syntax tree node, and an evaluated value.
class Cell 
  attr_reader :evaluatedValue, :astNode
  
  # Initializes a new instance of the Cell class.
  # @param sourceCode [String] The source code of the cell.
  # @param astNode [AbstractSyntaxTree] The abstract syntax tree node of the cell.
  # @param evaluatedValue [Object] The evaluated value of the cell.
  def initialize(sourceCode, astNode, evaluatedValue)
    @sourceCode = sourceCode
    @astNode = astNode
    @evaluatedValue = evaluatedValue
  end
end