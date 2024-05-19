import gleam/json.{type Json}
import gleam/option.{None, Some}

import json_canvas/internal/encode/json_object.{json_object}
import json_canvas/internal/encode/node_id.{encode_node_id}
import json_canvas/types.{WithArrow, WithoutArrow}

pub fn encode_edge_id(edge_id: types.EdgeId) -> Json {
  let types.EdgeId(id) = edge_id
  json.string(id)
}

pub fn encode_side(side: types.Side) -> Json {
  case side {
    types.Top -> "top"
    types.Right -> "right"
    types.Bottom -> "bottom"
    types.Left -> "left"
  }
  |> json.string
}

pub fn encode_edge(edge: types.Edge) -> Json {
  let required_entries = [
    #("id", encode_edge_id(edge.id)),
    #("fromNode", encode_node_id(edge.from_node)),
    #("toNode", encode_node_id(edge.to_node)),
  ]

  let from_end = case edge.from_end {
    WithArrow -> Some(json.string("arrow"))
    WithoutArrow -> None
  }

  let to_end = case edge.to_end {
    WithArrow -> None
    WithoutArrow -> Some(json.string("none"))
  }

  let optional_entries = [
    #("fromSide", option.map(edge.from_side, encode_side)),
    #("fromEnd", from_end),
    #("toSide", option.map(edge.to_side, encode_side)),
    #("toEnd", to_end),
    #("color", option.map(edge.color, json.string)),
    #("label", option.map(edge.label, json.string)),
  ]

  json_object(required_entries, optional_entries)
}
