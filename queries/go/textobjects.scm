;; Reference file (original textobjects.scm from nvim-treesitter/treesitter-textobjects)
;; :lua print(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter-textobjects/queries/go/textobjects.scm")

;; We have to define the @*.outer bounds of the textobject to be able to "travel backwards" to select a specific component of the textobject
;; https://github.com/nvim-treesitter/nvim-treesitter-textobjects?tab=readme-ov-file#overriding-or-extending-textobjects


; FUNCTIONS

;; outer function textobject
(function_declaration) @function.outer

;; inner function textobject
(function_declaration
  body: (block
    .
    "{"
    .
    (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "function.inner" @_start @_end)))

;; outer function literals
(func_literal
  (_)?) @function.outer

;; inner function literals
(func_literal
  body: (block
    .
    "{"
    .
    (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "function.inner" @_start @_end)))


; METHODS

;; outer method receiver textobject
;; need to define outer boundaries of @method.receiver and @method
(method_declaration
  receiver: (parameter_list) @method.receiver.outer) @method.outer

;; inner method receiver textobject
(method_declaration
  receiver: (parameter_list
    (parameter_declaration) @method.receiver.inner))

;; method as outer function textobject
(method_declaration
  body: (block)?) @function.outer

;; method as inner function textobject
(method_declaration
  body: (block
    .
    "{"
    .
    (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "function.inner" @_start @_end)))


; TYPES

;; struct declaration as type textobject?
(type_declaration
  (type_spec
    (type_identifier)
    (struct_type
      (field_declaration_list
        .
        "{"
        .
        (_) @_start
        (_)? @_end
        .
        "}"
        (#make-range! "type.inner" @_start @_end))))) @type.outer

;; interface declaration as type textobject?
(type_declaration
  (type_spec
    (type_identifier)
    (interface_type
      .
      "{"
      .
      (_) @_start
      (_)? @_end
      .
      "}"
      (#make-range! "type.inner" @_start @_end)))) @type.outer

;; struct literals as type textobject
(composite_literal
  (type_identifier)?
  (struct_type
    (_))?
  (literal_value
    .
    "{"
    .
    (_) @_start
    (_)? @_end
    .
    "}"
    (#make-range! "type.inner" @_start @_end))) @type.outer


; CONDITIONALS

;; outer conditional textobject
(if_statement) @conditional.outer

;; conditional condition textobject
(if_statement
  condition: (_) @conditional.condition)

;; conditional consequence textobject
(if_statement
  consequence: (_
    .
    "{"
    .
    (_) @_start
    (_)? @_end
    .
    "}"
    (#make-range! "conditional.consequence" @_start @_end)))

;; conditional alternative textobject
(if_statement
  alternative: (_
    (_) @conditional.alternative)?)


; LOOPS

;; outer loop textobject
(for_statement) @loop.outer

;; loop condition textobject
(for_statement
  (binary_expression) @loop.condition)

;; loop body textobject
(for_statement
  body: (block
    .
    "{"
    .
    (_) @_start
    (_)? @_end
    .
    "}"
    (#make-range! "loop.body" @_start @_end)))


; CALLS

;; outer call textobject
(call_expression) @call.outer

;; inner call textobject
(call_expression
  arguments: (argument_list
    .
    "("
    .
    (_) @_start
    (_)? @_end
    .
    ")"
    (#make-range! "call.inner" @_start @_end)))


; PARAMETERS

;; outer parameters textobject for function/method declarations
;; (excludes parameter_list under method receivers)
(_
 parameters: (parameter_list
  "("
  .
  (_) @_start
  (_)? @_end
  .
  ")"
  (#make-range! "parameter.outer" @_start @_end)))

;; inner parameters textobject for function/method declarations
;; (excludes parameter_list under method receivers)
(_
 parameters: (parameter_list
  .
  "("
  (_) @parameter.inner
  (_)?
  ")"))

;; inner variadic parameters textobject
;; works for every parameter_list with a variadic syntax (...)
(parameter_list
  "," @_start
  .
  (variadic_parameter_declaration) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))


; ARGUMENTS

;; outer arguments textobject
;; for selecting entire argument_list with @parameter.outer
(_
 arguments: (argument_list
  "("
  .
  (_) @_start
  (_)? @_end
  .
  ")"
  (#make-range! "parameter.outer" @_start @_end)))

;; inner arguments textobject
;; for selecting individual function/method call args
(_
 arguments: (argument_list
  .
  "("
  (_) @parameter.inner
  (_)?
  ")"))


; OPERATORS

(short_var_declaration
  left: (_) @operator.lhs
  right: (_) @operator.rhs @operator.inner) @operator.outer

(assignment_statement
  left: (_) @operator.lhs
  right: (_) @operator.rhs @operator.inner) @operator.outer

(var_spec
  name: (_) @operator.lhs
  value: (_) @operator.rhs @operator.inner) @operator.outer

(var_spec
  name: (_) @operator.inner
  type: (_)) @operator.outer

(const_spec
  name: (_) @operator.lhs
  value: (_) @operator.rhs @operator.inner) @operator.outer

(const_spec
  name: (_) @operator.inner
  type: (_)) @operator.outer

(binary_expression
  left: (_) @operator.lhs
  right: (_) @operator.rhs) @operator.outer

; TODO: figure out how to add <io> insert operator
; (@infix.operator)

; -----------------

; BLOCKS
(_
  (block) @block.inner) @block.outer

; STATEMENTS
(block
  (_) @statement.outer)

; COMMENTS
(comment) @comment.outer

