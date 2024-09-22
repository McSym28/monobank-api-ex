# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  import_deps: if(Mix.env() == :test, do: [:phoenix], else: [])
]
