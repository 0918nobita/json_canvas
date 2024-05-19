import gleam/dynamic as dyn
import gleam/result

import json_canvas/internal/generic_node.{decode_generic_node}
import json_canvas/types

pub fn decode_group_background_style(
  dyn: dyn.Dynamic,
) -> Result(types.GroupBackgroundStyle, List(dyn.DecodeError)) {
  use style <- result.try(dyn.string(dyn))

  case style {
    "cover" -> Ok(types.Cover)
    "ratio" -> Ok(types.Ratio)
    "repeat" -> Ok(types.Repeat)
    _ -> Error([dyn.DecodeError("cover, ratio or repeat", style, [])])
  }
}

pub fn decode_node(
  dyn: dyn.Dynamic,
) -> Result(types.Node, List(dyn.DecodeError)) {
  use node <- result.try(decode_generic_node(dyn))

  case node.ty {
    generic_node.TextNodeType -> {
      use text <- result.try(dyn.field("text", dyn.string)(dyn))

      Ok(types.TextNode(
        node.id,
        node.x,
        node.y,
        node.width,
        node.height,
        node.color,
        text,
      ))
    }
    generic_node.FileNodeType -> {
      use #(path, subpath) <- result.try(
        dyn
        |> dyn.decode2(
          fn(path, subpath) { #(path, subpath) },
          dyn.field("path", dyn.string),
          dyn.optional_field("subpath", dyn.string),
        ),
      )

      Ok(types.FileNode(
        node.id,
        node.x,
        node.y,
        node.width,
        node.height,
        node.color,
        path,
        subpath,
      ))
    }
    generic_node.LinkNodeType -> {
      use url <- result.try(dyn.field("url", dyn.string)(dyn))

      Ok(types.LinkNode(
        node.id,
        node.x,
        node.y,
        node.width,
        node.height,
        node.color,
        url,
      ))
    }
    generic_node.GroupNodeType -> {
      use #(label, background, background_style) <- result.try(
        dyn
        |> dyn.decode3(
          fn(label, background, background_style) {
            #(label, background, background_style)
          },
          dyn.optional_field("label", dyn.string),
          dyn.optional_field("background", dyn.string),
          dyn.optional_field("background_style", decode_group_background_style),
        ),
      )

      Ok(types.GroupNode(
        node.id,
        node.x,
        node.y,
        node.width,
        node.height,
        node.color,
        label,
        background,
        background_style,
      ))
    }
  }
}
