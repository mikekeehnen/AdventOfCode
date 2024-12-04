import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/pair
import gleam/regexp.{Match}
import simplifile as file

pub fn main() {
  let assert Ok(input) = file.read("./src/input.txt")
  part1(input) |> int.to_string |> io.println
  part2(input) |> int.to_string |> io.println
}

fn mult_pair(x: String, y: String) -> Int {
  let assert Ok(x) = int.parse(x)
  let assert Ok(y) = int.parse(y)
  x * y
}

fn part1(input: String) -> Int {
  let assert Ok(re) = regexp.from_string("mul\\((\\d+),(\\d+)\\)")
  regexp.scan(re, input)
  |> list.fold(0, fn(sum, match) {
    let assert Match(_, [Some(x), Some(y)]) = match
    sum + mult_pair(x, y)
  })
}

fn part2(input: String) -> Int {
  let assert Ok(re) =
    regexp.from_string("mul\\((\\d+),(\\d+)\\)|do\\(\\)|don't\\(\\)")
  regexp.scan(re, input)
  |> list.fold(#(0, True), fn(state, match) {
    case match, state {
      Match(_, [Some(x), Some(y)]), #(sum, True) -> #(
        sum + mult_pair(x, y),
        True,
      )
      Match("do()", _), #(sum, _) -> #(sum, True)
      Match("don't()", _), #(sum, _) -> #(sum, False)
      _, _ -> state
    }
  })
  |> pair.first
}
