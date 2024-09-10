class Serializer 
  def visitSetPrimitive(node)
    return  "{#{node.members.join(',')}}"
  end

  def visitSetP
end