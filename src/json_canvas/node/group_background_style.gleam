import gleam/dynamic as dyn
import gleam/result

pub type GroupBackgroundStyle {
  Cover
  Ratio
  Repeat
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
