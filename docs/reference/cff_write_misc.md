# Export R objects to multiple file types

Export R objects representing citations to specific file formats:

- `cff_write_bib()` creates a `.bib` file.

- `cff_write_citation()` creates an R citation file as described in
  Section 1.9 of *Writing R Extensions* (R Core Team 2026).

## Usage

``` r
cff_write_bib(
  x,
  file = tempfile(fileext = ".bib"),
  append = FALSE,
  verbose = TRUE,
  ascii = FALSE,
  ...
)

cff_write_citation(
  x,
  file = tempfile("CITATION_"),
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

- ...:

  Arguments passed on to
  [`as_bibentry.cff`](https://docs.ropensci.org/cffr/reference/as_bibentry.md),
  [`as_bibentry.cff_ref`](https://docs.ropensci.org/cffr/reference/as_bibentry.md),
  [`as_bibentry.cff_ref_lst`](https://docs.ropensci.org/cffr/reference/as_bibentry.md)

  `what`

  :   Fields to extract from a full `cff` object. It can be:

      - `preferred`: Create a single entry with the main citation
        information of the package (key `preferred-citation`).

      - `references`: Extract all entries of the `references` key.

      - `all`: Extract both the `preferred-citation` and `references`
        keys.

      See
      [`vignette("r-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/r-cff.md).

## Value

Invisibly returns `NULL`. This function is called for its side effect of
writing a file or displaying its contents.

## Details

When `x` is a `cff` object, it is converted to BibTeX using
[`toBibtex.cff()`](https://docs.ropensci.org/cffr/reference/cff_class.md).

For security reasons, if the file already exists, the function creates a
backup copy in the same directory.

## References

R Core Team (2026). *Writing R Extensions*.
<https://cran.r-project.org/doc/manuals/r-release/R-exts.html>.

## See also

[`vignette("bibtex-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/bibtex-cff.md),
[`knitr::write_bib()`](https://rdrr.io/pkg/knitr/man/write_bib.html) and
the following packages:

- [bibtex](https://CRAN.R-project.org/package=bibtex).

- [RefManageR](https://CRAN.R-project.org/package=RefManageR).

- [rbibutils](https://CRAN.R-project.org/package=rbibutils).

Work with BibTeX metadata:
[`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md),
[`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md),
[`cff_read_bib_text()`](https://docs.ropensci.org/cffr/reference/cff_read_bib_text.md)

Write citation metadata files:
[`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)

## Examples

``` r
bib <- bibentry("Misc",
  title = "My title",
  author = "Fran Pérez"
)

my_temp_bib <- tempfile(fileext = ".bib")

cff_write_bib(bib, file = my_temp_bib)
#> ℹ Writing 4 entries.
#> ✔ Results written to C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd45c4e6078.bib.

cat(readLines(my_temp_bib), sep = "\n")
#> @Misc{,
#>   title = {My title},
#>   author = {Fran Pérez},
#> }

cff_write_bib(bib, file = my_temp_bib, ascii = TRUE, append = TRUE)
#> ℹ Creating a backup of C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd45c4e6078.bib in C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd45c4e6078.bib.bk1.
#> ℹ Writing 4 entries.
#> ✔ Results written to C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd45c4e6078.bib.

cat(readLines(my_temp_bib), sep = "\n")
#> @Misc{,
#>   title = {My title},
#>   author = {Fran Pérez},
#> }
#> @Misc{,
#>   title = {My title},
#>   author = {Fran P{\'e}rez},
#> }
# Create an R citation file.
# Use a system file.
f <- system.file("examples/preferred-citation-book.cff", package = "cffr")
a_cff <- cff_read(f)

out <- file.path(tempdir(), "CITATION")
cff_write_citation(a_cff, file = out)
#> ℹ Writing 1 entry.
#> ✔ Results written to C:\Users\diego\AppData\Local\Temp\RtmpkXftNS/CITATION.

# Check by reading with a meta object.
meta <- packageDescription("cffr")
meta$Encoding <- "UTF-8"

utils::readCitationFile(out, meta)
#> To cite package 'cffr' in publications use:
#> 
#>   Bueler E (2021). _PETSc for Partial Differential Equations: Numerical
#>   Solutions in C and Python_. SIAM Press, Philadelphia. ISBN
#>   978111976304. <https://github.com/bueler/p4pdes>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Book{bueler:2021,
#>     title = {PETSc for Partial Differential Equations: Numerical Solutions in C and Python},
#>     author = {Ed Bueler},
#>     year = {2021},
#>     publisher = {SIAM Press},
#>     address = {Philadelphia},
#>     isbn = {978111976304},
#>     url = {https://github.com/bueler/p4pdes},
#>   }
```
