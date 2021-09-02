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
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "http://fakepackage.R-Forge.R-project.org/"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_bitbucket
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://bitbucket.org/ropensci/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_exotic_licenses
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-2.0-or-later" "GPL-3.0-only"    
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_gitlab
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://gitlab.com/ropensci/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_good
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_good_readmeinurl
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_no_URL
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://github.com/ropensci/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_no_bugreports
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_personoverkill
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Hernangómez"
      
      $authors[[1]]$`given-names`
      [1] "Diego"
      
      $authors[[1]]$email
      [1] "fake@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0001-8457-4658"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Doe"
      
      $authors[[2]]$`given-names`
      [1] "Joe"
      
      $authors[[2]]$affiliation
      [1] "This One"
      
      $authors[[2]]$country
      [1] "ES"
      
      
      $authors[[3]]
      $authors[[3]]$`family-names`
      [1] "Doe"
      
      $authors[[3]]$`given-names`
      [1] "Pepe"
      
      $authors[[3]]$email
      [1] "fake@gmail.com"
      
      
      $authors[[4]]
      $authors[[4]]$name
      [1] "I am an entity"
      
      $authors[[4]]$`date-end`
      [1] "2020-01-01"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Hernangómez"
      
      $contact[[1]]$`given-names`
      [1] "Diego"
      
      $contact[[1]]$email
      [1] "fake@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0001-8457-4658"
      
      
      $contact[[2]]
      $contact[[2]]$name
      [1] "I am an entity"
      
      $contact[[2]]$`date-end`
      [1] "2020-01-01"
      
      
      
      $keywords
      NULL
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_plainauthors
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Ok"
      
      $authors[[1]]$`given-names`
      [1] "John"
      
      $authors[[1]]$email
      [1] "email@email.edu"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Doe"
      
      $authors[[2]]$`given-names`
      [1] "Jane"
      
      
      $authors[[3]]
      $authors[[3]]$`family-names`
      [1] "Doo"
      
      $authors[[3]]$`given-names`
      [1] "Jane"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Ok"
      
      $contact[[1]]$`given-names`
      [1] "John"
      
      $contact[[1]]$email
      [1] "email@email.edu"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_sysreqs
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_two_URLs
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "essurvey: Download Data from the European Social Survey on the Fly"
      
      $version
      Version 
      "1.0.0" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Cimentada"
      
      $authors[[1]]$`given-names`
      [1] "Jorge"
      
      $authors[[1]]$email
      [1] "cimentadaj@gmail.com"
      
      
      
      $abstract
      [1] "Download data from the European Social Survey directly from their website <http://www.europeansocialsurvey.org/>. There are two families of functions that allow you to download and interactively check all countries and rounds available."
      
      $`repository-code`
      [1] "https://github.com/ropensci/essurvey"
      
      $url
      [1] "https://ropensci.github.io/essurvey/"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Cimentada"
      
      $contact[[1]]$`given-names`
      [1] "Jorge"
      
      $contact[[1]]$email
      [1] "cimentadaj@gmail.com"
      
      
      
      $keywords
      NULL
      
      $license
      NULL
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_twomaintainers
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Ok"
      
      $authors[[1]]$`given-names`
      [1] "John"
      
      $authors[[1]]$email
      [1] "email@email.edu"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Doe"
      
      $authors[[2]]$`given-names`
      [1] "Jane"
      
      $authors[[2]]$email
      [1] "email2@email.edu"
      
      
      $authors[[3]]
      $authors[[3]]$`family-names`
      [1] "Doo"
      
      $authors[[3]]$`given-names`
      [1] "Jane"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Ok"
      
      $contact[[1]]$`given-names`
      [1] "John"
      
      $contact[[1]]$email
      [1] "email@email.edu"
      
      
      $contact[[2]]
      $contact[[2]]$`family-names`
      [1] "Doe"
      
      $contact[[2]]$`given-names`
      [1] "Jane"
      
      $contact[[2]]$email
      [1] "email2@email.edu"
      
      
      
      $keywords
      NULL
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_with_remote
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate 'CodeMeta' Metadata for R Packages"
      
      $version
      Version 
      "0.1.6" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      $authors[[2]]
      $authors[[2]]$`family-names`
      [1] "Salmon"
      
      $authors[[2]]$`given-names`
      [1] "Maëlle"
      
      $authors[[2]]$orcid
      [1] "https://orcid.org/0000-0002-2815-0399"
      
      
      
      $abstract
      [1] "The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally."
      
      $`repository-code`
      [1] "https://github.com/ropensci/codemetar"
      
      $url
      [1] "https://ropensci.github.io/codemetar"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      [1] "GPL-3.0-only"
      
    Message <simpleMessage>
      End----- 
      
      File DESCRIPTION_wrongURLS
    Output
      $`cff-version`
      [1] "1.2.0"
      
      $message
      [1] "If you use this software, please cite it using these metadata."
      
      $type
      [1] "software"
      
      $title
      [1] "codemetar: Generate CodeMeta Metadata for R Packages"
      
      $version
      Version 
      "0.1.0" 
      
      $authors
      $authors[[1]]
      $authors[[1]]$`family-names`
      [1] "Boettiger"
      
      $authors[[1]]$`given-names`
      [1] "Carl"
      
      $authors[[1]]$email
      [1] "cboettig@gmail.com"
      
      $authors[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $abstract
      [1] "Codemeta defines a 'JSON-LD' format for describing software metadata. This package provides utilities to generate, parse, and modify codemeta.jsonld files automatically for R packages."
      
      $`repository-code`
      [1] "https://www.github.com/ropensci/codemeta"
      
      $url
      [1] "https://httpbin.org/status/404"
      
      $`date-released`
      NULL
      
      $contact
      $contact[[1]]
      $contact[[1]]$`family-names`
      [1] "Boettiger"
      
      $contact[[1]]$`given-names`
      [1] "Carl"
      
      $contact[[1]]$email
      [1] "cboettig@gmail.com"
      
      $contact[[1]]$orcid
      [1] "https://orcid.org/0000-0002-1642-628X"
      
      
      
      $keywords
      [1] "metadata"    "codemeta"    "ropensci"    "citation"    "credit"     
      [6] "linked-data"
      
      $license
      NULL
      
    Message <simpleMessage>
      End----- 
      

