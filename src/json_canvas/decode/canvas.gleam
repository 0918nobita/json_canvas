import gleam/dynamic as dyn

import json_canvas/decode/edge.{decode_edge}
import json_canvas/decode/node.{decode_node}
import json_canvas/types

pub fn decode_canvas(
  dyn: dyn.Dynamic,
) -> Result(types.Canvas, List(dyn.DecodeError)) {
  dyn
  |> dyn.decode2(
    types.Canvas,
    dyn.field("nodes", dyn.list(decode_node)),
    dyn.field("edges", dyn.list(decode_edge)),
  )
}
