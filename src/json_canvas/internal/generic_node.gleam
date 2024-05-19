import gleam/dynamic.{type Dynamic} as dyn
import gleam/option.{type Option}
import gleam/result

import json_canvas/types.{type NodeId, NodeId}

pub type NodeType {
  TextNodeType
  FileNodeType
  LinkNodeType
  GroupNodeType
}

pub fn decode_node_type(dyn: Dynamic) -> Result(NodeType, List(dyn.DecodeError)) {
  use ty <- result.try(dyn.string(dyn))

  case ty {
    "text" -> Ok(TextNodeType)
    "file" -> Ok(FileNodeType)
    "link" -> Ok(LinkNodeType)
    "group" -> Ok(GroupNodeType)
    _ -> Error([dyn.DecodeError("text, file, link or group", ty, [])])
  }
}

pub type GenericNode {
  GenericNode(
    id: NodeId,
    ty: NodeType,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(String),
  )
}

pub fn decode_generic_node(
  dyn: Dynamic,
) -> Result(GenericNode, List(dyn.DecodeError)) {
  dyn
  |> dyn.decode7(
    GenericNode,
    dyn.field("id", fn(dyn) {
      dyn
      |> dyn.string
      |> result.map(NodeId)
    }),
    dyn.field("type", decode_node_type),
    dyn.field("x", dyn.int),
    dyn.field("y", dyn.int),
    dyn.field("width", dyn.int),
    dyn.field("height", dyn.int),
    dyn.optional_field("color", dyn.string),
  )
}
