import gleam/option.{type Option}

pub type NodeId {
  NodeId(String)
}

pub type Color {
  Color(String)
}

pub type FilePath {
  FilePath(String)
}

pub type Subpath {
  Subpath(String)
}

pub type Url {
  Url(String)
}

pub type GroupLabel {
  GroupLabel(String)
}

pub type GroupBackground {
  GroupBackground(String)
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
    color: Option(Color),
    text: String,
  )
  FileNode(
    id: NodeId,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(Color),
    path: FilePath,
    subpath: Option(Subpath),
  )
  LinkNode(
    id: NodeId,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(Color),
    url: Url,
  )
  GroupNode(
    id: NodeId,
    x: Int,
    y: Int,
    width: Int,
    height: Int,
    color: Option(Color),
    label: Option(GroupLabel),
    background: Option(GroupBackground),
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

pub type EdgeLabel {
  EdgeLabel(String)
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
    color: Option(Color),
    label: Option(EdgeLabel),
  )
}

pub type Canvas {
  Canvas(nodes: List(Node), edges: List(Edge))
}
