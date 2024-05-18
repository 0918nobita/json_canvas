import gleam/json

import json_canvas/decode/canvas.{decode_canvas}
import json_canvas/types.{type Canvas}

/// Decode a JSON Canvas string representation into a `Canvas` type.
pub fn decode(from json_canvas: String) -> Result(Canvas, json.DecodeError) {
  json_canvas
  |> json.decode(decode_canvas)
}
