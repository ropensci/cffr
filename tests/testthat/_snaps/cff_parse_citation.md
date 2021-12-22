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
    preferred-citation:
      type: manual
      title: 'rgeos: Interface to Geometry Engine - Open Source (''GEOS'')'
      authors:
      - family-names: Bivand
        given-names: Roger
        email: Roger.Bivand@nhh.no
        orcid: https://orcid.org/0000-0003-2392-6140
      - family-names: Rundel
        given-names: Colin
      version: 0.5-7
      abstract: 'Interface to Geometry Engine - Open Source (''GEOS'') using the C ''API''
        for topology operations on geometries. Please note that ''rgeos'' will be retired
        by the end of 2023, plan transition to sf functions using ''GEOS'' at your earliest
        convenience. The ''GEOS'' library is external to the package, and, when installing
        the package from source, must be correctly installed first. Windows and Mac Intel
        OS X binaries are provided on ''CRAN''. (''rgeos'' >= 0.5-1): Up to and including
        ''GEOS'' 3.7.1, topological operations succeeded with some invalid geometries
        for which the same operations fail from and including ''GEOS'' 3.7.2. The ''checkValidity=''
        argument defaults and structure have been changed, from default FALSE to integer
        default ''0L'' for ''GEOS'' < 3.7.2 (no check), ''1L'' ''GEOS'' >= 3.7.2 (check
        and warn). A value of ''2L'' is also provided that may be used, assigned globally
        using ''set_RGEOS_CheckValidity(2L)'', or locally using the ''checkValidity=2L''
        argument, to attempt zero-width buffer repair if invalid geometries are found.
        The previous default (FALSE, now ''0L'') is fastest and used for ''GEOS'' < 3.7.2,
        but will not warn users of possible problems before the failure of topological
        operations that previously succeeded. From ''GEOS'' 3.8.0, repair of geometries
        may also be attempted using ''gMakeValid()'', which may, however, return a collection
        of geometries of different types.'
      repository: https://CRAN.R-project.org/package=rgeos
      repository-code: https://r-forge.r-project.org/projects/rgeos/
      url: https://trac.osgeo.org/geos/
      identifiers:
      - type: url
        value: http://rgeos.r-forge.r-project.org/index.html
      date-released: '2020-09-07'
      contact:
      - family-names: Bivand
        given-names: Roger
        email: Roger.Bivand@nhh.no
        orcid: https://orcid.org/0000-0003-2392-6140
      license: GPL-2.0-or-later
      year: '2020'
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
      journal: Methods in Ecology and Evolution
      authors:
      - family-names: Boettiger
        given-names: Carl
      - family-names: Chamberlain
        given-names: Scott
      - family-names: Vos
        given-names: Rutger
      - family-names: Lapp
        given-names: Hilmar
      year: '2016'
      volume: '7'
      pages: 352--357
      doi: 10.1111/2041-210X.12469
    - type: book
      authors:
      - family-names: Wickham
        given-names: Hadley
      title: 'ggplot2: Elegant Graphics for Data Analysis'
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
      journal: Methods in Ecology and Evolution
      authors:
      - family-names: Boettiger
        given-names: Carl
      - family-names: Chamberlain
        given-names: Scott
      - family-names: Vos
        given-names: Rutger
      - family-names: Lapp
        given-names: Hilmar
      year: '2016'
      volume: '7'
      pages: 352--357
      doi: 10.1111/2041-210X.12469
    - type: book
      authors:
      - family-names: Wickham
        given-names: Hadley
      title: 'ggplot2: Elegant Graphics for Data Analysis'
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
    preferred-citation:
      type: manual
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      year: '2021'
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
    preferred-citation:
      type: manual
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      year: '2021'
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
    preferred-citation:
      type: manual
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      year: '2021'
    references:
    - type: manual
      title: A Language and Environment for Statistical Computing
      year: '2022'
      authors:
      - name: R Core Team
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
    preferred-citation:
      type: manual
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      year: '2021'
    references:
    - type: manual
      title: A Language and Environment for Statistical Computing
      year: '2022'
      authors:
      - name: R Core Team
      url: https://www.R-project.org/
      keywords:
      - Some
      - random keywords
      - in
      - here
      identifiers:
      - type: url
        value: https://google.com/

# Article

    type: article
    authors:
    - name: R Core Team
    title: A Language and Environment for Statistical Computing
    journal: JOSS
    year: '2021'
    volume: vol1
    number: '3'
    pages: 3--7
    month: '1'
    notes: a note

# Book

    type: book
    authors:
    - name: R Core Team
    editors:
    - name: Barnes and Noble
    title: A Language and Environment for Statistical Computing
    publisher:
      name: Graham and Hill
    year: '2021'
    month: '8'
    section: A chapter

# Booklet

    type: pamphlet
    title: Handbook of algorithms and data structures
    authors:
    - family-names: Gonnet
      given-names: G. H.
    - family-names: Baeza-Yates
      given-names: R.
    medium: booklet
    month: '4'
    year: '1991'
    notes: A note
    location:
      name: Barcelona, ES

# InBook

    type: book
    authors:
    - name: R Core Team
    editors:
    - name: McGraw Hill
    title: A Language and Environment for Statistical Computing
    section: A chapter A chapter
    pages: 3--7
    publisher:
      name: Graham Hill
      address: Barcelona, ES
    year: '2021'
    volume: vol1
    number: '3'
    edition: Second
    month: '1'
    notes: a note
    collection-title: The R series

# InCollection

    type: generic
    authors:
    - name: R Core Team
    title: A Language and Environment for Statistical Computing
    collection-title: A book
    publisher:
      name: Graham Hill
      address: Madrid, ES
    year: '2021'
    editors:
    - name: McGraw Hill
    volume: vol1
    number: '3'
    section: Some type A chapter
    pages: '123'
    edition: Third
    month: '8'
    notes: A note

# InProceedings

    type: conference-paper
    authors:
    - name: R Core Team
    title: A Language and Environment for Statistical Computing
    collection-title: A book
    year: '2021'
    editors:
    - name: McGraw Hill
    volume: vol1
    number: '3'
    pages: '123'
    publisher:
      name: Graham Hill
      address: Madrid, ES
    notes: A note
    institution:
      name: An org
    conference:
      name: A book
      address: Madrid, ES
    location:
      name: Madrid, ES

# Manual

    type: manual
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    edition: Fourth
    month: '8'
    year: '2021'
    notes: A note
    institution:
      name: An org
    location:
      name: Leganes, ES

# MastersThesis

    type: thesis
    authors:
    - name: R Core Team
    title: A Language and Environment for Statistical Computing
    department: Trinity College
    year: '2021'
    month: '8'
    notes: A note
    thesis-type: Master's Thesis
    location:
      name: Leganes, Madrid

# Misc

    type: generic
    authors:
    - name: R Core Team
    title: A Language and Environment for Statistical Computing
    medium: CD-ROM
    month: '1'
    year: '2021'
    notes: A note

# PhdThesis

    type: thesis
    authors:
    - name: R Core Team
    title: A Language and Environment for Statistical Computing
    department: Trinity College
    year: '2021'
    month: '8'
    notes: A note
    thesis-type: PhD Thesis
    location:
      name: Leganes, Madrid

# Proceedings

    type: proceedings
    title: A Language and Environment for Statistical Computing
    year: '2021'
    editors:
    - name: Aaronson
    volume: '1'
    number: '3'
    month: '8'
    publisher:
      name: Publishing Co.
      address: Some address, FR
    notes: A note
    authors:
    - name: Aaronson
      alias: BibTeX key from editor

# TechReport

    type: report
    authors:
    - name: R Core Team
    title: A Language and Environment for Statistical Computing
    institution:
      name: MIT
      address: An address, FR
    year: '2021'
    number: '900'
    month: '8'
    notes: Some note
    section: Some type

# Unpublished

    type: unpublished
    authors:
    - name: R Core Team
    title: A Language and Environment for Statistical Computing
    notes: Preprint
    year: '2021'
    month: '8'

# Parse persons on CITATION

    type: manual
    title: A Language and Environment for Statistical Computing
    year: '2021'
    authors:
    - name: R Core Team
    contact:
    - family-names: name
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
    - family-names: series
      given-names: A
      name-particle: editor
    institution:
      name: A institution
    location:
      name: A location
    publisher:
      name: A publisher
    recipients:
    - family-names: recipient
      given-names: A
    senders:
    - family-names: sender
      given-names: A
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

# Test entry without author

    type: proceedings
    editors:
    - family-names: Berbers
      given-names: Yolande
    - family-names: Zwaenepoel
      given-names: Willy
    title: Proceedings of the 6th European Conference on Computer Systems
    collection-title: Proceedings of the 6th European Conference on Computer Systems
    publisher:
      name: ACM
    month: '4'
    year: '2006'
    isbn: 1-59593-322-02
    authors:
    - name: Yolande Berbers and Willy Zwaenepoel
      alias: BibTeX key from editor

# Test entry without author but has a key

    type: generic
    title: Proceedings of the 6th European Conference on Computer Systems
    collection-title: Proceedings of the 6th European Conference on Computer Systems
    publisher:
      name: ACM
    month: '4'
    year: '2006'
    isbn: 1-59593-322-02
    authors:
    - name: I am the key
      alias: BibTeX key

# Skip misc without title

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: My Research Software
    authors:
    - family-names: Doe
      given-names: John
    preferred-citation:
      type: manual
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      year: '2021'

# Skip misc without title, not skipping the good one

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: My Research Software
    authors:
    - family-names: Doe
      given-names: John
    preferred-citation:
      type: manual
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      year: '2021'
    references:
    - type: generic
      title: 'rromeo: An R Client for SHERPA/RoMEO API'
      authors:
      - family-names: Grenié
        given-names: Matthias
      - family-names: Gruson
        given-names: Hugo
      year: '2019'
      url: https://CRAN.R-project.org/package=rromeo

