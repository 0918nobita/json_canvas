# json_canvas

[![Package Version](https://img.shields.io/hexpm/v/json_canvas)](https://hex.pm/packages/json_canvas)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/json_canvas/)

JSON Canvas library for Gleam

For more information about JSON Canvas, please refer to <https://jsoncanvas.org/>.

## Installation

```sh
gleam add json_canvas
```

## Usage

```gleam
import gleam/int
import gleam/io
import gleam/list
import json_canvas
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read(from: "input.canvas")

  // Decode a JSON Canvas from a JSON string
  let assert Ok(canvas) = json_canvas.decode(content)

  let nodes = canvas.nodes
  let edges = canvas.edges

  io.println("Node count: " <> int.to_string(list.length(nodes)))
  io.println("Edge count: " <> int.to_string(list.length(edges)))

  // Encode a JSON Canvas into a JSON string
  canvas
  |> json_canvas.to_string
  |> simplifile.write(to: "output.canvas")
}
```

Further documentation can be found at <https://hexdocs.pm/json_canvas>.


## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
gleam shell # Run an Erlang shell
```
