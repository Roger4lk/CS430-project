class SettleLexer
  def initialize(source) 
    @source = source
    @i = 0
    @tokenSoFar = ''
    @tokens = []
  end

  def has(target)
    return @source[@i] == target
  end

  def hasAlphabetic() 
    return 'a' <= @source[@i] && 'z' >= @source[@i]
  end

  def hasNumeric()
    return '0' <= @source[@i] && '9' >= @source[@i]
  end

  def capture()
    @tokenSoFar += @source[@i]
    @i ++
  end

  def emitToken(type) 
    @tokens.push({
      type: type,
      text: @tokenSoFar
    })
    @tokenSoFar = ''
    return 
  end

  def skip() {
    @i ++
  }

  def lex()
    while @i < @source.size
      if has('{')
        capture();
        emitToken(:left_curly)
      elsif has('}')
        capture();
        emitToken(:right_curly)
      elsif has('(')
        capture()
        emitToken(:left_paren)
      elsif has(')')
        capture()
        emitToken(:right_paren)
      elsif hasAlphabetic()
        while hasAlphabetic() || hasNumeric()
          capture();
        end
        emitToken(:identifier);
      elsif has('=')
        capture()
        emitToken(:equal_sign)
      elsif has('+')
        capture()
        emitToken(:plus)
      elsif has(' ')
        skip()
      elsif has("\n") 
        capture();
        emitToken(:line_break);
      elsif has("%")
        capture();
        emitToken(:percent)
      end
    end

    return @tokens
  end
end