import gleam/json
import gleam/string_builder

import json_canvas/decode/canvas.{decode_canvas}
import json_canvas/encode/edge.{encode_edge}
import json_canvas/encode/node.{encode_node}
import json_canvas/types.{type Canvas}

/// Decode a JSON Canvas string representation into a `Canvas` value.
pub fn decode(from json_canvas: String) -> Result(Canvas, json.DecodeError) {
  json_canvas
  |> json.decode(decode_canvas)
}

/// Convert a JSON Canvas value into a `gleam/json`'s `Json` value.
pub fn to_json(canvas: Canvas) -> json.Json {
  json.object([
    #("nodes", json.array(canvas.nodes, encode_node)),
    #("edges", json.array(canvas.edges, encode_edge)),
  ])
}

/// Convert a JSON Canvas value into a string.
pub fn to_string(canvas: Canvas) -> String {
  to_json(canvas)
  |> json.to_string
}

/// Convert a JSON Canvas value into a string builder.
pub fn to_string_builder(canvas: Canvas) -> string_builder.StringBuilder {
  to_json(canvas)
  |> json.to_string_builder
}
