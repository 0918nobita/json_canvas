import gleam/json.{type Json}
import gleam/list
import gleam/option.{None, Some}

import json_canvas/encode/color.{encode_color}
import json_canvas/encode/node_id.{encode_node_id}
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

pub fn encode_edge_label(edge_label: types.EdgeLabel) -> Json {
  let types.EdgeLabel(label) = edge_label
  json.string(label)
}

pub fn encode_edge(edge: types.Edge) -> Json {
  let required_entries = [
    #("id", encode_edge_id(edge.id)),
    #("fromNode", encode_node_id(edge.from_node)),
    #("toNode", encode_node_id(edge.to_node)),
  ]

  let from_side =
    edge.from_side
    |> option.map(fn(side) { #("fromSide", encode_side(side)) })

  let from_end = case edge.from_end {
    WithArrow -> Some(#("fromEnd", json.string("arrow")))
    WithoutArrow -> None
  }

  let to_side =
    edge.to_side
    |> option.map(fn(side) { #("toSide", encode_side(side)) })

  let to_end = case edge.to_end {
    WithArrow -> None
    WithoutArrow -> Some(#("toEnd", json.string("none")))
  }

  let color =
    edge.color
    |> option.map(fn(color) { #("color", encode_color(color)) })

  let label =
    edge.label
    |> option.map(fn(label) { #("label", encode_edge_label(label)) })

  let optional_entries =
    [from_side, from_end, to_side, to_end, color, label]
    |> option.values

  json.object(list.append(required_entries, optional_entries))
}
