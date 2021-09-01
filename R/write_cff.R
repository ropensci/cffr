
write_cff <- function(desc_path = "DESCRIPTION",
                      message = "If you use this software, please cite it using these metadata.",
                      outfile = "CITATION.cff") {
  citat <- cff_description(desc_path, message)

  # Write CITATION
  yaml::write_yaml(citat, outfile)

  # Now read it and modify it t make it valid
  # This is due to the yaml package format (maybe is v1.1?)

  valid <- readLines(outfile)
  valid <- valid[-1]
  valid <- gsub("^  ", "", valid)

  writeLines(valid, outfile)

  message(crayon::green(outfile, "generated"))

  # Add CITATION.cff to .Rbuildignore
  if (file.exists(".Rbuildignore")) {
    # nocov start
    ignore <- readLines(".Rbuildignore")
    ignore <- c(ignore, "^CITATION\\.cff$")
    ignore <- unique(ignore)

    message(crayon::blue("Adding ", outfile, "to .Rbuildignore"))
    writeLines(ignore, ".Rbuildignore")
    # nocov end
  }
  return(invisible(citat))
}
