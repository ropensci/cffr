# Test full with CITATION and (option = author)

    Code
      cffobj
    Output
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

    Code
      citobj
    Output
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

    Code
      cffobj
    Output
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

    Code
      cffobj
    Output
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

    Code
      cffobj
    Output
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

    Code
      cffobj
    Output
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

    Code
      bibparsed
    Output
      - type: manual
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
          address: A location
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

    Code
      bibparsed
    Output
      - type: book
        title: Test
        authors:
        - family-names: Jean
          given-names: Billy
        year: '2021'
        publisher:
          name: Random House

# Article

    Code
      bibparsed
    Output
      - type: article
        title: Literate Programming
        authors:
        - name: R Core Team
        journal: The Computer Journal
        year: '1984'
        volume: '27'
        issue: '2'
        month: '1'
        notes: Example modified for testing purposes
        start: '97'
        end: '111'

# Book

    Code
      bibparsed
    Output
      - type: book
        title: The LaTeX Companion
        authors:
        - family-names: Mittelbach
          given-names: Frank
        - family-names: Gossens
          given-names: Michel
        - family-names: Braams
          given-names: Johannes
        - family-names: Carlisle
          given-names: David
        - family-names: Rowley
          given-names: Chris
        editors:
        - name: Barnes and Noble
        publisher:
          name: Addison-Wesley Professional
          address: Santa Monica
        year: '2004'
        volume: '3'
        issue: '7'
        collection-title: The LateX Books
        collection-type: book
        edition: Fourth
        month: '8'
        notes: Example modified for testing purposes
        keywords:
        - Two
        - keyword

# Booklet

    Code
      bibparsed
    Output
      - type: pamphlet
        title: Java Booklet
        authors:
        - family-names: Mustermann
          given-names: Max
        medium: Internet
        location:
          name: Stuttgart
        month: '2'
        year: '2016'
        notes: Example modified from Jabref

# Conference

    Code
      bibparsed
    Output
      - type: conference-paper
        title: On Notions of Information Transfer in VLSI Circuits
        authors:
        - family-names: Oaho
          given-names: Alfred V.
        - family-names: Ullman
          given-names: Jeffrey D.
        - family-names: Yannakakis
          given-names: Mihalis
        collection-title: Proc. Fifteenth Annual ACM STOC
        collection-type: conference
        year: '1983'
        editors:
        - family-names: Oz
          given-names: Wizard V.
        - family-names: Yannakakis
          given-names: Mihalis
        volume: '41'
        issue: '17'
        institution:
          name: ACM
        publisher:
          name: Academic Press
        notes: Example modified for testing purposes
        start: '133'
        end: '139'
        conference:
          name: Proc. Fifteenth Annual ACM STOC
          address: Boston

# InBook

    Code
      bibparsed
    Output
      - type: book
        title: A Framework for Freeness Analysis
        authors:
        - family-names: King
          given-names: A.
        editors:
        - family-names: Tick
          given-names: E
        - family-names: Succi
          given-names: G
        section: 7, 14
        publisher:
          name: Kluwer Academic Publishers
          address: Dordrecht
        year: '1994'
        volume: '27'
        issue: '2'
        collection-title: Implementations of Logic Programming Systems
        collection-type: book
        edition: Second
        month: '1'
        notes: Example modified for testing purposes
        start: '137'
        end: '149'

# InCollection

    Code
      bibparsed
    Output
      - type: generic
        title: Knowledge-Based Methods for WSD
        authors:
        - family-names: Mihalcea
          given-names: Rada
        collection-title: 'Word Sense Disambiguation: Algorithms and Applications'
        collection-type: collection
        publisher:
          name: Springer
          address: 107--132
        year: '2006'
        editors:
        - family-names: Agirre
          given-names: Eneko
        - family-names: Edmonds
          given-names: Philip
        volume: '23'
        issue: '3'
        section: '1,2,3'
        edition: Third
        month: '8'
        notes: A note
        start: '24'
        end: '57'

# InProceedings

    Code
      bibparsed
    Output
      - type: conference-paper
        title: On Notions of Information Transfer in VLSI Circuits
        authors:
        - family-names: Oaho
          given-names: Alfred V.
        - family-names: Ullman
          given-names: Jeffrey D.
        - family-names: Yannakakis
          given-names: Mihalis
        collection-title: Proc. Fifteenth Annual ACM STOC
        collection-type: proceedings
        year: '1983'
        editors:
        - family-names: Oz
          given-names: Wizard V.
        - family-names: Yannakakis
          given-names: Mihalis
        volume: '41'
        issue: '17'
        institution:
          name: ACM
        publisher:
          name: Academic Press
        notes: Example modified for testing purposes
        start: '133'
        end: '139'
        conference:
          name: Proc. Fifteenth Annual ACM STOC
          address: Boston

# Manual

    Code
      bibparsed
    Output
      - type: manual
        title: A Language and Environment for Statistical Computing
        authors:
        - name: R Core Team
        institution:
          name: R Foundation for Statistical Computing
          address: Vienna, Austria
        edition: Fourth
        month: '8'
        year: '2021'
        notes: Example modified for testing purposes

# MastersThesis

    Code
      bibparsed
    Output
      - type: thesis
        title: An examination of keystroke dynamics for continuous user authentication
        authors:
        - family-names: Alsolami
          given-names: Eesa
        institution:
          name: Queensland University of Technology
          address: Queensland, NZ
        year: '2012'
        month: '8'
        notes: Example modified for testing purposes
        thesis-type: Master's Thesis

# Misc

    Code
      bibparsed
    Output
      - type: generic
        title: A Language and Environment for Statistical Computing
        authors:
        - name: R Core Team
        medium: CD-ROM
        month: '1'
        year: '2021'
        notes: A note

# PhdThesis

    Code
      bibparsed
    Output
      - type: thesis
        title: An examination of keystroke dynamics for continuous user authentication
        authors:
        - family-names: Alsolami
          given-names: Eesa
        institution:
          name: Queensland University of Technology
          address: Queensland, NZ
        year: '2012'
        month: '8'
        notes: Example modified for testing purposes
        thesis-type: PhD Thesis

# Proceedings

    Code
      bibparsed
    Output
      - type: proceedings
        title: Proc. Fifteenth Annual STOC
        authors:
        - name: anonymous
        year: '1983'
        editors:
        - family-names: Oz
          given-names: Wizard V.
        - family-names: Yannakakis
          given-names: Mihalis
        volume: '1'
        issue: '17'
        collection-title: All ACM Conferences
        collection-type: proceedings
        month: '8'
        institution:
          name: The OX Association for Computing Machinery
        publisher:
          name: Academic Press
        notes: Example modified for testing purposes
        conference:
          name: All ACM Conferences
          address: Boston, US

# TechReport

    Code
      bibparsed
    Output
      - type: report
        title: Naive tools for studying compilation histories
        authors:
        - family-names: Jadud
          given-names: Matthew C.
        - family-names: Fincher
          given-names: Sally A.
        institution:
          name: University of Kent Canterbury
          address: Computing Laboratory, University of Kent, Canterbury, Kent, CT2 7NF
        year: '2003'
        issue: 3-03
        month: '3'
        notes: Example modified for testing purposes

# Unpublished

    Code
      bibparsed
    Output
      - type: unpublished
        title: Demonstratives
        authors:
        - family-names: Kaplan
          given-names: D.
        notes: Unpublished manuscript, UCLA
        year: '1977'
        month: '8'

# InBook with booktitle

    Code
      bibparsed
    Output
      - type: generic
        title: Bibliographies and citations
        authors:
        - family-names: Xie
          given-names: Yihui
        - family-names: Dervieux
          given-names: Christophe
        - family-names: Riederer
          given-names: Emily
        year: '2020'
        collection-title: R Markdown Cookbook
        collection-type: collection
        publisher:
          name: Chapman and Hall/CRC
          address: Boca Raton, Florida
        isbn: '9780367563837'
        url: https://bookdown.org/yihui/rmarkdown-cookbook
        section: '4.5'

# Test entry without author

    Code
      bibparsed
    Output
      - type: proceedings
        title: Proceedings of the 6th European Conference on Computer Systems
        authors:
        - name: anonymous
        editors:
        - family-names: Berbers
          given-names: Yolande
        - family-names: Zwaenepoel
          given-names: Willy
        collection-title: Proceedings of the 6th European Conference on Computer Systems
        collection-type: proceedings
        publisher:
          name: ACM
        month: '4'
        year: '2006'
        isbn: 1-59593-322-02
        conference:
          name: Proceedings of the 6th European Conference on Computer Systems

# Test entry without author but has a key

    Code
      bibparsed
    Output
      - type: generic
        title: Proceedings of the 6th European Conference on Computer Systems
        authors:
        - name: anonymous
        collection-title: Proceedings of the 6th European Conference on Computer Systems
        collection-type: misc
        publisher:
          name: ACM
        month: '4'
        year: '2006'
        isbn: 1-59593-322-02

# Test entry without author and key

    Code
      bibparsed
    Output
      - type: generic
        title: Proceedings of the 6th European Conference on Computer Systems
        authors:
        - name: anonymous
        collection-title: Proceedings of the 6th European Conference on Computer Systems
        collection-type: misc
        publisher:
          name: ACM
        month: '4'
        year: '2006'
        isbn: 1-59593-322-02

# Skip misc without title

    Code
      cffobj
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John

# Skip misc without title, not skipping the good one

    Code
      cffobj
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
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

# Check extended BibLatex Fields

    Code
      bibparsed
    Output
      - type: article
        title: Computation of methodology hyphen independent ionic solvation free energies
          from molecular simulations
        authors:
        - family-names: Kastenholz
          given-names: M. A.
        - family-names: Hünenbergerb
          given-names: Philippe H.
        journal: J. Chem. Phys.
        year: '2006'
        notes: Example modified for testing purposes
        date-published: '2006-03-15'
        filename: a_file.pdf
        issue-title: Semantic 3D Media and Content
        translators:
        - family-names: Wicksteed
          given-names: P. H.
        - family-names: Cornford
          given-names: F. M.
        date-accessed: '2006-10-01'
        pages: '528'
        abstract: The computation of ionic solvation free energies from atomistic simulations
          is a surprisingly difficult problem that has found no satisfactory solution for
          more than 15 years.
        doi: 10.1063/1.2172593
        isbn: 0-816-52066-6
        issn: 0097-8493
        url: http://www.ctan.org
        start: '55'
        end: '65'
        month: '3'

