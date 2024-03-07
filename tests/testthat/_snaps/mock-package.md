# Test in mock package

    Code
      cffobj
    Output
      cff-version: 1.2.0
      message: 'To cite package "manyurls" in publications use:'
      type: software
      license: GPL-3.0-only
      title: 'manyurls: A lot of urls'
      version: 0.1.6
      doi: 10.1111/2041-210X.12469
      abstract: This package has many urls. Specifically, 1 Bug Reports and 6 URLs. Expected
        is to have 1 repository-code, 1 url and 3 URLs, since there is 1 duplicate and 1
        invalid url.
      authors:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com
      preferred-citation:
        type: article
        title: 'RNeXML: A Package for Reading and Writing Richly Annotated Phylogenetic,
          Character, and Trait Data in R'
        authors:
        - family-names: Boettiger
          given-names: Carl
        - family-names: Chamberlain
          given-names: Scott
        - family-names: Vos
          given-names: Rutger
        - family-names: Lapp
          given-names: Hilmar
        journal: Methods in Ecology and Evolution
        year: '2016'
        volume: '7'
        doi: 10.1111/2041-210X.12469
        start: '352'
        end: '357'
      repository-code: https://github.com/test/package
      url: https://test.github.io/package/
      contact:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com
      references:
      - type: book
        title: 'ggplot2: Elegant Graphics for Data Analysis'
        authors:
        - family-names: Wickham
          given-names: Hadley
        publisher:
          name: Springer-Verlag New York
        year: '2016'
        isbn: 978-3-319-24277-4
        url: https://ggplot2.tidyverse.org
      identifiers:
      - type: url
        value: https://r-forge.r-project.org/projects/test/
      - type: url
        value: http://google.ru
      - type: url
        value: https://gitlab.com/r-packages/behaviorchange

---

    Code
      toBibtex(cit)
    Output
      @Article{,
        title = {{RNeXML}: {A} Package for Reading and Writing Richly Annotated Phylogenetic, Character, and Trait Data in {R}},
        journal = {Methods in Ecology and Evolution},
        author = {Carl Boettiger and Scott Chamberlain and Rutger Vos and Hilmar Lapp},
        year = {2016},
        volume = {7},
        pages = {352--357},
        doi = {10.1111/2041-210X.12469},
      }
      
      @Book{,
        author = {Hadley Wickham},
        title = {ggplot2: Elegant Graphics for Data Analysis},
        publisher = {Springer-Verlag New York},
        year = {2016},
        isbn = {978-3-319-24277-4},
        url = {https://ggplot2.tidyverse.org},
      }

---

    Code
      toBibtex(a_bib)
    Output
      @Misc{basic,
        title = {manyurls: A lot of urls},
        author = {Marc Basic},
        url = {https://test.github.io/package/},
        abstract = {This package has many urls. Specifically, 1 Bug Reports and 6 URLs. Expected is to have 1 repository-code, 1 url and 3 URLs, since there is 1 duplicate and 1 invalid url.},
        version = {0.1.6},
      }

