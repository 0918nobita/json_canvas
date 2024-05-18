import gleam/dynamic as dyn
import gleam/option
import gleam/result

import json_canvas/internal/node.{
  FileNodeType, GroupNodeType, LinkNodeType, TextNodeType, decode_generic_node,
}
import json_canvas/types.{
  type GroupBackgroundStyle, type Node, Cover, FileNode, FilePath,
  GroupBackground, GroupLabel, GroupNode, LinkNode, Ratio, Repeat, Subpath,
  TextNode, Url,
}

pub fn decode_group_background_style(
  dyn: dyn.Dynamic,
) -> Result(GroupBackgroundStyle, List(dyn.DecodeError)) {
  use style <- result.try(dyn.string(dyn))
  case style {
    "cover" -> Ok(Cover)
    "ratio" -> Ok(Ratio)
    "repeat" -> Ok(Repeat)
    _ -> Error([dyn.DecodeError("cover, ratio or repeat", style, [])])
  }
}

pub fn decode_node(dyn: dyn.Dynamic) -> Result(Node, List(dyn.DecodeError)) {
  use node <- result.try(decode_generic_node(dyn))

  case node.ty {
    TextNodeType -> {
      use text <- result.try(dyn.field("text", dyn.string)(dyn))
      Ok(TextNode(
        node.id,
        node.x,
        node.y,
        node.width,
        node.height,
        node.color,
        text,
      ))
    }
    FileNodeType -> {
      use #(path, subpath) <- result.try(
        dyn
        |> dyn.decode2(
          fn(path, subpath) { #(path, subpath) },
          dyn.field("path", dyn.string),
          dyn.optional_field("subpath", dyn.string),
        ),
      )
      Ok(FileNode(
        node.id,
        node.x,
        node.y,
        node.width,
        node.height,
        node.color,
        FilePath(path),
        option.map(over: subpath, with: Subpath),
      ))
    }
    LinkNodeType -> {
      use url <- result.try(dyn.field("url", dyn.string)(dyn))
      Ok(LinkNode(
        node.id,
        node.x,
        node.y,
        node.width,
        node.height,
        node.color,
        Url(url),
      ))
    }
    GroupNodeType -> {
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
      Ok(GroupNode(
        node.id,
        node.x,
        node.y,
        node.width,
        node.height,
        node.color,
        option.map(over: label, with: GroupLabel),
        option.map(over: background, with: GroupBackground),
        background_style,
      ))
    }
  }
}
