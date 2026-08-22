# Test all files

## Session info

<details>

```r
─ Session info ───────────────────────────────────────────
 setting  value
 version  R version 4.3.3 (2024-02-29 ucrt)
 os       Windows 11 x64 (build 22631)
 system   x86_64, mingw32
 ui       RStudio
 language (EN)
 collate  Spanish_Spain.utf8
 ctype    Spanish_Spain.utf8
 tz       Europe/Madrid
 date     2024-03-07
 rstudio  2023.12.1+402 Ocean Storm (desktop)
 pandoc   2.19.2 @ C:\\PROGRA~1\\Pandoc\\pandoc.exe

─ Packages ───────────────────────────────────────────────
 package      * version     date (UTC) lib source
 brio           1.1.4       2023-12-10 [1] CRAN (R 4.3.2)
 cffr         * 0.99.0.9000 2024-03-07 [1] local
 cli            3.6.2       2023-12-11 [1] CRAN (R 4.3.2)
 curl           5.2.1       2024-03-01 [1] CRAN (R 4.3.3)
 desc           1.4.3       2023-12-10 [1] CRAN (R 4.3.2)
 digest         0.6.34      2024-01-11 [1] CRAN (R 4.3.2)
 ellipsis       0.3.2       2021-04-29 [1] CRAN (R 4.3.0)
 fastmap        1.1.1       2023-02-24 [1] CRAN (R 4.3.0)
 htmltools      0.5.7       2023-11-03 [1] CRAN (R 4.3.2)
 httpuv         1.6.14      2024-01-26 [1] CRAN (R 4.3.2)
 jsonlite       1.8.8       2023-12-04 [1] CRAN (R 4.3.2)
 jsonvalidate   1.3.2       2021-11-03 [1] CRAN (R 4.3.0)
 knitr          1.45        2023-10-30 [1] CRAN (R 4.3.2)
 later          1.3.2       2023-12-06 [1] CRAN (R 4.3.2)
 lifecycle      1.0.4       2023-11-07 [1] CRAN (R 4.3.2)
 magrittr       2.0.3       2022-03-30 [1] CRAN (R 4.3.0)
 mime           0.12        2021-09-28 [1] CRAN (R 4.3.0)
 pkgload        1.3.4       2024-01-16 [1] CRAN (R 4.3.2)
 promises       1.2.1       2023-08-10 [1] CRAN (R 4.3.1)
 R6             2.5.1       2021-08-19 [1] CRAN (R 4.3.0)
 Rcpp           1.0.12      2024-01-09 [1] CRAN (R 4.3.2)
 rlang          1.1.3       2024-01-10 [1] CRAN (R 4.3.2)
 rstudioapi     0.15.0      2023-07-07 [1] CRAN (R 4.3.1)
 sessioninfo    1.2.2       2021-12-06 [1] CRAN (R 4.3.0)
 shiny        * 1.8.0       2023-11-17 [1] CRAN (R 4.3.2)
 testthat     * 3.2.1       2023-12-02 [1] CRAN (R 4.3.2)
 V8             4.4.2       2024-02-15 [1] CRAN (R 4.3.2)
 xfun           0.42        2024-02-08 [1] CRAN (R 4.3.2)
 xtable         1.8-4       2019-04-21 [1] CRAN (R 4.3.0)

 [1] C:/Users/diego/AppData/Local/R/win-library/4.3
 [2] C:/Program Files/R/R-4.3.3/library

──────────────────────────────────────────────────────────
```

</details>

## High level summary

- I checked 719 packages
- Invalid cff in 3 packages
- I failed to generate cff in 0 packages
- OK Rate: 99.58%

Packages with errors:


|Package           |Version   |with_citation |is_ok |note |
|:-----------------|:---------|:-------------|:-----|:----|
|ctv               |0.9-5     |TRUE          |FALSE |     |
|opdisDownsampling |0.8.3     |TRUE          |FALSE |     |
|ordinal           |2023.12-4 |TRUE          |FALSE |     |

## cff errors reported
- [ctv](#ctv)
- [opdisDownsampling](#opdisdownsampling)
- [ordinal](#ordinal)

### ctv

#### cff object

<details>

```r
cff-version: 1.2.0
message: 'To cite package "ctv" in publications use:'
type: software
license:
- GPL-2.0-only
- GPL-3.0-only
title: 'ctv: CRAN Task Views'
version: 0.9-5
doi: 10.48550/arXiv.2305.17573
abstract: 'Infrastructure for task views to CRAN-style repositories: Querying task
  views and installing the associated packages (client-side tools), generating HTML
  pages and storing task view information in the repository (server-side tools).'
authors:
- family-names: Zeileis
  given-names: Achim
  email: Achim.Zeileis@R-project.org
  orcid: https://orcid.org/0000-0003-0918-3766
- family-names: Hornik
  given-names: Kurt
  email: Kurt.Hornik@R-project.org
  orcid: https://orcid.org/0000-0003-4198-9911
preferred-citation:
  type: report
  title: 'CRAN Task Views: The Next Generation'
  authors:
  - family-names: Zeileis
    given-names: Achim
    email: Achim.Zeileis@R-project.org
    orcid: https://orcid.org/0000-0003-0918-3766
  - family-names: Bivand
    given-names: Roger
    email: Roger.Bivand@R-project.org
    orcid: https://orcid.org/0000-0003-2392-6140
  - family-names: Eddelbuettel
    given-names: Dirk
    email: Dirk.Eddelbuettel@R-project.org
    orcid: https://orcid.org/000-0001-6419-907X
  - family-names: Hornik
    given-names: Kurt
    email: Kurt.Hornik@R-project.org
    orcid: https://orcid.org/0000-0003-4198-9911
  - family-names: Vialaneix
    given-names: Nathalie
    email: Nathalie.Vialaneix@inrae.fr
    orcid: https://orcid.org/0000-0003-1156-0639
  year: '2023'
  institution:
    name: arXiv.org E-Print Archive
  issue: '2305.17573'
  month: '5'
  doi: 10.48550/arXiv.2305.17573
repository: https://CRAN.R-project.org/package=ctv
repository-code: https://github.com/cran-task-views/ctv/
url: https://ctv.R-Forge.R-project.org/
date-released: '2023-05-30'
contact:
- family-names: Zeileis
  given-names: Achim
  email: Achim.Zeileis@R-project.org
  orcid: https://orcid.org/0000-0003-0918-3766
references:
- type: article
  title: CRAN Task Views
  authors:
  - family-names: Zeileis
    given-names: Achim
    email: Achim.Zeileis@R-project.org
    orcid: https://orcid.org/0000-0003-0918-3766
  journal: R News
  year: '2005'
  volume: '5'
  issue: '1'
  url: https://CRAN.R-project.org/doc/Rnews/
  start: '39'
  end: '40'
```

</details>

#### Validation results


|field                     |message                          |
|:-------------------------|:--------------------------------|
|cff["preferred-citation"] |referenced schema does not match |

### opdisDownsampling

#### cff object

<details>

```r
cff-version: 1.2.0
message: 'To cite package "opdisDownsampling" in publications use:'
type: software
license: GPL-3.0-only
title: 'opdisDownsampling: Optimal Distribution Preserving Down-Sampling of Bio-Medical
  Data'
version: 0.8.3
doi: 10.1371/journal.pone.0255838
abstract: An optimized method for distribution-preserving class-proportional down-sampling
  of bio-medical data.
authors:
- family-names: Lotsch
  given-names: Jorn
  email: j.lotsch@em.uni-frankfurt.de
  orcid: https://orcid.org/0000-0002-5818-6958
- family-names: Malkusch
  given-names: Sebastian
  orcid: https://orcid.org/0000-0001-6766-140x
- family-names: Ultsch
  given-names: Alfred
  orcid: https://orcid.org/0000-0002-7845-3283
preferred-citation:
  type: article
  title: Optimal distribution-preserving downsampling of large biomedical data sets
    (opdisDownsampling)
  authors:
  - family-names: Lötsch
    given-names: Jörn
  - family-names: Malkusch
    given-names: Sebastian
    orcid: https://orcid.org/0000-0001-6766-140x
  - family-names: Ultsch
    given-names: Alfred
    orcid: https://orcid.org/0000-0002-7845-3283
  journal: PLoS One
  volume: '16'
  issue: '9'
  year: '2021'
  issn: 2352-9148
  doi: 10.1371/journal.pone.0255838
  url: https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0255838
  start: e0255838
repository: https://CRAN.R-project.org/package=opdisDownsampling
url: https://cran.r-project.org/package=opdisDownsampling
date-released: '2023-12-13'
contact:
- family-names: Lotsch
  given-names: Jorn
  email: j.lotsch@em.uni-frankfurt.de
  orcid: https://orcid.org/0000-0002-5818-6958
```

</details>

#### Validation results


|field                     |message                          |
|:-------------------------|:--------------------------------|
|cff.authors.1             |no schemas match                 |
|cff["preferred-citation"] |referenced schema does not match |

### ordinal

#### cff object

<details>

```r
cff-version: 1.2.0
message: 'To cite package "ordinal" in publications use:'
type: software
license: GPL-2.0-or-later
title: 'ordinal: Regression Models for Ordinal Data'
version: 2023.12-4
abstract: Implementation of cumulative link (mixed) models also known as ordered regression
  models, proportional odds models, proportional hazards models for grouped survival
  times and ordered logit/probit/... models. Estimation is via maximum likelihood
  and mixed models are fitted with the Laplace approximation and adaptive Gauss-Hermite
  quadrature. Multiple random effect terms are allowed and they may be nested, crossed
  or partially nested/crossed. Restrictions of symmetry and equidistance can be imposed
  on the thresholds (cut-points/intercepts). Standard model methods are available
  (summary, anova, drop-methods, step, confint, predict etc.) in addition to profile
  methods and slice methods for visualizing the likelihood function and checking convergence.
authors:
- family-names: Christensen
  given-names: Rune Haubo Bojesen
  email: rune.haubo@gmail.com
preferred-citation:
  type: manual
  title: ordinal---Regression Models for Ordinal Data
  authors:
  - family-names: Christensen
    given-names: Rune H. B.
    orcid: https://orcid.org/000-0002-4494-3399
  year: '2023'
  notes: R package version 2023.12-4
  url: https://CRAN.R-project.org/package=ordinal
repository: https://CRAN.R-project.org/package=ordinal
repository-code: https://github.com/runehaubo/ordinal
url: https://github.com/runehaubo/ordinal
date-released: '2023-12-04'
contact:
- family-names: Christensen
  given-names: Rune Haubo Bojesen
  email: rune.haubo@gmail.com
```

</details>

#### Validation results


|field                     |message                          |
|:-------------------------|:--------------------------------|
|cff["preferred-citation"] |referenced schema does not match |
