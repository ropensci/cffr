
#' @noRd
cff_description <- function(desc_path = "DESCRIPTION", cff_version = "1.2.0") {
  pkg <- desc::desc(desc_path)
  pkg$coerce_authors_at_r()


  list_fields <- list(
    "cff-version" = cff_version,
    message = "If you use this software, please cite it using these metadata.",
    type = "software",
    title = parse_desc_title(pkg),
    version = parse_desc_version(pkg),
    authors = parse_desc_authors(pkg),
    abstract = parse_desc_abstract(pkg),
    "repository-code" = parse_desc_urls(pkg)$repo,
    url = parse_desc_urls(pkg)$url,
    "date-released" = parse_desc_date_released(pkg),
    contact = parse_desc_contacts(pkg),
    keywords = unlist(parse_desc_keywords(pkg)),
    license = unlist(parse_desc_license(pkg))
  )

  list_fields <- as.cff(list_fields)
  list_fields
}
