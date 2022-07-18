
fn main() {
  let code = "let x = 10";
  let mut parser = tree_sitter::Parser::new();
  parser.set_language(tree_sitter_aaa::language()).expect("Error loading grammar");
  let tree = parser.parse(code, None).expect("parsing error");
  println!("tree={:?}", tree);
}
