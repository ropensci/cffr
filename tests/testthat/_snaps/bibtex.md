# Read bibtex example

    @Book{einstein1921,
      title = {Relativity: The Special and the General Theory},
      author = {A. Einstein},
      year = {1920},
      publisher = {Henry Holt and Company},
      address = {London, United Kingdom},
      isbn = {9781587340925},
    }
    
    @Manual{base2021,
      title = {R: A Language and Environment for {Statistical} Computing},
      author = {{R Core Team}},
      year = {2021},
      address = {Vienna, Austria},
      url = {https://www.R-project.org/},
      organization = {R Foundation for Statistical Computing},
    }

# Read bibtex example cff

    - type: book
      title: 'Relativity: The Special and the General Theory'
      authors:
      - family-names: Einstein
        given-names: A.
      year: '1920'
      publisher:
        name: Henry Holt and Company
        city: London, United Kingdom
      isbn: '9781587340925'
    - type: manual
      title: 'R: A Language and Environment for Statistical Computing'
      authors:
      - name: R Core Team
      year: '2021'
      url: https://www.R-project.org/
      institution:
        name: R Foundation for Statistical Computing

# Read bibtex full

    @Article{article,
      title = {Bit-Vector Algorithms for Binary Constraint Satisfaction and Subgraph Isomorphism},
      author = {Julian R. Ullmann},
      year = {2011},
      month = {feb},
      journal = {ACM Journal of Experimental Algorithmics},
      publisher = {Association for Computing Machinery},
      address = {New York, NY, USA},
      volume = {15},
      number = {1.6},
      pages = {1--64},
      doi = {10.1145/1671970.1921702},
      issn = {1084-6654},
      url = {https://doi.org/10.1145/1671970.1921702},
      issue_date = {2010},
      articleno = {1.6},
      numpages = {64},
      keywords = {constraint propagation, signature file, prematching, constraint satisfaction, binary constraints, graph indexing, bit-vector, focus search, molecule matching, subgraph isomorphism, AllDifferent constraint, backtrack, domain reduction, forward checking},
    }
    
    @Book{book,
      title = {Gray's anatomy},
      author = {Henry Gray and Peter L. Williams and Roger Warwick},
      year = {1973},
      publisher = {Longman London},
      address = {London, United Kingdom},
      pages = {xvi, 1471 p.},
      isbn = {0443010110},
      edition = {35th ed.; edited by Roger Warwick and Peter L. Williams with the assistance of others.},
      type = {Book},
      language = {English},
      subjects = {Human anatomy},
      life-dates = {1973 -},
      catalogue-url = {https://nla.gov.au/nla.cat-vn280221},
    }
    
    @Booklet{booklet,
      title = {A booklet},
      author = {John Doe},
      year = {1993},
      month = {7},
      address = {Usually the address of the publisher},
      note = {An optional note},
      howpublished = {How it was published},
    }
    
    @InProceedings{conference,
      title = {A conference},
      author = {John Doe},
      year = {1993},
      month = {7},
      booktitle = {The title of the book},
      publisher = {The name of the publisher},
      address = {Usually the address of the publisher},
      series = {The name of the series},
      volume = {The name of the volume},
      number = {23},
      pages = {201--213},
      note = {An optional note},
      editor = {{The name of the editor}},
      organization = {The name of the organization},
    }
    
    @InBook{inbook,
      title = {An InBook reference},
      author = {John Doe},
      year = {1993},
      month = {7},
      booktitle = {Compatibility with BibLaTex: The title of the book},
      publisher = {The name of the publisher},
      address = {Usually the address of the publisher},
      series = {The name of the series},
      volume = {The name of the volume},
      number = {222},
      pages = {201--213},
      note = {An optional note},
      editor = {{The name of the editor}},
      chapter = {The name of the chapter},
      type = {An optional type},
      edition = {The name of the edition},
    }
    
    @InCollection{incollection,
      title = {An InCollection reference},
      author = {John Doe},
      year = {1993},
      month = {7},
      booktitle = {The title of the book},
      publisher = {The name of the publisher},
      address = {Usually the address of the publisher},
      series = {The name of the series},
      volume = {The name of the volume},
      number = {222},
      pages = {201--213},
      note = {An optional note},
      editor = {{The editor}},
      type = {An optional type},
      chapter = {The name of the chapter},
      edition = {The name of the edition},
    }
    
    @InProceedings{inproceedings,
      title = {An InProceeedings reference},
      author = {John Doe},
      year = {1993},
      month = {7},
      booktitle = {The title of the book},
      publisher = {The name of the publisher},
      address = {Usually the address of the publisher},
      series = {The name of the series},
      volume = {The name of the volume},
      number = {222},
      pages = {201--213},
      note = {An optional note},
      editor = {{The editor}},
      organization = {The name of the organization},
    }
    
    @Manual{manual,
      title = {A Manual},
      author = {John Doe},
      year = {1993},
      month = {7},
      address = {Usually the address of the publisher},
      note = {An optional note},
      organization = {The name of the organization},
      edition = {The name of the edition},
    }
    
    @MastersThesis{mastersthesis,
      title = {A MasterThesis},
      author = {John Doe},
      year = {1993},
      month = {7},
      address = {The address of the school},
      note = {An optional note},
      school = {The school of the thesis},
      type = {{Ph.D.} dissertation},
      institution = {Compatibility with BibLaTex: The name of the institution},
    }
    
    @Misc{misc,
      title = {A Misc Entry},
      author = {John Doe},
      year = {1993},
      month = {7},
      note = {An optional note},
      howpublished = {How it was published},
    }
    
    @PhdThesis{phdthesis,
      title = {A PhD Thesis},
      author = {John Doe},
      year = {1993},
      month = {7},
      address = {The address of the school},
      note = {An optional note},
      school = {The school of the thesis},
      type = {Masters dissertation},
      institution = {Compatibility with BibLaTex: The name of the institution},
    }
    
    @Proceedings{proceedings,
      title = {Proceedings},
      year = {1993},
      month = {7},
      publisher = {The name of the publisher},
      address = {Usually the address of the publisher},
      series = {The name of the series},
      volume = {The name of the volume},
      number = {1},
      note = {An optional note},
      editor = {{The name of the editor}},
      organization = {The name of the organization},
    }
    
    @TechReport{techreport,
      title = {A TechReport},
      author = {John Doe},
      year = {1993},
      month = {7},
      address = {The address of the institution},
      number = {2},
      note = {An optional note},
      institution = {The name of the institution},
      type = {An optional type},
    }
    
    @Unpublished{unpublished,
      title = {Unpublished},
      author = {John Doe},
      year = {1993},
      month = {7},
      note = {An optional note},
      annote = {Annotation},
      crossref = {Crossref},
      keywords = {key1, key2},
    }
    
    @InProceedings{no-gnats,
      title = {No Gnats Are Taken for Granite},
      author = {Rocky Gneisser},
      pages = {133--139},
      crossref = {gg-proceedings},
    }
    
    @Proceedings{gg-proceedings,
      title = {Proceed},
      year = {1988},
      editor = {{Gerald Ford and Jimmy Carter}},
    }

# Read bibtex full cff

    - type: article
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
    - type: book
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
    - type: pamphlet
      title: A booklet
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      notes: An optional note
      medium: How it was published
    - type: conference-paper
      title: A conference
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      collection-title: The title of the book
      publisher:
        name: The name of the publisher
        city: Usually the address of the publisher
      volume: The name of the volume
      number: '23'
      pages: 201--213
      notes: An optional note
      editors:
      - name: The name of the editor
      institution:
        name: The name of the organization
      conference:
        name: The title of the book Usually the address of the publisher
      location:
        name: Usually the address of the publisher
    - type: book
      title: An InBook reference
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      collection-title: The name of the series
      publisher:
        name: The name of the publisher
        city: Usually the address of the publisher
      volume: The name of the volume
      number: '222'
      pages: 201--213
      notes: An optional note
      editors:
      - name: The name of the editor
      section: An optional type The name of the chapter
      edition: The name of the edition
    - type: generic
      title: An InCollection reference
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      collection-title: The title of the book
      publisher:
        name: The name of the publisher
        city: Usually the address of the publisher
      volume: The name of the volume
      number: '222'
      pages: 201--213
      notes: An optional note
      editors:
      - name: The editor
      section: An optional type The name of the chapter
      edition: The name of the edition
    - type: conference-paper
      title: An InProceeedings reference
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      collection-title: The title of the book
      publisher:
        name: The name of the publisher
        city: Usually the address of the publisher
      volume: The name of the volume
      number: '222'
      pages: 201--213
      notes: An optional note
      editors:
      - name: The editor
      institution:
        name: The name of the organization
      conference:
        name: The title of the book Usually the address of the publisher
      location:
        name: Usually the address of the publisher
    - type: manual
      title: A Manual
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      notes: An optional note
      edition: The name of the edition
      institution:
        name: The name of the organization
    - type: thesis
      title: A MasterThesis
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      notes: An optional note
      department: The school of the thesis
      institution:
        name: 'Compatibility with BibLaTex: The name of the institution'
      thesis-type: Master's Thesis
    - type: generic
      title: A Misc Entry
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      notes: An optional note
      medium: How it was published
    - type: thesis
      title: A PhD Thesis
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      notes: An optional note
      department: The school of the thesis
      institution:
        name: 'Compatibility with BibLaTex: The name of the institution'
      thesis-type: PhD Thesis
    - type: proceedings
      title: Proceedings
      year: '1993'
      month: '7'
      publisher:
        name: The name of the publisher
        city: Usually the address of the publisher
      volume: The name of the volume
      number: '1'
      notes: An optional note
      editors:
      - name: The name of the editor
      authors:
      - name: The name of the editor
        alias: BibTeX key from editor
    - type: report
      title: A TechReport
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      number: '2'
      notes: An optional note
      institution:
        name: The name of the institution
      section: An optional type
    - type: unpublished
      title: Unpublished
      authors:
      - family-names: Doe
        given-names: John
      year: '1993'
      month: '7'
      notes: An optional note
      keywords:
      - key1
      - key2
    - type: conference-paper
      title: No Gnats Are Taken for Granite
      authors:
      - family-names: Gneisser
        given-names: Rocky
      pages: 133--139
    - type: proceedings
      title: Proceed
      year: '1988'
      editors:
      - name: Gerald Ford and Jimmy Carter
      authors:
      - name: Gerald Ford and Jimmy Carter
        alias: BibTeX key from editor

# Read bibtex misc

    @InProceedings{parseasinproc,
      title = {Studying Mobile Context-Aware Social Services in the Wild},
      author = {Paul Holleis and Matthias Wagner and Sebastian B\"{o}hm and Johan Koolwaaij},
      year = {2010},
      booktitle = {Proceedings of the 6th Nordic Conference on Human-Computer Interaction: Extending Boundaries},
      location = {Reykjavik, Iceland},
      publisher = {Association for Computing Machinery},
      address = {New York, NY, USA},
      series = {NordiCHI '10},
      pages = {207–216},
      doi = {10.1145/1868914.1868941},
      isbn = {9781605589343},
      url = {https://doi.org/10.1145/1868914.1868941},
      abstract = {We have implemented and evaluated IYOUIT, a context-aware application for the mobile phone that promotes a digital lifestyle, sharing, and life-logging approach for people on the go. The service incorporates context management technology to abstract data about and around the user into meaningful interpretations of the user's digital trace in the real world. Complementary to the public release of our service, we have conducted a longitudinal field study with 19 users for a period of one month. In this paper, we present findings from this coordinated user trial and provide researchers with advice on the design and implementation of similar systems.},
      numpages = {10},
      keywords = {mobile services, context awareness, social networking},
    }
    
    @Misc{Druskat_Citation_File_Format_2021,
      title = {{Citation File Format}},
      author = {Stephan Druskat and Jurriaan H. Spaaks and Neil {Chue Hong} and Robert Haines and James Baker and Spencer Bliven and Egon Willighagen and David Pérez-Suárez and Alexander Konovalov},
      year = {2021},
      month = {8},
      doi = {10.5281/zenodo.5171937},
      license = {CC-BY-4.0},
      version = {1.2.0},
    }

# Read bibtex misc cff

    - type: conference-paper
      title: Studying Mobile Context-Aware Social Services in the Wild
      authors:
      - family-names: Holleis
        given-names: Paul
      - family-names: Wagner
        given-names: Matthias
      - family-names: B\"ohm
        given-names: Sebastian
      - family-names: Koolwaaij
        given-names: Johan
      year: '2010'
      collection-title: 'Proceedings of the 6th Nordic Conference on Human-Computer Interaction:
        Extending Boundaries'
      location:
        name: New York, NY, USA
      publisher:
        name: Association for Computing Machinery
        city: New York, NY, USA
      pages: 207–216
      doi: 10.1145/1868914.1868941
      isbn: '9781605589343'
      url: https://doi.org/10.1145/1868914.1868941
      abstract: We have implemented and evaluated IYOUIT, a context-aware application
        for the mobile phone that promotes a digital lifestyle, sharing, and life-logging
        approach for people on the go. The service incorporates context management technology
        to abstract data about and around the user into meaningful interpretations of
        the user's digital trace in the real world. Complementary to the public release
        of our service, we have conducted a longitudinal field study with 19 users for
        a period of one month. In this paper, we present findings from this coordinated
        user trial and provide researchers with advice on the design and implementation
        of similar systems.
      keywords:
      - mobile services
      - context awareness
      - social networking
      conference:
        name: 'Proceedings of the 6th Nordic Conference on Human-Computer Interaction:
          Extending Boundaries New York, NY, USA'
    - type: generic
      title: Citation File Format
      authors:
      - family-names: Druskat
        given-names: Stephan
      - family-names: Spaaks
        given-names: Jurriaan H.
      - family-names: Chue Hong
        given-names: Neil
      - family-names: Haines
        given-names: Robert
      - family-names: Baker
        given-names: James
      - family-names: Bliven
        given-names: Spencer
      - family-names: Willighagen
        given-names: Egon
      - family-names: Pérez-Suárez
        given-names: David
      - family-names: Konovalov
        given-names: Alexander
      year: '2021'
      month: '8'
      doi: 10.5281/zenodo.5171937
      license: CC-BY-4.0
      version: 1.2.0

# Read bibtex ascii

    @InProceedings{10.1145/1868914.1868941,
      title = {Studying Mobile Context-Aware Social Services in the Wild},
      author = {Paul Holleis and Matthias Wagner and Sebastian B\"{o}hm and Johan Koolwaaij},
      year = {2010},
      booktitle = {Proceedings of the 6th Nordic Conference on Human-Computer Interaction: Extending Boundaries},
      location = {Reykjavik, Iceland},
      publisher = {Association for Computing Machinery},
      address = {New York, NY, USA},
      series = {NordiCHI '10},
      pages = {207–216},
      doi = {10.1145/1868914.1868941},
      isbn = {9781605589343},
      url = {https://doi.org/10.1145/1868914.1868941},
      abstract = {We have implemented and evaluated IYOUIT, a context-aware application for the mobile phone that promotes a digital lifestyle, sharing, and life-logging approach for people on the go. The service incorporates context management technology to abstract data about and around the user into meaningful interpretations of the user's digital trace in the real world. Complementary to the public release of our service, we have conducted a longitudinal field study with 19 users for a period of one month. In this paper, we present findings from this coordinated user trial and provide researchers with advice on the design and implementation of similar systems.},
      numpages = {10},
      keywords = {mobile services, context awareness, social networking},
    }

# Read bibtex ascii cff

    type: conference-paper
    title: Studying Mobile Context-Aware Social Services in the Wild
    authors:
    - family-names: Holleis
      given-names: Paul
    - family-names: Wagner
      given-names: Matthias
    - family-names: B\"ohm
      given-names: Sebastian
    - family-names: Koolwaaij
      given-names: Johan
    year: '2010'
    collection-title: 'Proceedings of the 6th Nordic Conference on Human-Computer Interaction:
      Extending Boundaries'
    location:
      name: New York, NY, USA
    publisher:
      name: Association for Computing Machinery
      city: New York, NY, USA
    pages: 207–216
    doi: 10.1145/1868914.1868941
    isbn: '9781605589343'
    url: https://doi.org/10.1145/1868914.1868941
    abstract: We have implemented and evaluated IYOUIT, a context-aware application for
      the mobile phone that promotes a digital lifestyle, sharing, and life-logging approach
      for people on the go. The service incorporates context management technology to
      abstract data about and around the user into meaningful interpretations of the user's
      digital trace in the real world. Complementary to the public release of our service,
      we have conducted a longitudinal field study with 19 users for a period of one month.
      In this paper, we present findings from this coordinated user trial and provide
      researchers with advice on the design and implementation of similar systems.
    keywords:
    - mobile services
    - context awareness
    - social networking
    conference:
      name: 'Proceedings of the 6th Nordic Conference on Human-Computer Interaction: Extending
        Boundaries New York, NY, USA'

