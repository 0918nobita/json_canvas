import gleam/json

import json_canvas/types

pub fn encode_node_id(node_id: types.NodeId) -> json.Json {
  let types.NodeId(id) = node_id
  json.string(id)
}
