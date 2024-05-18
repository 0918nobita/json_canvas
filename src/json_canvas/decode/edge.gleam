import gleam/dynamic as dyn
import gleam/option
import gleam/result

import json_canvas/types.{NodeId, WithArrow, WithoutArrow}

pub fn decode_side(
  dyn: dyn.Dynamic,
) -> Result(types.Side, List(dyn.DecodeError)) {
  use side <- result.try(dyn.string(dyn))
  case side {
    "top" -> Ok(types.Top)
    "right" -> Ok(types.Right)
    "bottom" -> Ok(types.Bottom)
    "left" -> Ok(types.Left)
    _ -> Error([dyn.DecodeError("top, right, bottom or left", side, [])])
  }
}

pub fn decode_endpoint_shape(
  dyn: dyn.Dynamic,
) -> Result(types.EndpointShape, List(dyn.DecodeError)) {
  use shape <- result.try(dyn.string(dyn))
  case shape {
    "none" -> Ok(WithoutArrow)
    "arrow" -> Ok(WithArrow)
    _ -> Error([dyn.DecodeError("none or arrow", shape, [])])
  }
}

pub fn decode_edge(
  dyn: dyn.Dynamic,
) -> Result(types.Edge, List(dyn.DecodeError)) {
  dyn
  |> dyn.decode9(
    types.Edge,
    dyn.field("id", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(types.EdgeId)
    }),
    dyn.field("fromNode", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(NodeId)
    }),
    dyn.optional_field("fromSide", decode_side),
    fn(dyn) {
      dyn
      |> dyn.optional_field("fromEnd", decode_endpoint_shape)
      |> result.map(option.unwrap(_, or: WithoutArrow))
    },
    dyn.field("toNode", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(NodeId)
    }),
    dyn.optional_field("toSide", decode_side),
    fn(dyn) {
      dyn
      |> dyn.optional_field("toEnd", decode_endpoint_shape)
      |> result.map(option.unwrap(_, or: WithArrow))
    },
    dyn.optional_field("color", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(types.Color)
    }),
    dyn.optional_field("label", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(types.EdgeLabel)
    }),
  )
}
