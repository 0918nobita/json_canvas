import gleam/dynamic as dyn

import json_canvas/decode/edge.{decode_edge}
import json_canvas/decode/node.{decode_node}
import json_canvas/types.{type Canvas, Canvas}

pub fn decode_canvas(dyn: dyn.Dynamic) -> Result(Canvas, List(dyn.DecodeError)) {
  dyn
  |> dyn.decode2(
    Canvas,
    dyn.field("nodes", dyn.list(decode_node)),
    dyn.field("edges", dyn.list(decode_edge)),
  )
}
