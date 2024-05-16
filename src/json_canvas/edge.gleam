import gleam/dynamic as dyn
import gleam/option.{type Option}
import gleam/result

import json_canvas/edge/endpoint_shape.{
  type EndpointShape, WithArrow, WithoutArrow, decode_endpoint_shape,
}
import json_canvas/edge/side.{type Side, decode_side}
import json_canvas/types.{type Color, type NodeId, Color, NodeId}

pub type EdgeId {
  EdgeId(String)
}

pub type EdgeLabel {
  EdgeLabel(String)
}

pub type Edge {
  Edge(
    id: EdgeId,
    from_node: NodeId,
    from_side: Option(Side),
    from_end: EndpointShape,
    to_node: NodeId,
    to_side: Option(Side),
    to_end: EndpointShape,
    color: Option(Color),
    label: Option(EdgeLabel),
  )
}

pub fn decode_edge(dyn: dyn.Dynamic) -> Result(Edge, List(dyn.DecodeError)) {
  dyn
  |> dyn.decode9(
    Edge,
    dyn.field("id", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(EdgeId)
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
      |> result.map(Color)
    }),
    dyn.optional_field("label", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(EdgeLabel)
    }),
  )
}
