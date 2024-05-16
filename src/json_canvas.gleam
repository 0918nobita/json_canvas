import gleam/dynamic as dyn

import json_canvas/edge.{type Edge, decode_edge}
import json_canvas/node.{type Node, decode_node}

pub type Canvas {
  Canvas(nodes: List(Node), edges: List(Edge))
}

pub fn decode_canvas(dyn: dyn.Dynamic) -> Result(Canvas, List(dyn.DecodeError)) {
  dyn
  |> dyn.decode2(
    Canvas,
    dyn.field("nodes", dyn.list(decode_node)),
    dyn.field("edges", dyn.list(decode_edge)),
  )
}
