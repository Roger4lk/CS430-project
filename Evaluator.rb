class Evaluator 
  def visitSetPrimitive(node)
    return node
  end

  def visitIntersect(node)
    visit the left and right nodes of node and evaluate
  end
end