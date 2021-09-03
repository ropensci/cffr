
path <- "ubdeude"

# Try to read citation file
if (path == "."){
    # From local path
  citation_file <- file.path(path,"inst/CITATION")

    pkg <- desc::desc(path)
    meta <- pkg$get(desc::cran_valid_fields)
    meta <- meta[!is.na(meta)]
      # !Important: Add Encoding, this is needed
      if (!("Encoding" %in% names(meta))){
        meta <- c(meta,Encoding="UTF-8")
      }

    if (file.exists(citation_file)){

      citobj <- tryCatch(
        utils::readCitationFile(citation_file, meta = meta ),
        error = function(cond) {
          return(NULL)
        }
      )
    } else {

      citobj <- NULL
    }


} else {

    # If we are not in a root then try to get citation()
    citobj <- tryCatch(
      citation(path),
      error = function(cond) {
        return(NULL)
      }
    )
}

# For preferred citation we keep just the first reference
citobj <- citobj[1]


# if (is.null(citobj))



# if (path == ".") {
#
#   pkg <- desc::desc(path)
#   citation_file <- file.path(path,"inst/CITATION")
#   meta <- pkg$get(desc::cran_valid_fields)
#   meta <- meta[!is.na(meta)]
#
#   # !Important: Add Encoding, this is needed
#   if (!("Encoding" %in% names(meta)){
#     meta <- c(meta,Encoding="UTF-8")
#   }
#   citobj <- utils::readCitationFile(citation_file, meta = meta )
# } else {
#   # If we are not in a root then try to get citation
#   citobj <- tryCatch(
#     citation(pkg),
#     error = function(cond) {
#       return(NULL)
#     }
#   )
#
# }



