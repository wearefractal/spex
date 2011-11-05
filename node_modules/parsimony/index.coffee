log = require 'node-log'
util = require 'util'; dump = (obj) -> log.info util.inspect(obj)
async = require 'async'

# Parsimony supports one style of parsing: annotated code blocks

Parsimony =

  # default token: ">>"
  parsingDelim: />>(.+)\n/

  # parse out annotated code blocks
  parse: (dsl, delim = @parsingDelim) ->
    # strip leading whitespace and \n's
    dsl.replace /^\n\s+/, ''

    # split out features by the parsing token ( '>> by default )
    tokens = dsl.split @parsingDelim

    tokens.shift() # remove first token
    blocks = [] # declare blocks as an array

    # every other token is an annotation, and the immediate next token a codeblock
    for token, index in tokens by 2
      blocks.push
      # block:
        annotation: token.trim()
        code: tokens[index + 1].trim() # the next token is code
        leadspace: getLeadspace tokens[index + 1]

    return blocks

module.exports = Parsimony

##

getLeadspace = (code) ->
  # fuck off - this is a space? \s includes \n :/
  leadspaceMatch = /^\n*( *)|[a-zA-Z]\n$/
  return leadspace = (code.match leadspaceMatch)[1] # result of match

### TEST

should = require 'should'

#>> Given some DSL code

code = '''

       >> Given some dsl code
         foo = "foo"
       '''

#>> When Parsimony parses it

blocks = Parsimony.parse code

#>> Then blocks should have 1 element

blocks.length.should.equal 1

#>> and the first element should be 'foo'

node = blocks.shift()
node.annotation.should.equal "Given some dsl code"
node.code.should.equal 'foo = "foo"'


#>> Given more complex dsl code

code = '''
       >> Given some dsl code
          foo = "foo"
       >> When I want to add another string
          foo+=" bar"
       >> Then I should see the strings appended
            foo ==="foo bar"
       '''

#>> When Parsimony parses it

blocks = Parsimony.parse code

#>> Then blocks should have 1 element

blocks.length.should.equal 3

#>> and the first element should be 'foo'

node = blocks.shift()
node.annotation.should.equal "Given some dsl code"
node.code.should.equal 'foo = "foo"'
node = blocks.shift()
node.annotation.should.equal "When I want to add another string"
node.code.should.equal 'foo+=" bar"'
node = blocks.shift()
node.annotation.should.equal "Then I should see the strings appended"
node.code.should.equal 'foo ==="foo bar"'

# TODO: test for other delimiters

