# Test file description

    Code
      allfiles <- list.files(system.file("examples", package = "cffr"), pattern = "^DESC",
      full.names = TRUE)
      names <- list.files(system.file("examples", package = "cffr"), pattern = "^DESC",
      full.names = FALSE)
      for (i in seq_len(length(allfiles))) {
        message("File ", names[i])
        print(cff_create(allfiles[i]))
        message("End----- \n\n")
      }
    Message <simpleMessage>
      File DESCRIPTION_Rforge
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: http://fakepackage.R-Forge.R-project.org/
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_bitbucket
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://bitbucket.org/ropensci/codemetar
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_demo
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license:
      - GPL-3.0-or-later
      - MIT
      title: 'demodescriptionfile: Demo Description File'
      version: 0.1.0
      abstract: This is demo description file.
      authors:
      - family-names: Author
        given-names: First
        email: first.last@example.com
        orcid: https://orcid.org/0000-0001-8457-4658
        affiliation: An affiliation
      - name: I am an entity
        date-end: '2020-01-01'
      repository-code: https://github.com/demo/demo
      url: https://demo.github.io/demo/
      contact:
      - family-names: Author
        given-names: First
        email: first.last@example.com
        orcid: https://orcid.org/0000-0001-8457-4658
        affiliation: An affiliation
      - name: I am an entity
        date-end: '2020-01-01'
      keywords:
      - Demo
      - file
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_exotic_licenses
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license:
      - GPL-2.0-or-later
      - GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_gitlab
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://gitlab.com/ropensci/codemetar
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_good
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_good_readmeinurl
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_installed
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license:
      - GPL-2.0-only
      - MIT
      title: 'sf: Simple Features for R'
      version: 1.0-2
      abstract: Support for simple features, a standardized way to encode spatial vector
        data. Binds to 'GDAL' for reading and writing data, to 'GEOS' for geometrical operations,
        and to 'PROJ' for projection conversions and datum transformations. Uses by default
        the 's2' package for spherical geometry operations on ellipsoidal (long/lat) coordinates.
      authors:
      - family-names: Pebesma
        given-names: Edzer
        email: edzer.pebesma@uni-muenster.de
        orcid: https://orcid.org/0000-0001-8049-7069
      repository-code: https://github.com/r-spatial/sf/
      url: https://r-spatial.github.io/sf/
      date-released: '2021-07-26'
      contact:
      - family-names: Pebesma
        given-names: Edzer
        email: edzer.pebesma@uni-muenster.de
        orcid: https://orcid.org/0000-0001-8049-7069
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_no_URL
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_no_bugreports
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_no_encoding
    Warning <simpleWarning>
      Consider adding an Encoding field to DESCRIPTION,
      Non-ASCII character(s) in Authors@R
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://bitbucket.org/ropensci/codemetar
      date-released: '2020-01-01'
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_personoverkill
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Hernangómez
        given-names: Diego
        email: fake@gmail.com
        orcid: https://orcid.org/0000-0001-8457-4658
      - family-names: Doe
        given-names: Joe
        affiliation: This One
        country: ES
      - family-names: Doe
        given-names: Pepe
        email: fake@gmail.com
      - name: I am an entity
        date-end: '2020-01-01'
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Hernangómez
        given-names: Diego
        email: fake@gmail.com
        orcid: https://orcid.org/0000-0001-8457-4658
      - name: I am an entity
        date-end: '2020-01-01'
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_plainauthors
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Ok
        given-names: John
        email: email@email.edu
      - family-names: Doe
        given-names: Jane
      - family-names: Doo
        given-names: Jane
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Ok
        given-names: John
        email: email@email.edu
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_sysreqs
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_two_URLs
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: MIT
      title: 'essurvey: Download Data from the European Social Survey on the Fly'
      version: 1.0.0
      abstract: Download data from the European Social Survey directly from their website
        <http://www.europeansocialsurvey.org/>. There are two families of functions that
        allow you to download and interactively check all countries and rounds available.
      authors:
      - family-names: Cimentada
        given-names: Jorge
        email: cimentadaj@gmail.com
      repository-code: https://github.com/ropensci/essurvey
      url: https://ropensci.github.io/essurvey/
      contact:
      - family-names: Cimentada
        given-names: Jorge
        email: cimentadaj@gmail.com
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_twomaintainers
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Ok
        given-names: John
        email: email@email.edu
      - family-names: Doe
        given-names: Jane
        email: email2@email.edu
      - family-names: Doo
        given-names: Jane
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Ok
        given-names: John
        email: email@email.edu
      - family-names: Doe
        given-names: Jane
        email: email2@email.edu
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_with_remote
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: GPL-3.0-only
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_wrongURLS
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      license: MIT
      title: 'codemetar: Generate CodeMeta Metadata for R Packages'
      version: 0.1.0
      abstract: Codemeta defines a 'JSON-LD' format for describing software metadata. This
        package provides utilities to generate, parse, and modify codemeta.jsonld files
        automatically for R packages.
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      repository-code: https://www.github.com/ropensci/codemeta
      url: https://httpbin.org/status/404
      contact:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      keywords:
      - metadata
      - codemeta
      - ropensci
      - citation
      - credit
      - linked-data
    Message <simpleMessage>
      End----- 
      

