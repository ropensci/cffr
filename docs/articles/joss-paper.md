# cffr: Generate Citation File Format Metadata for R Packages

[![](https://joss.theoj.org/papers/10.21105/joss.03900/status.svg)](https://doi.org/10.21105/joss.03900)

## Summary

The Citation File Format project ([Druskat et al.
2021](#ref-druskat_citation_2021)) defines a standardized format for
providing citation metadata for software or datasets in plain text files
that are easy for both humans and machines to read.

GitHub uses Citation File Format for its built-in citation support
([GitHub 2021](#ref-github_about_citation)). Zenodo and Zotero also
support `CITATION.cff` files ([Druskat
2021](#ref-druskat_stephan_making_2021)).

**cffr** provides utilities to generate and validate `CITATION.cff`
files for **R** ([R Core Team 2026](#ref-R_2021)) packages by parsing
the `DESCRIPTION` file and the optional `inst/CITATION` file. The
package also includes utilities and examples for parsing components such
as person and reference metadata, plus vignettes that illustrate basic
package usage and technical details about the metadata extraction
process.

## Statement of need

Research software is often omitted from citations ([Salmon et al.
2021](#ref-salmon2021)). One reason software is not cited is the lack of
clear citation information from package developers.

Some of the main reasons for citing software used in research are:

1.  **Reproducibility:** Software and its versions are important
    information to include in any research project. They help peers
    understand and reproduce the results of a study effectively.
    Including versions is also crucial for recording the context of a
    manuscript when software changes.
2.  **Developer credit:** In the context of free and open source
    software (FOSS), many software developers are also researchers.
    Receiving credit for software development should be no different
    from the credit received in other formats, such as books or
    articles.

`CITATION.cff` files provide clear citation rules for software. The
format is human-readable and can also be parsed by appropriate software.
GitHub’s adoption of this format sends a strong message that research
software is worthy of citation and therefore deserves credit.

**cffr** allows **R** package developers to create `CITATION.cff` files
from metadata already included in the package. It also includes
validation tools from the **jsonvalidate** package ([FitzJohn et al.
2025](#ref-jsonvalidate2021)), which allows developers to assess the
validity of the file against the Citation File Format schema.

## Acknowledgements

I would like to thank [Carl
Boettiger](https://ropensci.org/author/carl-boettiger/), [Maëlle
Salmon](https://ropensci.org/author/ma%C3%ABlle-salmon/) and the [rest
of the
contributors](https://github.com/ropensci/codemetar/graphs/contributors)
of the **codemetar** package ([Boettiger and Salmon
2026](#ref-codemetar2021)). This package was the primary inspiration for
developing **cffr** and shares a common goal of increasing awareness of
the efforts of software developers.

I would also like to thank [João Martins](https://zambujo.github.io/)
and [Scott Chamberlain](https://ropensci.org/author/scott-chamberlain/)
for thorough reviews that helped improve the package and documentation
and [Emily Riederer](https://emilyriederer.netlify.app/) for handling
the [review
process](https://github.com/ropensci/software-review/issues/463).

## Citation

Hernangómez D (2021). “cffr: Generate Citation File Format Metadata for
R Packages.” *Journal of Open Source Software*, 6(67), 3900.
<https://doi.org/10.21105/joss.03900>

``` bibtex
@article{hernangomez2021,
  doi = {10.21105/joss.03900},
  url = {https://doi.org/10.21105/joss.03900},
  year = {2021},
  publisher = {The Open Journal},
  volume = {6},
  number = {67},
  pages = {3900},
  author = {Diego Hernangómez},
  title = {cffr: Generate Citation File Format Metadata for R Packages},
  journal = {Journal of Open Source Software}
}
```

## References

Boettiger, Carl, and Maëlle Salmon. 2026. *codemetar: Generate
’CodeMeta’ Metadata for R Packages*.
<https://doi.org/10.32614/CRAN.package.codemetar>.

Druskat, Stephan. 2021. *Making Software Citation Easi(er) - The
Citation File Format and Its Integrations*. Version 1. Zenodo.
<https://doi.org/10.5281/zenodo.5529914>.

Druskat, Stephan, Jurriaan H. Spaaks, Neil Chue Hong, et al. 2021.
*Citation File Format*. Version 1.2.0. Zenodo.
<https://doi.org/10.5281/zenodo.5171937>.

FitzJohn, Rich, Rob Ashton, Mathias Buus, and Evgeny Poberezkin. 2025.
*jsonvalidate: Validate ’JSON’ Schema*.
<https://doi.org/10.32614/CRAN.package.jsonvalidate>.

GitHub. 2021. *About CITATION
Files*.[https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files%0A%09)
.

R Core Team. 2026. *R: A Language and Environment for Statistical
Computing*. R Foundation for Statistical Computing.
<https://doi.org/10.32614/R.manuals>.

Salmon, Maëlle, Scott Chamberlain, and Karthik Ram. 2021. *Make Your R
Package Easier to Cite*. rOpenSci.
<https://doi.org/10.59350/yf89v-g8d70>.
