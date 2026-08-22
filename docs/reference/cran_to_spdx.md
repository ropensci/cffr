# Mapping between `License` fields and SPDX

A dataset containing the mapping between the `License` strings observed
in CRAN packages and their approximate match in the [SPDX License
List](https://spdx.org/licenses/).

## Format

A data frame with 86 rows and two variables:

- `LICENSE`:

  A valid `License` string on CRAN.

- `SPDX`:

  A valid SPDX license identifier.

## Source

<https://spdx.org/licenses/>.

## See also

*Writing R Extensions*, [Licensing
section](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Licensing).

## Examples

``` r
data("cran_to_spdx")

head(cran_to_spdx, 20)
#>                       LICENSE              SPDX
#> 1                        AGPL     AGPL-1.0-only
#> 2                 AGPL (>= 3) AGPL-3.0-or-later
#> 3               AGPL (>= 3.0) AGPL-3.0-or-later
#> 4                      AGPL-3     AGPL-3.0-only
#> 5              Apache License        Apache-1.0
#> 6       Apache License (== 2)        Apache-2.0
#> 7     Apache License (== 2.0)        Apache-2.0
#> 8       Apache License (>= 2)        Apache-2.0
#> 9     Apache License (>= 2.0)        Apache-2.0
#> 10         Apache License 2.0        Apache-2.0
#> 11 Apache License Version 2.0        Apache-2.0
#> 12       Artistic License 2.0      Artistic-2.0
#> 13               Artistic-2.0      Artistic-2.0
#> 14       BSD 2-clause License      BSD-2-Clause
#> 15       BSD 3-clause License      BSD-3-Clause
#> 16               BSD_2_clause      BSD-2-Clause
#> 17               BSD_3_clause      BSD-3-Clause
#> 18                        BSL           BSL-1.0
#> 19                    BSL-1.0           BSL-1.0
#> 20                  CC BY 4.0         CC-BY-4.0
```
