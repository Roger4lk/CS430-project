require_relative '../treetraversal/AbstractSyntaxTree'
require_relative '../treetraversal/Evaluator'

class Cell 
  attr_reader :evaluatedValue, :astNode
  
  ###
  # @description: 
  # @param {any}: 
  # @return {any}: 
  ###
  def initialize(sourceCode, astNode,q[]'' evaluatedValue)
    @sourceCode = sourceCode
    @astNode = astNode
    @evaluatedValue = evaluatedValue
  end
end