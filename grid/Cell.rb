require_relative '../treetraversal/AbstractSyntaxTree'
require_relative '../treetraversal/Evaluator'

class Cell 
  attr_reader :evaluatedValue

  def initialize(sourceCode, astNode, evaluatedValue)
    @sourceCode = sourceCode
    @astNode = astNode
    @evaluatedValue = evaluatedValue
  end

end