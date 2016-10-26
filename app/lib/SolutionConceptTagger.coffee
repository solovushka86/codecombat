concepts =
    advanced_strings: false
    while_loops: 'WhileStatement'
    advanced_css_rules: false
    advanced_css_selectors: false
    advanced_html_attributes: false
    advanced_html_tags: false

    arguments: 'CallExpression.arguments>*'
    arithmetic: (ast) -> _.some ast.find('BinaryExpression'), (n) -> n.operator in ['+','-','*','/'] and n.right?.value isnt 1
    array_2d: 'MemberExpression[computed=true].object>MemberExpression[computed=true]'
    array_index: false
    array_literals: 'ArrayExpression'
    arrays: false

    basic_css_rules: false
    basic_css_selectors: false
    basic_html_attributes: false
    basic_html_tags: false
    basic_syntax: '*'

    binary: (ast) ->
      _.some ast.find('CallExpression.callee>MemberExpression.property>Identifier[name="toString"]'), (n) ->
        call = n.parent.parent
        return false unless call.arguments.length is 1
        call.matches('Literal[value=2]')

    boolean_and: 'BinaryExpression[operator="&&"]'
    boolean_equality: 'BinaryExpression[operator="=="]'
    boolean_greater_less: 'BinaryExpression[operator=">"],BinaryExpression[operator="<"]'
    boolean_not: 'UnaryyExpression[operator="!"]'
    boolean_or: 'BinaryExpression[operator="||"]'

    bootstrap: false
    break_statements: 'BreakStatement'
    classes: false
    continue_statements: 'ContinueStatement'
    dom_events: false
    dynamic_styling: false

    event_data: false
    event_handlers: false

    for_loops: 'ForStatement'
    for_loops_nested: 'ForStatement ForStatement'
    for_loops_range: false
    functions: 'Function'
    
    game_ai: false
    game_goals: false
    game_spawn: false
   
    graphics: false

    if_else_statements: 'if.alternate>*'
    if_statements: 'if'
    if_statements_nested: 'if if'
    indexing: 'MemberExpression[computed=true]'
    
    input_handling_flags: false
    input_handling_keyboard: false
    input_handling_mouse: false

    intermediate_css_rules: false
    intermediate_css_selectors: false
    intermediate_html_attributes: false
    intermediate_html_tags: false
    
    jquery: false
    jquery_animations: false
    jquery_filtering: false
    jquery_selectors: false
   
    length: 'MemberExpression.property>Identifier[name="length"]'
    math_operations: 'CallExpression>MemberExpression:matches(.object>Identifier[name=Math]).property:matches(>Identifier[name=sqrt],>Identifier[name=pow],>Identifier[name=abs])'
    math_trigonometry: 'CallExpression>MemberExpression:matches(.object>Identifier[name=Math]).property:matches(>Identifier[name=sin],>Identifier[name=cos],>Identifier[name=tan])'
    object_literals: 'ObjectExpression'
    parameters: 'Function.params>*'
    property_access: ':not(CallExpression,AssignmentExpression)>MemberExpression'
    property_assignment: 'AssignmentExpression.left>MemberExpression'

    recursion: false
    return_statements: 'ReturnStatement'

    strings: (ast) -> _.some ast.find("Literal"), (e) -> typeof e.value is 'string'
    strings_concatenation: false
    strings_substrings: 'CallExpression>MemberExpression>Identifier[name="substr"],CallExpression>MemberExpression>Identifier[name="substring"]'

    variables: 'VariableDeclaration'
    vectors: 'Identifier[name=Vector]'
    while_condition_loops: 'WhileStatement.test>*:not(Literal)'
    while_loops_simple: 'WhileStatement.test:matches(Literal)'
    while_loops_nested: 'WhileStatement.body WhileStatement'
    xy_coordinates: (ast) ->
      return false unless ast.find('MemberExpression.object>Identifier[name="y"]').length > 0
      return false unless ast.find('MemberExpression.object>Identifier[name="x"]').length > 0
      return true

module.exports = TagSolution = (solution) ->
  code = solution.source
  engine = new esper.Engine()
  engine.load(code)
  ast = engine.evaluator.ast
  result = []
  for key of concepts
    tkn = concepts[key]
    continue unless tkn
    if typeof tkn is 'function'
      result.push key if tkn(ast)
    else
      result.push key if ast.find(tkn).length > 0

  result
