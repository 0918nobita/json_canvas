import gleam/dynamic as dyn
import gleam/result

pub type EndpointShape {
  WithArrow
  WithoutArrow
}

pub fn decode_endpoint_shape(
  dyn: dyn.Dynamic,
) -> Result(EndpointShape, List(dyn.DecodeError)) {
  use shape <- result.try(dyn.string(dyn))
  case shape {
    "none" -> Ok(WithoutArrow)
    "arrow" -> Ok(WithArrow)
    _ -> Error([dyn.DecodeError("none or arrow", shape, [])])
  }
}
