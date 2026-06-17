# Test in mock package

    Code
      cff_gha_update()
    Message
      i Creating directory './.github/workflows'.
      v Installing './.github/workflows/update-citation-cff.yaml'.
      i Adding '.github' to '.Rbuildignore'.

---

    Code
      cff_gha_update()
    Message
      ! File './.github/workflows/update-citation-cff.yaml' is already installed. Use `overwrite = TRUE` to overwrite it.

---

    Code
      cff_gha_update(overwrite = TRUE)
    Message
      v Installing './.github/workflows/update-citation-cff.yaml'.

