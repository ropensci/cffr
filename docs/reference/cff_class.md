# The `cff` class

[cffr](https://CRAN.R-project.org/package=cffr) implements an S3 object
with [`base::class()`](https://rdrr.io/r/base/class.html) `cff`, which
represents the information in a `CITATION.cff` file in R.

Under the hood, a `cff` object is a named
[`list`](https://rdrr.io/r/base/list.html) with additional methods, most
notably [`print`](https://rdrr.io/r/base/print.html) and
[`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md).

    a_named_list <- list(
      first = "I", second = "am", third = "a", fourth = "list",
      fifth = "with", sixth = "names", "none" = NULL
    )

    # Convert to `cff`.
    a_cff_object <- as_cff(a_named_list)

    class(a_cff_object)
    #> [1] "cff"

    a_cff_object
    #> first: I
    #> second: am
    #> third: a
    #> fourth: list
    #> fifth: with
    #> sixth: names

    is.list(a_cff_object)
    #> [1] TRUE

[`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md)
converts a `list` to `cff` and removes elements that are `NULL` or `NA`.
Named elements are known as keys in CFF terminology.

### Subclasses

[cffr](https://CRAN.R-project.org/package=cffr) implements two special
subclasses of `cff`, which represent two types of objects defined in the
[Citation File Format
schema](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md):

- `definitions.person` and `definitions.entity`: CFF definitions for
  sublists representing persons or entities. In
  [cffr](https://CRAN.R-project.org/package=cffr), the subclass
  `cff_pers_lst` collects an array of `definitions.person` or
  `definitions.entity` objects, where each individual person or entity
  has subclass `cff_pers`.

- `definitions.reference`: The CFF definition for collecting references
  to related works and other software used in the development of the
  main work of the `CITATION.cff` file. In
  [cffr](https://CRAN.R-project.org/package=cffr), the subclass
  `cff_ref_lst` represents arrays of `definitions.reference` objects,
  where each element has subclass `cff_ref`.

These subclasses are not complete, valid `cff` objects. They adapt
information to the structures required by the CFF schema:

    # Use `utils::person()`.

    ## Array.
    two_persons <- as_cff_person(
      c(
        person("A", "person", comment = c(ORCID = "0000-0001-8457-4658")),
        person("An entity", email = "fake@gmail.com")
      )
    )

    two_persons
    #> - family-names: person
    #>   given-names: A
    #>   orcid: https://orcid.org/0000-0001-8457-4658
    #> - name: An entity
    #>   email: fake@gmail.com

    class(two_persons)
    #> [1] "cff_pers_lst" "cff"

    # Single element.

    two_persons[[1]]
    #> family-names: person
    #> given-names: A
    #> orcid: https://orcid.org/0000-0001-8457-4658

    class(two_persons[[1]])
    #> [1] "cff_pers" "cff"

    # Array of references.

    cit <- c(citation(), citation("jsonlite"))

    ref_list <- as_cff(cit)

    ref_list
    #> - type: manual
    #>   title: 'R: A Language and Environment for Statistical Computing'
    #>   authors:
    #>   - name: R Core Team
    #>     website: https://ror.org/02zz1nj61
    #>   institution:
    #>     name: R Foundation for Statistical Computing
    #>     website: https://ror.org/05qewa988
    #>     address: Vienna, Austria
    #>   year: '2026'
    #>   doi: 10.32614/R.manuals
    #>   url: https://www.R-project.org/
    #> - type: article
    #>   title: 'The jsonlite Package: A Practical and Consistent Mapping Between JSON Data
    #>     and R Objects'
    #>   authors:
    #>   - family-names: Ooms
    #>     given-names: Jeroen
    #>   journal: arXiv:1403.2805 [stat.CO]
    #>   year: '2014'
    #>   url: https://arxiv.org/abs/1403.2805

    class(ref_list)
    #> [1] "cff_ref_lst" "cff"

    # Single element.

    ref_list[[1]]
    #> type: manual
    #> title: 'R: A Language and Environment for Statistical Computing'
    #> authors:
    #> - name: R Core Team
    #>   website: https://ror.org/02zz1nj61
    #> institution:
    #>   name: R Foundation for Statistical Computing
    #>   website: https://ror.org/05qewa988
    #>   address: Vienna, Austria
    #> year: '2026'
    #> doi: 10.32614/R.manuals
    #> url: https://www.R-project.org/

    class(ref_list[[1]])
    #> [1] "cff_ref" "cff"

### Valid `cff` objects

Creating a `cff` object does not ensure its validity against the
[Citation File Format
schema](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md):

    class(a_cff_object)
    #> [1] "cff"

    cff_validate(a_cff_object)
    #> == Validating CFF ==============================================================
    #> x Validation failed. This <cff> object has the following errors:
    #> * cff/: must have required property 'authors'
    #> * cff/: must have required property 'cff-version'
    #> * cff/: must have required property 'message'
    #> * cff/: must have required property 'title'
    #> * cff/: must NOT have additional properties
    #> * cff/: must NOT have additional properties
    #> * cff/: must NOT have additional properties
    #> * cff/: must NOT have additional properties
    #> * cff/: must NOT have additional properties
    #> * cff/: must NOT have additional properties

[`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md)
reports validation problems and invisibly returns `TRUE` or `FALSE`.

We can use
[`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md)
to add more keys:

    cff_valid <- cff_modify(a_cff_object,
      authors = as_cff_person("{James and James}"),
      cff_version = "1.2.0",
      message = "Hi there",
      title = "My title"
    )

    # Remove invalid keys.
    cff_valid <- as_cff(cff_valid[names(cff_valid) %in% cff_schema_keys()])

    cff_valid
    #> authors:
    #> - name: James and James
    #> cff-version: 1.2.0
    #> message: Hi there
    #> title: My title

    cff_validate(cff_valid)
    #> == Validating CFF ==============================================================
    #> v This <cff> object is valid.

### Base methods provided by [cffr](https://CRAN.R-project.org/package=cffr)

[cffr](https://CRAN.R-project.org/package=cffr) provides additional S3
methods for common coercion functions from the base and utils
namespaces.

#### [`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html)

    minimal_cff <- cff()

    minimal_cff
    #> cff-version: 1.2.0
    #> message: If you use this software, please cite it using these metadata.
    #> title: My Research Software
    #> authors:
    #> - family-names: Doe
    #>   given-names: John

    as_df <- as.data.frame(minimal_cff)

    class(as_df)
    #> [1] "data.frame"

    t(as_df)
    #>                         [,1]
    #> cff_version             "1.2.0"
    #> message                 "If you use this software, please cite it using these metadata."
    #> title                   "My Research Software"
    #> authors.00.family_names "Doe"
    #> authors.00.given_names  "John"

#### [`c()`](https://rdrr.io/r/base/c.html)

    new_keys <- c("date-released" = "2020-01-31", abstract = "Minimal example")

    c(minimal_cff, new_keys)
    #> cff-version: 1.2.0
    #> message: If you use this software, please cite it using these metadata.
    #> title: My Research Software
    #> authors:
    #> - family-names: Doe
    #>   given-names: John
    #> date-released: '2020-01-31'
    #> abstract: Minimal example

#### [`as.list()`](https://rdrr.io/r/base/list.html)

    as.list(minimal_cff)
    #> $`cff-version`
    #> [1] "1.2.0"
    #>
    #> $message
    #> [1] "If you use this software, please cite it using these metadata."
    #>
    #> $title
    #> [1] "My Research Software"
    #>
    #> $authors
    #> $authors[[1]]
    #> $authors[[1]]$`family-names`
    #> [1] "Doe"
    #>
    #> $authors[[1]]$`given-names`
    #> [1] "John"

#### [`as.person()`](https://rdrr.io/r/utils/person.html)

Only for `cff_pers_lst` and `cff_pers` objects:

    as.person(two_persons)
    #> [1] "A person (ORCID: <https://orcid.org/0000-0001-8457-4658>)"
    #> [2] "An entity <fake@gmail.com>"

#### [`toBibtex()`](https://rdrr.io/r/utils/toLatex.html)

    # For `cff`.
    toBibtex(minimal_cff)
    #> @Misc{doe,
    #>   title = {My Research Software},
    #>   author = {John Doe},
    #> }

    # For `cff_ref` and `cff_ref_lst`.
    toBibtex(cit)
    #> @Manual{,
    #>   title = {R: A Language and Environment for Statistical Computing},
    #>   author = {{R Core Team}},
    #>   organization = {R Foundation for Statistical Computing},
    #>   address = {Vienna, Austria},
    #>   year = {2026},
    #>   doi = {10.32614/R.manuals},
    #>   url = {https://www.R-project.org/},
    #> }
    #>
    #> @Article{,
    #>   title = {The jsonlite Package: A Practical and Consistent Mapping Between JSON Data and R Objects},
    #>   author = {Jeroen Ooms},
    #>   journal = {arXiv:1403.2805 [stat.CO]},
    #>   year = {2014},
    #>   url = {https://arxiv.org/abs/1403.2805},
    #> }

    # For `cff_pers` and `cff_pers_lst`.
    toBibtex(two_persons)
    #> person, A and {An entity}

## References

Wickham H (2019). "S3." In *Advanced R*, 2nd edition. Chapman and
Hall/CRC.
[doi:10.1201/9781351201315](https://doi.org/10.1201/9781351201315) .
<https://adv-r.hadley.nz/s3.html>.

## See also

Convert between R classes:
[`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md),
[`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md),
[`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
