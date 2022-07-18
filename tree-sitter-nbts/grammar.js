module.exports = grammar({
  name: 'aaa',

  rules: {
    source_file: $ => $.expr,
    expr: $ => choice(/[0-9]+/, $.let_expr),
    let_expr: $ => seq('let', /[a-z]+/, 'in', $.expr)
  }
});
