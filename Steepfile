D = Steep::Diagnostic

target :lib do
  signature "sig"
  signature "sig-vendor"

  check "lib"

  library "net-http"

  configure_code_diagnostics(D::Ruby.strict)
  # configure_code_diagnostics(D::Ruby.all_error) # TODO: Enable all error checking
end

target :test do
  unreferenced!                     # Skip type checking the `lib` code when types in test targets is changed
  signature "sig/test"              # Put RBS files for tests under `sig/test`
  check "test", "type-test"         # Type check Ruby scripts under `test` and `type-test`

  configure_code_diagnostics(D::Ruby.strict)       # Keep integration type tests meaningful in CI

  # library "pathname"              # Standard libraries
end
