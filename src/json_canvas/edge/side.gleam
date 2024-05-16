import gleam/dynamic as dyn
import gleam/result

pub type Side {
  Top
  Right
  Bottom
  Left
}

pub fn decode_side(dyn: dyn.Dynamic) -> Result(Side, List(dyn.DecodeError)) {
  use side <- result.try(dyn.string(dyn))
  case side {
    "top" -> Ok(Top)
    "right" -> Ok(Right)
    "bottom" -> Ok(Bottom)
    "left" -> Ok(Left)
    _ -> Error([dyn.DecodeError("top, right, bottom or left", side, [])])
  }
}
