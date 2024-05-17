# json_canvas

[![Package Version](https://img.shields.io/hexpm/v/json_canvas)](https://hex.pm/packages/json_canvas)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/json_canvas/)

JSON Canvas library for Gleam

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
  let assert Ok(content) = simplifile.read("input.canvas")
  let assert Ok(canvas) = json_canvas.decode(content)

  let nodes = canvas.nodes
  let edges = canvas.edges

  io.println("Nodes count: " <> int.to_string(list.length(nodes)))
  io.println("Edges count: " <> int.to_string(list.length(edges)))
}
```

Further documentation can be found at <https://hexdocs.pm/json_canvas>.


## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
gleam shell # Run an Erlang shell
```
