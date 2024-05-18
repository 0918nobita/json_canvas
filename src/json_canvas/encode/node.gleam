import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option}
import gleam/result

import json_canvas/encode/color.{encode_color}
import json_canvas/encode/node_id.{encode_node_id}
import json_canvas/types

pub fn encode_file_path(file_path: types.FilePath) -> Json {
  let types.FilePath(file_path) = file_path
  json.string(file_path)
}

pub fn encode_subpath(subpath: types.Subpath) -> Json {
  let types.Subpath(subpath) = subpath
  json.string(subpath)
}

pub fn encode_url(url: types.Url) -> Json {
  let types.Url(url) = url
  json.string(url)
}

pub fn encode_group_label(group_label: types.GroupLabel) -> Json {
  let types.GroupLabel(group_label) = group_label
  json.string(group_label)
}

pub fn encode_group_background(group_background: types.GroupBackground) -> Json {
  let types.GroupBackground(group_background) = group_background
  json.string(group_background)
}

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

fn filter_entry(list: List(#(String, Option(Json)))) -> List(#(String, Json)) {
  list
  |> list.filter_map(fn(entry) {
    let #(key, value) = entry
    use value <- result.try(
      value
      |> option.to_result(Nil),
    )
    Ok(#(key, value))
  })
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

      let optional_entries =
        [#("color", option.map(color, encode_color))]
        |> filter_entry

      json.object(list.append(required_entries, optional_entries))
    }
    types.FileNode(id, x, y, width, height, color, path, subpath) -> {
      let required_entries = [
        #("id", encode_node_id(id)),
        #("x", json.int(x)),
        #("y", json.int(y)),
        #("width", json.int(width)),
        #("height", json.int(height)),
        #("path", encode_file_path(path)),
      ]

      let optional_entries =
        [
          #("color", option.map(color, encode_color)),
          #("subpath", option.map(subpath, encode_subpath)),
        ]
        |> filter_entry

      json.object(list.append(required_entries, optional_entries))
    }
    types.LinkNode(id, x, y, width, height, color, url) -> {
      let required_entries = [
        #("id", encode_node_id(id)),
        #("x", json.int(x)),
        #("y", json.int(y)),
        #("width", json.int(width)),
        #("height", json.int(height)),
        #("url", encode_url(url)),
      ]

      let optional_entries =
        [#("color", option.map(color, encode_color))]
        |> filter_entry

      json.object(list.append(required_entries, optional_entries))
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

      let optional_entries =
        [
          #("color", option.map(color, encode_color)),
          #("label", option.map(label, encode_group_label)),
          #("background", option.map(background, encode_group_background)),
          #(
            "backgroundStyle",
            option.map(background_style, encode_group_background_style),
          ),
        ]
        |> filter_entry

      json.object(list.append(required_entries, optional_entries))
    }
  }
}
