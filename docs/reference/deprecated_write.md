# Previous API: write files

**\[deprecated\]** Use
[`cff_write_bib()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)
or
[`cff_write_citation()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md).

## Usage

``` r
write_bib(x, file = tempfile(), append = FALSE, verbose = TRUE, ascii = FALSE)

write_citation(
  x,
  file = "./inst/CITATION",
  append = FALSE,
  verbose = TRUE,
  ...
)
```

## Arguments

- x:

  A [`bibentry`](https://rdrr.io/r/utils/bibentry.html) or a
  [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object.

- file:

  Name of the file to be created. If `NULL`, the lines are displayed
  instead.

- append:

  A logical value. If `TRUE`, append entries to an existing file.

- verbose:

  A logical value. If `TRUE`, display informative messages.

- ascii:

  A logical value. If `TRUE`, write entries using ASCII characters only.

## Value

Writes a file.

## See also

- [`cff_write_bib()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)
  for writing `*.bib` files.

- [`cff_write_citation()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)
  for writing R `CITATION` files.

Deprecated functions:
[`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md),
[`cff_from_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_from_bib.md),
[`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md),
[`cff_parse_person()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md)

## Examples

``` r
bib <- bibentry("Misc",
  title = "My title",
  author = "Fran Pérez"
)

my_temp_bib <- tempfile(fileext = ".bib")

cff_write_bib(bib, file = my_temp_bib)
#> ℹ Writing 4 entries.
#> ✔ Results written to C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd441034264.bib.

cat(readLines(my_temp_bib), sep = "\n")
#> @Misc{,
#>   title = {My title},
#>   author = {Fran Pérez},
#> }

cff_write_bib(bib, file = my_temp_bib, ascii = TRUE, append = TRUE)
#> ℹ Creating a backup of C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd441034264.bib in C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd441034264.bib.bk1.
#> ℹ Writing 4 entries.
#> ✔ Results written to C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd441034264.bib.

cat(readLines(my_temp_bib), sep = "\n")
#> @Misc{,
#>   title = {My title},
#>   author = {Fran Pérez},
#> }
#> @Misc{,
#>   title = {My title},
#>   author = {Fran P{\'e}rez},
#> }
```
