import gleam/json.{type Json}
import gleam/option

import json_canvas/internal/encode/json_object.{json_object}
import json_canvas/internal/encode/node_id.{encode_node_id}
import json_canvas/types

pub fn encode_group_background_style(
  group_background_style: types.GroupBackgroundStyle,
) -> Json {
  case group_background_style {
    types.Cover -> "cover"
    types.Ratio -> "ratio"
    types.Repeat -> "repeat"
  }
  |> json.string
}

pub fn encode_node(node: types.Node) -> Json {
  case node {
    types.TextNode(id, x, y, width, height, color, text) -> {
      let required_entries = [
        #("id", encode_node_id(id)),
        #("x", json.int(x)),
        #("y", json.int(y)),
        #("width", json.int(width)),
        #("height", json.int(height)),
        #("text", json.string(text)),
      ]

      let optional_entries = [#("color", option.map(color, json.string))]

      json_object(required_entries, optional_entries)
    }
    types.FileNode(id, x, y, width, height, color, path, subpath) -> {
      let required_entries = [
        #("id", encode_node_id(id)),
        #("x", json.int(x)),
        #("y", json.int(y)),
        #("width", json.int(width)),
        #("height", json.int(height)),
        #("path", json.string(path)),
      ]

      let optional_entries = [
        #("color", option.map(color, json.string)),
        #("subpath", option.map(subpath, json.string)),
      ]

      json_object(required_entries, optional_entries)
    }
    types.LinkNode(id, x, y, width, height, color, url) -> {
      let required_entries = [
        #("id", encode_node_id(id)),
        #("x", json.int(x)),
        #("y", json.int(y)),
        #("width", json.int(width)),
        #("height", json.int(height)),
        #("url", json.string(url)),
      ]

      let optional_entries = [#("color", option.map(color, json.string))]

      json_object(required_entries, optional_entries)
    }
    types.GroupNode(
      id,
      x,
      y,
      width,
      height,
      color,
      label,
      background,
      background_style,
    ) -> {
      let required_entries = [
        #("id", encode_node_id(id)),
        #("x", json.int(x)),
        #("y", json.int(y)),
        #("width", json.int(width)),
        #("height", json.int(height)),
      ]

      let optional_entries = [
        #("color", option.map(color, json.string)),
        #("label", option.map(label, json.string)),
        #("background", option.map(background, json.string)),
        #(
          "backgroundStyle",
          option.map(background_style, encode_group_background_style),
        ),
      ]

      json_object(required_entries, optional_entries)
    }
  }
}
