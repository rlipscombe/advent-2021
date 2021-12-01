import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn main(args) {
  let [path] = args
  let Ok(bytes) = read_file(path)
  let values =
    bytes
    |> string.trim()
    |> string.split(on: "\n")
    |> list.map(fn(x) {
      int.parse(x)
      |> result.unwrap(or: 0)
    })

  let folder = fn(acc, pair) {
    let [a, b] = pair
    case a < b {
      True -> acc + 1
      _ -> acc
    }
  }

  let part1 =
    values
    |> list.window(by: 2)
    |> list.fold(from: 0, with: folder)

  io.debug(part1)

  let part2 =
    values
    |> list.window(by: 3)
    |> list.map(fn(w) { list.fold(over: w, from: 0, with: fn(x, y) { x + y }) })
    |> list.window(by: 2)
    |> list.fold(from: 0, with: folder)

  io.debug(part2)
}

pub external type Dynamic

external fn read_file(filename: String) -> Result(String, Dynamic) =
  "file" "read_file"
