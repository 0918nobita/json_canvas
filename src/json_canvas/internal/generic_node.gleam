import gleam/dynamic as dyn
import gleam/option.{type Option}
import gleam/result

import json_canvas/internal/node_type.{type NodeType, decode_node_type}
import json_canvas/types.{type Color, type NodeId, Color, NodeId}

pub type GenericNodeAttrs {
  GenericNodeAttrs(
    id: NodeId,
    ty: NodeType,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(Color),
  )
}

pub fn decode_node_attrs(
  dyn: dyn.Dynamic,
) -> Result(GenericNodeAttrs, List(dyn.DecodeError)) {
  dyn
  |> dyn.decode7(
    GenericNodeAttrs,
    dyn.field("id", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(NodeId)
    }),
    dyn.field("type", decode_node_type),
    dyn.field("x", dyn.int),
    dyn.field("y", dyn.int),
    dyn.field("width", dyn.int),
    dyn.field("height", dyn.int),
    dyn.optional_field("color", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(Color)
    }),
  )
}
