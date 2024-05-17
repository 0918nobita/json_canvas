import gleam/dynamic as dyn
import gleam/json

import json_canvas/edge.{type Edge, decode_edge}
import json_canvas/node.{type Node, decode_node}

pub type Canvas {
  Canvas(nodes: List(Node), edges: List(Edge))
}

/// Convert `gleam/dynamic`'s `Dynamic` type into a `Canvas` type.
pub fn decoder(dyn: dyn.Dynamic) -> Result(Canvas, List(dyn.DecodeError)) {
  dyn
  |> dyn.decode2(
    Canvas,
    dyn.field("nodes", dyn.list(decode_node)),
    dyn.field("edges", dyn.list(decode_edge)),
  )
}

/// Decode a JSON Canvas string representation into a `Canvas` type.
pub fn decode(from json_canvas: String) -> Result(Canvas, json.DecodeError) {
  json_canvas
  |> json.decode(decoder)
}
