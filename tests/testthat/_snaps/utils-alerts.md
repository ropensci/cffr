# abort_if_not_cff rejects unsupported inputs

    Code
      abort_if_not_cff(err)
    Condition
      Error in `abort_if_not_cff()`:
      ! `x` is not a `*.cff` file.
      i Supply a <cff> object or a `*.cff` file path.

---

    Code
      abort_if_not_cff(x)
    Condition
      Error in `abort_if_not_cff()`:
      ! `x` must be a <cff> object or a `*.cff` file path, not a data frame.

# file_exist_abort reports missing files

    Code
      file_exist_abort(nonexits, abort = TRUE)
    Condition
      Error in `file_exist_abort()`:
      ! 'aaaaaaaa' does not exist.
      i Check the '.' directory.

---

    Code
      file_exist_abort(non_with_path, abort = TRUE)
    Condition
      Error in `file_exist_abort()`:
      ! './R/no/existe' does not exist.
      i Check the './R/no' directory.

# match_cff_arg validates allowed values

    Code
      match_cff_arg("a", "b", "...")
    Condition
      Error in `match_cff_arg()`:
      ! `...` must be "b", not "a".

---

    Code
      match_cff_arg("a", c("b", "c", "d"), "what")
    Condition
      Error in `match_cff_arg()`:
      ! `what` must be "b", "c", or "d", not "a".

---

    Code
      my_fun()
    Condition
      Error in `my_fun()`:
      ! `aa` must be "A", "B", "C", "D", or "E", not "a".

