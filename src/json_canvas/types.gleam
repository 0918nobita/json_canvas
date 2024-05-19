import gleam/option.{type Option}

pub type NodeId {
  NodeId(String)
}

pub type GroupBackgroundStyle {
  Cover
  Ratio
  Repeat
}

pub type Node {
  TextNode(
    id: NodeId,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(String),
    text: String,
  )
  FileNode(
    id: NodeId,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(String),
    path: String,
    subpath: Option(String),
  )
  LinkNode(
    id: NodeId,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(String),
    url: String,
  )
  GroupNode(
    id: NodeId,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(String),
    label: Option(String),
    background: Option(String),
    background_style: Option(GroupBackgroundStyle),
  )
}

pub type EdgeId {
  EdgeId(String)
}

pub type Side {
  Top
  Right
  Bottom
  Left
}

pub type EndpointShape {
  WithArrow
  WithoutArrow
}

pub type Edge {
  Edge(
    id: EdgeId,
    from_node: NodeId,
    from_side: Option(Side),
    from_end: EndpointShape,
    to_node: NodeId,
    to_side: Option(Side),
    to_end: EndpointShape,
    color: Option(String),
    label: Option(String),
  )
}

pub type Canvas {
  Canvas(nodes: List(Node), edges: List(Edge))
}
