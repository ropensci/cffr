
write_cff <- function(desc_path = "DESCRIPTION",
                      outfile = "CITATION.cff") {
  citat <- cff_description(desc_path)
  citat <- citat[cff_schema_keys()]

  citat <- drop_null(citat)

  # Write CITATION
  yaml::write_yaml(citat, outfile)

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

# Just for testing
write_cff_testing <- function(desc_path = "DESCRIPTION",
                      outfile = "CITATION.cff") {
  citat <- cff_description(desc_path)
  citat <- citat[cff_schema_keys()]

  citat <- drop_null(citat)

  # Write CITATION
  yaml::write_yaml(citat, outfile)

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
