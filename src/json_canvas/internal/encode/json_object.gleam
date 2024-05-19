import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, Some}

pub fn json_object(
  required_entries: List(#(String, Json)),
  optional_entries: List(#(String, Option(Json))),
) -> Json {
  let optional_entries =
    optional_entries
    |> list.map(fn(entry) {
      let #(field_name, field_value) = entry
      use field_value <- option.then(field_value)
      Some(#(field_name, field_value))
    })
    |> option.values

  let entries = list.append(required_entries, optional_entries)

  json.object(entries)
}
