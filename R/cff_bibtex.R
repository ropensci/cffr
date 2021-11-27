#
# x <- cff_create("ggplot2")
# x <- x[names(x) != "preferred-citation"]
# x <- as.cff(x)
# x
#
# # Read cff of CITATION.cff file
#
# stopifnotcff(x)
# if (!is.cff(x)) x <- cff(x)
#
# # Extract preferred-citation
# cit <- x[["preferred-citation"]]
#
#
# # If not available create auto
# if (is.null(cit)) cit  <- parse_preferred_auto(x)
#
# # Clean cff object
# # Fix a couple of names to match cff to bibtex
# newnames <- gsub("authors", "author", names(cit))
# newnames <- gsub("editors", "editor", newnames)
#
# names(cit) <- newnames
#
#
# bibentry("Misc",
#          title = "a",
#          year=2021,
#          author = as.person(x1)
#          )
#
# cff_create("base")$authors
#
# c(x1[1], x1[2])
#
# c(x1[1], x2[2])
#
# x1 <- cff_unparse_person(cit$author)
# x1
#
# as.person(ss)
#
# persons <- cit$author[1]
#
# x1 <- lapply(cit$author[1:2], cff_unparse_person)
# x1
#
#
# c(
#   person("Hadley", "Wickham", , "hadley@rstudio.com", "aut",
#          comment = c(ORCID = "0000-0003-4757-117X")),
#   person("Winston", "Chang", , role = "aut",
#          comment = c(ORCID = "0000-0002-1576-2126")),
#   person("Lionel", "Henry", , role = "aut"),
#   person("Thomas Lin", "Pedersen", , "thomas.pedersen@rstudio.com",
#          role = c("aut", "cre"), comment = c(ORCID = "0000-0002-5147-4711")),
#   person("Kohske", "Takahashi", role = "aut"),
#   person("Claus", "Wilke", role = "aut",
#          comment = c(ORCID = "0000-0002-7470-9261")),
#   person("Kara", "Woo", role = "aut",
#          comment = c(ORCID = "0000-0002-5125-4188")),
#   person("Hiroaki", "Yutani", role = "aut",
#          comment = c(ORCID = "0000-0002-3385-7233")),
#   person("Dewey", "Dunnington", role = "aut",
#          comment = c(ORCID = "0000-0002-9415-4582")),
#   person("RStudio", role = c("cph", "fnd"))
# )
#
# attr(x1,"class") <- "person"
#
# bibentry("Misc",
#          title = "a",
#          year=2020,
#          author = x1)
# x1
#
# f <- x1[1]
# sapply(x1, "[[", 1)
# c(person("Hadley", "Wickham"), person("Winston", "Chang"))
#
# x1_u <- unclass(x1)
# x2_u <- unclass(x2)
#
# unlist(x1, recursive = FALSE)
#
# class(x1) <- "person"
# f
#
# class(f2)
# class(f)
# s2 <- sapply(f, 1, function)
#
# pers <- cit$author[[1]]
#
# pers
#
# cff_unparse_
#
# is_entity <- is.null(pers$`family-names`)
#
# # Construct a R person object
#
# old_names <- names(pers)
# if (is_entity) {
#   newnames <- gsub("name", "given", old_names)
#
# } else {
# new_names <- gsub("family-names", "family", old_names)
# new_names <- gsub("given-names", "given", new_names)
# }
#
# names(pers) <- new_names
#
# # Create comments
# params <- pers[new_names %in% c("given", "family", "email", "role")]
#
# comments <- pers[!new_names %in% c("given", "family", "email", "role")]
# comments <- unlist(comments)
#
# def <- c(params, list(comment = comments))
# def
#
# pers_r <- do.call("person", def)
#
#
# utils::personLi
#
#
#
# # Map cff keys to bibtex keys
# # https://www.openoffice.org/bibliographic/bibtex-defs.html
#
#
#
#
#
# # x <- "Article"
# # # https://www.bibtex.com/format/entries/
# # # https://www.openoffice.org/bibliographic/bibtex-defs.html
# # # https://github.com/wch/r-source/blob/79298c499218846d14500255efd622b5021c10ec/src/library/tools/R/citation.R#L67-L82
# # bibtex_required <- switch(x,
# #   Article = c("author", "title", "journal", "year"),
# #   Book = c("author|editor", "title", "publisher", "year"),
# #   Booklet = c("title"),
# #   Conference = c("author", "title", "booktitle", "year"),
# #   InBook =
# #     c("author|editor", "title", "chapter|pages", "publisher", "year"),
# #   InCollection =
# #     c("author", "title", "booktitle", "publisher", "year"),
# #   InProceedings = c("author", "title", "booktitle", "year"),
# #   Manual = c("title"),
# #   MastersThesis = c("author", "title", "school", "year"),
# #   Misc = character(),
# #   PhdThesis = c("author", "title", "school", "year"),
# #   Proceedings = c("title", "year"),
# #   TechReport = c("author", "title", "institution", "year"),
# #   Unpublished = c("author", "title", "note")
# # )
# #
# # cff_ref_to:bibtex <- function(x) {
# #   x_end <- switch (x,
# #     case = action
# #   )
# #
# # }
# #
# # bibtex_required
# #
#
#
# switch (x,
#   case = action
# )
#
#
# cff_schema_definitions_refs
# bibtex_entries <- function() {
#   bibtex <- c(
#     "address",
#     "annote",
#     "author",
#     "booktitle",
#     "chapter",
#     "crossref",
#     "edition",
#     "editor",
#     "howpublished",
#     "institution",
#     "journal",
#     "key",
#     "month",
#     "note",
#     "number",
#     "organization",
#     "pages",
#     "publisher",
#     "school",
#     "series",
#     "title",
#     "type",
#     "volume",
#     "year"
#   )
#
#
# }
