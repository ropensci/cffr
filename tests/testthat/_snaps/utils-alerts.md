# Check abort_if_not_cff

    Code
      abort_if_not_cff(err)
    Condition
      Error in `abort_if_not_cff()`:
      ! `x` is not a '*.cff' file.

---

    Code
      abort_if_not_cff(x)
    Condition
      Error in `abort_if_not_cff()`:
      ! `x` is an object of class <data.frame>, not <cff>.

# Check file_exist_abort

    Code
      file_exist_abort(nonexits, abort = TRUE)
    Condition
      Error in `file_exist_abort()`:
      ! 'aaaaaaaa' doesn't exist. Check the '.' directory

---

    Code
      file_exist_abort(non_with_path, abort = TRUE)
    Condition
      Error in `file_exist_abort()`:
      ! './R/no/existe' doesn't exist. Check the './R/no' directory

# Check match_cff_arg

    Code
      match_cff_arg("a", "b", "...")
    Condition
      Error in `match_cff_arg()`:
      ! `...` should be "b", not "a".

---

    Code
      match_cff_arg("a", c("b", "c", "d"), "what")
    Condition
      Error in `match_cff_arg()`:
      ! `what` should be "b", "c", or "d", not "a".

---

    Code
      my_fun()
    Condition
      Error in `my_fun()`:
      ! `aa` should be "A", "B", "C", "D", or "E", not "a".

