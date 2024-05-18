import gleam/json

import json_canvas/types

pub fn encode_color(color: types.Color) -> json.Json {
  let types.Color(color) = color
  json.string(color)
}
