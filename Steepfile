D = Steep::Diagnostic

target :lib do
  signature "sig"
  signature "sig-vendor"

  check "lib"
  ignore "lib/line/bot/v1"

  library "net-http"

  configure_code_diagnostics(D::Ruby.default)
  # configure_code_diagnostics(D::Ruby.strict) # TODO: Enable strict checking
  # configure_code_diagnostics(D::Ruby.all_error) # TODO: Enable all error checking
end

target :test do
  unreferenced!                     # Skip type checking the `lib` code when types in `test` target is changed
  signature "sig/test"              # Put RBS files for tests under `sig/test`
  check "test"                      # Type check Ruby scripts under `test`

  configure_code_diagnostics(D::Ruby.lenient)      # Weak type checking for test code

  # library "pathname"              # Standard libraries
end
