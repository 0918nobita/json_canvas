import gleam/dynamic as dyn
import gleam/result

pub type NodeType {
  TextNodeType
  FileNodeType
  LinkNodeType
  GroupNodeType
}

pub fn decode_node_type(
  dyn: dyn.Dynamic,
) -> Result(NodeType, List(dyn.DecodeError)) {
  use ty <- result.try(dyn.string(dyn))
  case ty {
    "text" -> Ok(TextNodeType)
    "file" -> Ok(FileNodeType)
    "link" -> Ok(LinkNodeType)
    "group" -> Ok(GroupNodeType)
    _ -> Error([dyn.DecodeError("text, file, link or group", ty, [])])
  }
}
