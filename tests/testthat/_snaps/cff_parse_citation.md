# Test full with CITATION and (option = author)

    cff-version: 1.2.0
    message: 'To cite package "rgeos" in publications use:'
    type: software
    license: GPL-2.0-or-later
    title: 'rgeos: Interface to Geometry Engine - Open Source (''GEOS'')'
    version: 0.5-7
    abstract: 'Interface to Geometry Engine - Open Source (''GEOS'') using the C ''API''
      for topology operations on geometries. Please note that ''rgeos'' will be retired
      by the end of 2023, plan transition to sf functions using ''GEOS'' at your earliest
      convenience. The ''GEOS'' library is external to the package, and, when installing
      the package from source, must be correctly installed first. Windows and Mac Intel
      OS X binaries are provided on ''CRAN''. (''rgeos'' >= 0.5-1): Up to and including
      ''GEOS'' 3.7.1, topological operations succeeded with some invalid geometries for
      which the same operations fail from and including ''GEOS'' 3.7.2. The ''checkValidity=''
      argument defaults and structure have been changed, from default FALSE to integer
      default ''0L'' for ''GEOS'' < 3.7.2 (no check), ''1L'' ''GEOS'' >= 3.7.2 (check
      and warn). A value of ''2L'' is also provided that may be used, assigned globally
      using ''set_RGEOS_CheckValidity(2L)'', or locally using the ''checkValidity=2L''
      argument, to attempt zero-width buffer repair if invalid geometries are found. The
      previous default (FALSE, now ''0L'') is fastest and used for ''GEOS'' < 3.7.2, but
      will not warn users of possible problems before the failure of topological operations
      that previously succeeded. From ''GEOS'' 3.8.0, repair of geometries may also be
      attempted using ''gMakeValid()'', which may, however, return a collection of geometries
      of different types.'
    authors:
    - family-names: Bivand
      given-names: Roger
      email: Roger.Bivand@nhh.no
      orcid: https://orcid.org/0000-0003-2392-6140
    - family-names: Rundel
      given-names: Colin
    repository: https://CRAN.R-project.org/package=rgeos
    repository-code: https://r-forge.r-project.org/projects/rgeos/
    url: https://trac.osgeo.org/geos/
    date-released: '2020-09-07'
    contact:
    - family-names: Bivand
      given-names: Roger
      email: Roger.Bivand@nhh.no
      orcid: https://orcid.org/0000-0003-2392-6140
    references:
    - type: manual
      title: 'rgeos: Interface to Geometry Engine - Open Source (''GEOS'')'
      authors:
      - family-names: Bivand
        given-names: Roger
        email: Roger.Bivand@nhh.no
        orcid: https://orcid.org/0000-0003-2392-6140
      - family-names: Rundel
        given-names: Colin
      year: '2020'
      notes: R package version 0.5-7
      url: https://CRAN.R-project.org/package=rgeos
    - type: article
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
      value: http://rgeos.r-forge.r-project.org/index.html

# Parsed several citations

    - type: manual
      title: 'rgeos: Interface to Geometry Engine - Open Source (''GEOS'')'
      authors:
      - family-names: Bivand
        given-names: Roger
        email: Roger.Bivand@nhh.no
        orcid: https://orcid.org/0000-0003-2392-6140
      - family-names: Rundel
        given-names: Colin
      year: '2020'
      notes: R package version 0.5-7
      url: https://CRAN.R-project.org/package=rgeos
    - type: article
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

# Add wrong field to citation

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: My Research Software
    authors:
    - family-names: Doe
      given-names: John
    references:
    - type: manual
      title: favoritefood is not valid on cff schema
      authors:
      - family-names: Smith
        given-names: Jane

# Fix wrong orcid

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: My Research Software
    authors:
    - family-names: Doe
      given-names: John
    references:
    - type: manual
      title: Wrong orcid fixed by cffr
      authors:
      - family-names: Smith
        given-names: Jane
        orcid: https://orcid.org/0000-0000-0000-306X

# Several identifiers and duplicates

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: My Research Software
    authors:
    - family-names: Doe
      given-names: John
    references:
    - type: manual
      title: A Language and Environment for Statistical Computing
      authors:
      - name: R Core Team
      year: '2022'
      url: https://www.R-project.org/
      doi: 10.5281/zenodo.5366600
      identifiers:
      - type: doi
        value: 10.5281/zenodo.5366601
      - type: doi
        value: 10.5281/zenodo.5366602
      - type: url
        value: https://google.com/

# Test keywords and urls

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: My Research Software
    authors:
    - family-names: Doe
      given-names: John
    references:
    - type: manual
      title: A Language and Environment for Statistical Computing
      authors:
      - name: R Core Team
      year: '2022'
      url: https://www.R-project.org/
      keywords:
      - Some
      - random keywords
      - in
      - here
      identifiers:
      - type: url
        value: https://google.com/

# Parse persons on CITATION

    type: manual
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    contact:
    - family-names: name
      given-names: A
    - family-names: contact
      given-names: A
    conference:
      name: A conference
    database-provider:
      name: Database provider
    editors:
    - family-names: editor
      given-names: A
    - name: Ben and Jerry
    editors-series:
    - family-names: editor series
      given-names: An
    - name: Another
    publisher:
      name: A publisher
      address: A location
    recipients:
    - family-names: recipient
      given-names: A
    senders:
    - name: A Sender
    - family-names: Sender
      given-names: Another
    translators:
    - family-names: one
      given-names: Translator
    - family-names: two
      given-names: Translator

# Test inputs

    type: book
    title: Test
    authors:
    - family-names: Jean
      given-names: Billy
    year: '2021'
    publisher:
      name: Random House

