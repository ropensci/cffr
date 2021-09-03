# Test file description

    Code
      allfiles <- list.files(system.file("examples", package = "cffr"), pattern = "^DESC",
      full.names = TRUE)
      names <- list.files(system.file("examples", package = "cffr"), pattern = "^DESC",
      full.names = FALSE)
      for (i in seq_len(length(allfiles))) {
        message("File ", names[i])
        print(cff_description(allfiles[i]))
        message("End----- \n\n")
      }
    Message <simpleMessage>
      File DESCRIPTION_Rforge
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: http://fakepackage.R-Forge.R-project.org/
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_bitbucket
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://bitbucket.org/ropensci/codemetar
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_demo
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'demodescriptionfile: Demo Description File'
      version: 0.1.0
      authors:
      - family-names: Author
        given-names: First
        email: first.last@example.com
        orcid: https://orcid.org/0000-0001-8457-4658
        affiliation: An affiliation
      - name: I am an entity
        date-end: '2020-01-01'
      abstract: This is demo description file.
      repository-code: https://github.com/demo/demo
      url: https://demo.github.io/demo/
      date-released: ~
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
      license:
      - GPL-3.0-or-later
      - MIT
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_exotic_licenses
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
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
      license:
      - GPL-2.0-or-later
      - GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_gitlab
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://gitlab.com/ropensci/codemetar
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_good
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_good_readmeinurl
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_no_URL
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: ~
      url: ~
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_no_bugreports
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
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
      license: GPL-3.0-only
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
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_personoverkill
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
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
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
      contact:
      - family-names: Hernangómez
        given-names: Diego
        email: fake@gmail.com
        orcid: https://orcid.org/0000-0001-8457-4658
      - name: I am an entity
        date-end: '2020-01-01'
      keywords: ~
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_plainauthors
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Ok
        given-names: John
        email: email@email.edu
      - family-names: Doe
        given-names: Jane
      - family-names: Doo
        given-names: Jane
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_sysreqs
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_two_URLs
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'essurvey: Download Data from the European Social Survey on the Fly'
      version: 1.0.0
      authors:
      - family-names: Cimentada
        given-names: Jorge
        email: cimentadaj@gmail.com
      abstract: Download data from the European Social Survey directly from their website
        <http://www.europeansocialsurvey.org/>. There are two families of functions that
        allow you to download and interactively check all countries and rounds available.
      repository-code: https://github.com/ropensci/essurvey
      url: https://ropensci.github.io/essurvey/
      date-released: ~
      contact:
      - family-names: Cimentada
        given-names: Jorge
        email: cimentadaj@gmail.com
      keywords: ~
      license: MIT
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_twomaintainers
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Ok
        given-names: John
        email: email@email.edu
      - family-names: Doe
        given-names: Jane
        email: email2@email.edu
      - family-names: Doo
        given-names: Jane
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
      contact:
      - family-names: Ok
        given-names: John
        email: email@email.edu
      - family-names: Doe
        given-names: Jane
        email: email2@email.edu
      keywords: ~
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_with_remote
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
      version: 0.1.6
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      - family-names: Salmon
        given-names: Maëlle
        orcid: https://orcid.org/0000-0002-2815-0399
      abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
        metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
        to generate, parse, and modify 'codemeta.json' files automatically for R packages,
        as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
      repository-code: https://github.com/ropensci/codemetar
      url: https://ropensci.github.io/codemetar
      date-released: ~
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
      license: GPL-3.0-only
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_wrongURLS
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      type: software
      title: 'codemetar: Generate CodeMeta Metadata for R Packages'
      version: 0.1.0
      authors:
      - family-names: Boettiger
        given-names: Carl
        email: cboettig@gmail.com
        orcid: https://orcid.org/0000-0002-1642-628X
      abstract: Codemeta defines a 'JSON-LD' format for describing software metadata. This
        package provides utilities to generate, parse, and modify codemeta.jsonld files
        automatically for R packages.
      repository-code: https://www.github.com/ropensci/codemeta
      url: https://httpbin.org/status/404
      date-released: ~
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
      license: MIT
    Message <simpleMessage>
      End----- 
      

