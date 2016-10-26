concepts =
    advanced_strings: false
    algorithms: false
    boolean_logic: false
    basic_html: false
    basic_css: false
    basic_web_scripting: false
    intermediate_html: false
    intermediate_css: false
    intermediate_web_scripting: false
    advanced_html: false
    advanced_css: false
    advanced_web_scripting: false
    input_handling: false
    while_loops: 'WhileStatement'
    advanced_css_rules: false
    advanced_css_selectors: false
    advanced_html_attributes: false
    advanced_html_tags: false
    algorithm_average: false
    algorithm_find_minmax: false
    algorithm_search_binary: false
    algorithm_search_graph: false
    algorithm_sort: false
    algorithm_sum: false
    arguments: false
    arithmetic: false
    array_2d: false
    array_index: false
    array_iterating: false
    array_literals: 'ArrayExpression'
    array_searching: false
    array_sorting: false
    arrays: false
    basic_css_rules: false
    basic_css_selectors: false
    basic_html_attributes: false
    basic_html_tags: false
    basic_syntax: '*'
    binary: false
    boolean_and: 'BinaryExpression[operator="&&"]'
    boolean_equality: 'BinaryExpression[operator="=="]'
    boolean_greater_less: 'BinaryExpression[operator=">"],BinaryExpression[operator="<"]'
    boolean_logic_shortcircuit: false
    boolean_not: 'UnaryyExpression[operator="!"]'
    boolean_operator_precedence: false
    boolean_or: 'BinaryExpression[operator="||"]'
    bootstrap: false
    break_statements: 'BreakStatement'
    classes: false
    continue_statements: 'ContinueStatement'
    dom_events: false
    dynamic_styling: false
    event_concurrency: false
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
    graphs: false
    heaps: false
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
    math_geometry: false
    math_operations: false
    math_trigonometry: 'CallExpression>MemberExpression:matches(.object>Identifier[name=Math]):matches(.property>Identifier[name=sin],>Identifier[name=cos],>Identifier[name=tan])'
    object_literals: 'ObjectExpression'
    parameters: 'CallExpression.arguments>*'
    property_access: ':not(CallExpression,AssignmentExpression)>MemberExpression'
    property_assignment: 'AssignmentExpression.left>MemberExpression'
    queues: false
    reading_docs: false
    recursion: false
    return_statements: 'ReturnStatement'
    stacks: false
    strings: false
    strings_concatenation: false
    strings_substrings: 'CallExpression>MemberExpression>Identifier[name="substr"]'
    trees: false
    variables: false
    vectors: 'Identifier[name=Vector]'
    while_condition_loops: 'WhileStatement.test>*:not(Literal)'
    while_loops_simple: 'WhileStatement.test:matches(Literal)'
    while_loops_nested: 'WhileStatement.body WhileStatement'
    xy_coordinates: 'MemberExpression>Identifier[name="y"]'

module.exports = TagSolution = (solution) ->
  code = solution.code
  engine = new esper.Engine()
  engine.load(code)
  ast = engine.evaluator.ast
  console.log(ast)
  result = []
  for key of concepts
    tkn = concepts[key]
    continue unless tkn
    if typeof tkn is 'function'
      result.push key if tkn(ast)
    else
      result.push key if ast.find(tkn).length > 0

  result
