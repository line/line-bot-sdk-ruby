# type-test

This directory contains type-only sanity checks for Steep.

- Files here are checked by `steep check` in CI.
- They are not runtime specs and are not executed by RSpec.
- Purpose: detect typing regressions in public API usage examples early.
- You can also run them locally to quickly verify user-land usage stays type-safe.
