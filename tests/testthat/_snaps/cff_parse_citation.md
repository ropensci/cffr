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
    title: Bit-Vector Algorithms for Binary Constraint Satisfaction and Subgraph Isomorphism
    authors:
    - family-names: Ullmann
      given-names: Julian R.
    year: '2011'
    month: '2'
    journal: ACM Journal of Experimental Algorithmics
    publisher:
      name: Association for Computing Machinery
      city: New York, NY, USA
    volume: '15'
    number: '1.6'
    pages: 1--64
    doi: 10.1145/1671970.1921702
    issn: 1084-6654
    url: https://doi.org/10.1145/1671970.1921702
    keywords:
    - constraint propagation
    - signature file
    - prematching
    - constraint satisfaction
    - binary constraints
    - graph indexing
    - bit-vector
    - focus search
    - molecule matching
    - subgraph isomorphism
    - AllDifferent constraint
    - backtrack
    - domain reduction
    - forward checking

# Book

    type: book
    title: Gray's anatomy
    authors:
    - family-names: Gray
      given-names: Henry
    - family-names: Williams
      given-names: Peter L.
    - family-names: Warwick
      given-names: Roger
    year: '1973'
    publisher:
      name: Longman London
      city: London, United Kingdom
    pages: xvi, 1471 p.
    isbn: '0443010110'
    edition: 35th ed.; edited by Roger Warwick and Peter L. Williams with the assistance
      of others.

# Booklet

    type: pamphlet
    title: The title of the work
    authors:
    - family-names: Caxton
      given-names: Peter
    medium: How it was published
    month: '7'
    year: '1993'
    notes: An optional note

# Conference

    type: conference-paper
    authors:
    - family-names: Draper
      given-names: Peter
    title: The title of the work
    collection-title: The title of the book
    year: '1993'
    editors:
    - name: The editor
    volume: '4'
    pages: '213'
    month: '7'
    publisher:
      name: The publisher
      city: The address of the publisher
    notes: An optional note
    institution:
      name: The organization
    conference:
      name: The title of the book The address of the publisher
    location:
      name: The address of the publisher

# InBook

    type: book
    authors:
    - family-names: Eston
      given-names: Peter
    title: The title of the work
    section: '8'
    pages: 201-213
    publisher:
      name: The name of the publisher
      city: The address of the publisher
    year: '1993'
    volume: '4'
    edition: '3'
    month: '7'
    notes: An optional note
    collection-title: '5'

# InCollection

    type: generic
    authors:
    - family-names: Farindon
      given-names: Peter
    title: The title of the work
    collection-title: The title of the book
    publisher:
      name: The name of the publisher
      city: The address of the publisher
    year: '1993'
    editors:
    - name: The editor
    volume: '4'
    section: '8'
    pages: 201-213
    edition: '3'
    month: '7'
    notes: An optional note

# InProceedings

    type: conference-paper
    authors:
    - family-names: Holleis
      given-names: Paul
    - family-names: Wagner
      given-names: Matthias
    - family-names: Böhm
      given-names: Sebastian
    - family-names: Koolwaaij
      given-names: Johan
    title: Studying Mobile Context-Aware Social Services in the Wild
    year: '2010'
    isbn: '9781605589343'
    publisher:
      name: Association for Computing Machinery
      city: New York, NY, USA
    url: https://doi.org/10.1145/1868914.1868941
    doi: 10.1145/1868914.1868941
    abstract: We have implemented and evaluated IYOUIT, a context-aware application for
      the mobile phone that promotes a digital lifestyle, sharing, and life-logging approach
      for people on the go. The service incorporates context management technology to
      abstract data about and around the user into meaningful interpretations of the user's
      digital trace in the real world. Complementary to the public release of our service,
      we have conducted a longitudinal field study with 19 users for a period of one month.
      In this paper, we present findings from this coordinated user trial and provide
      researchers with advice on the design and implementation of similar systems.
    collection-title: 'Proceedings of the 6th Nordic Conference on Human-Computer Interaction:
      Extending Boundaries'
    pages: 207–216
    keywords:
    - mobile services
    - context awareness
    - social networking
    location:
      name: New York, NY, USA
    conference:
      name: 'Proceedings of the 6th Nordic Conference on Human-Computer Interaction: Extending
        Boundaries New York, NY, USA'

# Manual

    type: manual
    title: The title of the work
    authors:
    - family-names: Gainsford
      given-names: Peter
    edition: '3'
    month: '7'
    year: '1993'
    notes: An optional note
    institution:
      name: The organization

# MastersThesis

    type: thesis
    authors:
    - family-names: Harwood
      given-names: Peter
    title: The title of the work
    department: The school of the thesis
    year: '1993'
    month: '7'
    notes: An optional note
    thesis-type: Master's Thesis

# Misc

    type: generic
    authors:
    - family-names: Isley
      given-names: Peter
    title: The title of the work
    medium: How it was published
    month: '7'
    year: '1993'
    notes: An optional note

# PhdThesis

    type: thesis
    authors:
    - family-names: Joslin
      given-names: Peter
    title: The title of the work
    department: The school of the thesis
    year: '1993'
    month: '7'
    notes: An optional note
    thesis-type: PhD Thesis

# Proceedings

    type: proceedings
    editors:
    - name: Yolande Berbers and Willy Zwaenepoel
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

# Proceedings with custom key

    type: proceedings
    title: Proceedings of the 6th European Conference on Computer Systems
    collection-title: Proceedings of the 6th European Conference on Computer Systems
    publisher:
      name: ACM
    month: '4'
    year: '2006'
    isbn: 1-59593-322-02
    authors:
    - name: proc
      alias: BibTeX key

# Proceedings with auto key

    type: proceedings
    title: Proceedings of the 6th European Conference on Computer Systems
    collection-title: Proceedings of the 6th European Conference on Computer Systems
    publisher:
      name: ACM
    month: '4'
    year: '2006'
    isbn: 1-59593-322-02
    authors:
    - name: BibTeX key
      alias: BibTeX key

# TechReport

    type: report
    authors:
    - family-names: Lambert
      given-names: Peter
    title: The title of the work
    institution:
      name: The institution that published
    year: '1993'
    number: '2'
    month: '7'
    notes: An optional note

# Unpublished

    type: unpublished
    authors:
    - family-names: Marcheford
      given-names: Peter
    title: The title of the work
    notes: An optional note
    month: '7'
    year: '1993'

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
    - name: A editor
    editors-series:
    - name: A editor series
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

