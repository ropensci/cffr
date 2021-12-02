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

# UTF Encoding

        dec   utf8             latex_base             latex_cffr
    1     1   \001                      ?                      ?
    2     2   \002                      ?                      ?
    3     3   \003                      ?                      ?
    4     4   \004                      ?                      ?
    5     5   \005                      ?                      ?
    6     6   \006                      ?                      ?
    7     7     \a                      ?                      ?
    8     8     \b                      ?                      ?
    9     9     \t                      ?                      ?
    10   10     \n                      ?                      ?
    11   11     \v                      ?                      ?
    12   12     \f                      ?                      ?
    13   13     \r                      ?                      ?
    14   14   \016                      ?                      ?
    15   15   \017                      ?                      ?
    16   16   \020                      ?                      ?
    17   17   \021                      ?                      ?
    18   18   \022                      ?                      ?
    19   19   \023                      ?                      ?
    20   20   \024                      ?                      ?
    21   21   \025                      ?                      ?
    22   22   \026                      ?                      ?
    23   23   \027                      ?                      ?
    24   24   \030                      ?                      ?
    25   25   \031                      ?                      ?
    26   26   \032                      ?                      ?
    27   27   \033                      ?                      ?
    28   28   \034                      ?                      ?
    29   29   \035                      ?                      ?
    30   30   \036                      ?                      ?
    31   31   \037                      ?                      ?
    32   32                                                     
    33   33      !                      !                      !
    34   34      "                      "                      "
    35   35      #                      #                      #
    36   36      $                      $                      $
    37   37      %                      %                      %
    38   38      &                      &                      &
    39   39      '                      '                      '
    40   40      (                      (                      (
    41   41      )                      )                      )
    42   42      *                      *                      *
    43   43      +                      +                      +
    44   44      ,                      ,                      ,
    45   45      -                      -                      -
    46   46      .                      .                      .
    47   47      /                      /                      /
    48   48      0                      0                      0
    49   49      1                      1                      1
    50   50      2                      2                      2
    51   51      3                      3                      3
    52   52      4                      4                      4
    53   53      5                      5                      5
    54   54      6                      6                      6
    55   55      7                      7                      7
    56   56      8                      8                      8
    57   57      9                      9                      9
    58   58      :                      :                      :
    59   59      ;                      ;                      ;
    60   60      <                      <                      <
    61   61      =                      =                      =
    62   62      >                      >                      >
    63   63      ?                      ?                      ?
    64   64      @                      @                      @
    65   65      A                      A                      A
    66   66      B                      B                      B
    67   67      C                      C                      C
    68   68      D                      D                      D
    69   69      E                      E                      E
    70   70      F                      F                      F
    71   71      G                      G                      G
    72   72      H                      H                      H
    73   73      I                      I                      I
    74   74      J                      J                      J
    75   75      K                      K                      K
    76   76      L                      L                      L
    77   77      M                      M                      M
    78   78      N                      N                      N
    79   79      O                      O                      O
    80   80      P                      P                      P
    81   81      Q                      Q                      Q
    82   82      R                      R                      R
    83   83      S                      S                      S
    84   84      T                      T                      T
    85   85      U                      U                      U
    86   86      V                      V                      V
    87   87      W                      W                      W
    88   88      X                      X                      X
    89   89      Y                      Y                      Y
    90   90      Z                      Z                      Z
    91   91      [                      [                      [
    92   92     \\                     \\                     \\
    93   93      ]                      ]                      ]
    94   94      ^                      ^                      ^
    95   95      _                      _                      _
    96   96      `                      `                      `
    97   97      a                      a                      a
    98   98      b                      b                      b
    99   99      c                      c                      c
    100 100      d                      d                      d
    101 101      e                      e                      e
    102 102      f                      f                      f
    103 103      g                      g                      g
    104 104      h                      h                      h
    105 105      i                      i                      i
    106 106      j                      j                      j
    107 107      k                      k                      k
    108 108      l                      l                      l
    109 109      m                      m                      m
    110 110      n                      n                      n
    111 111      o                      o                      o
    112 112      p                      p                      p
    113 113      q                      q                      q
    114 114      r                      r                      r
    115 115      s                      s                      s
    116 116      t                      t                      t
    117 117      u                      u                      u
    118 118      v                      v                      v
    119 119      w                      w                      w
    120 120      x                      x                      x
    121 121      y                      y                      y
    122 122      z                      z                      z
    123 123      {                      {                      {
    124 124      |                      |                      |
    125 125      }                      }                      }
    126 126      ~                      ~                      ~
    127 127   \177                      ?                      ?
    128 128 \u0080                      ?                      ?
    129 129 \u0081                      ?                      ?
    130 130 \u0082                      ?                      ?
    131 131 \u0083                      ?                      ?
    132 132 \u0084                      ?                      ?
    133 133 \u0085                      ?                      ?
    134 134 \u0086                      ?                      ?
    135 135 \u0087                      ?                      ?
    136 136 \u0088                      ?                      ?
    137 137 \u0089                      ?                      ?
    138 138 \u008a                      ?                      ?
    139 139 \u008b                      ?                      ?
    140 140 \u008c                      ?                      ?
    141 141 \u008d                      ?                      ?
    142 142 \u008e                      ?                      ?
    143 143 \u008f                      ?                      ?
    144 144 \u0090                      ?                      ?
    145 145 \u0091                      ?                      ?
    146 146 \u0092                      ?                      ?
    147 147 \u0093                      ?                      ?
    148 148 \u0094                      ?                      ?
    149 149 \u0095                      ?                      ?
    150 150 \u0096                      ?                      ?
    151 151 \u0097                      ?                      ?
    152 152 \u0098                      ?                      ?
    153 153 \u0099                      ?                      ?
    154 154 \u009a                      ?                      ?
    155 155 \u009b                      ?                      ?
    156 156 \u009c                      ?                      ?
    157 157 \u009d                      ?                      ?
    158 158 \u009e                      ?                      ?
    159 159 \u009f                      ?                      ?
    160 160              {\\nobreakspace}       {\\nobreakspace}
    161 161      ¡     {\\textexclamdown}     {\\textexclamdown}
    162 162      ¢           {\\textcent}           {\\textcent}
    163 163      £       {\\textsterling}       {\\textsterling}
    164 164      ¤       {\\textcurrency}       {\\textcurrency}
    165 165      ¥            {\\textyen}            {\\textyen}
    166 166      ¦      {\\textbrokenbar}      {\\textbrokenbar}
    167 167      §                  {\\S}                  {\\S}
    168 168      ¨                  \\"{}                  \\"{}
    169 169      ©      {\\textcopyright}      {\\textcopyright}
    170 170      ª    {\\textordfeminine}    {\\textordfeminine}
    171 171      «      {\\guillemotleft}      {\\guillemotleft}
    172 172      ¬           {\\textlnot}           {\\textlnot}
    173 173      ­                    \\-                    \\-
    174 174      ®     {\\textregistered}     {\\textregistered}
    175 175      ¯               {\\a={}}                {\\={}}
    176 176      °         {\\textdegree}         {\\textdegree}
    177 177      ±             {\\textpm}             {\\textpm}
    178 178      ²    {\\mathtwosuperior}    {\\mathtwosuperior}
    179 179      ³  {\\maththreesuperior}  {\\maththreesuperior}
    180 180      ´               {\\a'{}}                {\\'{}}
    181 181      µ             {\\textmu}             {\\textmu}
    182 182      ¶                  {\\P}                  {\\P}
    183 183      · {\\textperiodcentered} {\\textperiodcentered}
    184 184      ¸               {\\c\\ }               {\\c\\ }
    185 185      ¹    {\\mathonesuperior}    {\\mathonesuperior}
    186 186      º   {\\textordmasculine}   {\\textordmasculine}
    187 187      »     {\\guillemotright}     {\\guillemotright}
    188 188      ¼     {\\textonequarter}     {\\textonequarter}
    189 189      ½        {\\textonehalf}        {\\textonehalf}
    190 190      ¾  {\\textthreequarters}  {\\textthreequarters}
    191 191      ¿   {\\textquestiondown}   {\\textquestiondown}
    192 192      À                {\\a`A}                 {\\`A}
    193 193      Á                {\\a'A}                 {\\'A}
    194 194      Â                 {\\^A}                 {\\^A}
    195 195      Ã                 {\\~A}                 {\\~A}
    196 196      Ä                 {\\"A}                 {\\"A}
    197 197      Å                {\\r A}                {\\r A}
    198 198      Æ                 {\\AE}                 {\\AE}
    199 199      Ç                {\\c C}                {\\c C}
    200 200      È                {\\a`E}                 {\\`E}
    201 201      É                {\\a'E}                 {\\'E}
    202 202      Ê                 {\\^E}                 {\\^E}
    203 203      Ë                {\\a`I}                 {\\`I}
    204 204      Ì                {\\a'I}                 {\\'I}
    205 205      Í                 {\\^I}                 {\\^I}
    206 206      Î                 {\\~I}                 {\\~I}
    207 207      Ï                 {\\"I}                 {\\"I}
    208 208      Ð                 {\\DH}                 {\\DH}
    209 209      Ñ                 {\\~N}                 {\\~N}
    210 210      Ò                {\\a`O}                 {\\`O}
    211 211      Ó                {\\a'O}                 {\\'O}
    212 212      Ô                 {\\^O}                 {\\^O}
    213 213      Õ                 {\\~O}                 {\\~O}
    214 214      Ö                 {\\"O}                 {\\"O}
    215 215      ×          {\\texttimes}          {\\texttimes}
    216 216      Ø                  {\\O}                  {\\O}
    217 217      Ù                {\\a`U}                 {\\`U}
    218 218      Ú                {\\a'U}                 {\\'U}
    219 219      Û                 {\\^U}                 {\\^U}
    220 220      Ü                 {\\"U}                 {\\"U}
    221 221      Ý                {\\a`Y}                 {\\`Y}
    222 222      Þ                 {\\TH}                 {\\TH}
    223 223      ß                 {\\ss}                 {\\ss}
    224 224      à                {\\a`a}                 {\\`a}
    225 225      á                {\\a'a}                 {\\'a}
    226 226      â                 {\\^a}                 {\\^a}
    227 227      ã                 {\\~a}                 {\\~a}
    228 228      ä                 {\\"a}                 {\\"a}
    229 229      å                {\\r a}                {\\r a}
    230 230      æ                 {\\ae}                 {\\ae}
    231 231      ç                {\\c c}                {\\c c}
    232 232      è                {\\a`e}                 {\\`e}
    233 233      é                {\\a'e}                 {\\'e}
    234 234      ê                 {\\^e}                 {\\^e}
    235 235      ë                 {\\"e}                 {\\"e}
    236 236      ì              {\\a`\\i}               {\\`\\i}
    237 237      í              {\\a'\\i}               {\\'\\i}
    238 238      î               {\\^\\i}               {\\^\\i}
    239 239      ï               {\\"\\i}               {\\"\\i}
    240 240      ð                 {\\dh}                 {\\dh}
    241 241      ñ                 {\\~n}                 {\\~n}
    242 242      ò                {\\a`o}                 {\\`o}
    243 243      ó                {\\a'o}                 {\\'o}
    244 244      ô                 {\\^o}                 {\\^o}
    245 245      õ                 {\\~o}                 {\\~o}
    246 246      ö                 {\\"o}                 {\\"o}
    247 247      ÷            {\\textdiv}            {\\textdiv}
    248 248      ø                  {\\o}                  {\\o}
    249 249      ù                {\\a`u}                 {\\`u}
    250 250      ú                {\\a'u}                 {\\'u}
    251 251      û                 {\\^u}                 {\\^u}
    252 252      ü                 {\\"u}                 {\\"u}
    253 253      ý                {\\a`y}                 {\\`y}
    254 254      þ                 {\\th}                 {\\th}
    255 255      ÿ                 {\\"y}                 {\\"y}
    256 256      Ā                      ?                      ?
    257 257      ā                      ?                      ?
    258 258      Ă                {\\u A}                {\\u A}
    259 259      ă                {\\u a}                {\\u a}
    260 260      Ą                {\\k A}                 {\\ A}
    261 261      ą                {\\k a}                 {\\ a}
    262 262      Ć                {\\a'C}                 {\\'C}
    263 263      ć                {\\a'c}                 {\\'c}
    264 264      Ĉ                      ?                      ?
    265 265      ĉ                      ?                      ?
    266 266      Ċ                      ?                      ?
    267 267      ċ                      ?                      ?
    268 268      Č                {\\v C}                {\\v C}
    269 269      č                {\\v c}                {\\v c}
    270 270      Ď                {\\v D}                {\\v D}
    271 271      ď                {\\v d}                {\\v d}
    272 272      Đ                 {\\DJ}                 {\\DJ}
    273 273      đ                 {\\dj}                 {\\dj}
    274 274      Ē                      ?                      ?
    275 275      ē                      ?                      ?
    276 276      Ĕ                      ?                      ?
    277 277      ĕ                      ?                      ?
    278 278      Ė                      ?                      ?
    279 279      ė                      ?                      ?
    280 280      Ę                {\\k E}                 {\\ E}
    281 281      ę                {\\k e}                 {\\ e}
    282 282      Ě                {\\v E}                {\\v E}
    283 283      ě                {\\v e}                {\\v e}
    284 284      Ĝ                      ?                      ?
    285 285      ĝ                      ?                      ?
    286 286      Ğ                {\\u G}                {\\u G}
    287 287      ğ                {\\u g}                {\\u g}
    288 288      Ġ                      ?                      ?
    289 289      ġ                      ?                      ?
    290 290      Ģ                      ?                      ?
    291 291      ģ                      ?                      ?
    292 292      Ĥ                      ?                      ?
    293 293      ĥ                      ?                      ?
    294 294      Ħ                      ?                      ?
    295 295      ħ                      ?                      ?
    296 296      Ĩ                      ?                      ?
    297 297      ĩ                      ?                      ?
    298 298      Ī                      ?                      ?
    299 299      ī                      ?                      ?
    300 300      Ĭ                      ?                      ?
    301 301      ĭ                      ?                      ?
    302 302      Į                      ?                      ?
    303 303      į                      ?                      ?
    304 304      İ                 {\\.I}                 {\\.I}
    305 305      ı                  {\\i}                  {\\i}
    306 306      Ĳ                      ?                      ?
    307 307      ĳ                      ?                      ?
    308 308      Ĵ                      ?                      ?
    309 309      ĵ                      ?                      ?
    310 310      Ķ                      ?                      ?
    311 311      ķ                      ?                      ?
    312 312      ĸ                      ?                      ?
    313 313      Ĺ                {\\a'L}                 {\\'L}
    314 314      ĺ                {\\a'l}                 {\\'l}
    315 315      Ļ                      ?                      ?
    316 316      ļ                      ?                      ?
    317 317      Ľ                {\\v L}                {\\v L}
    318 318      ľ                {\\v l}                {\\v l}
    319 319      Ŀ                      ?                      ?
    320 320      ŀ                      ?                      ?
    321 321      Ł                  {\\L}                  {\\L}
    322 322      ł                  {\\l}                  {\\l}
    323 323      Ń                {\\a'N}                 {\\'N}
    324 324      ń                {\\a'n}                 {\\'n}
    325 325      Ņ                      ?                      ?
    326 326      ņ                      ?                      ?
    327 327      Ň                {\\v N}                {\\v N}
    328 328      ň                {\\v n}                {\\v n}
    329 329      ŉ                      ?                      ?
    330 330      Ŋ                 {\\NG}                 {\\NG}
    331 331      ŋ                 {\\ng}                 {\\ng}
    332 332      Ō                      ?                      ?
    333 333      ō                      ?                      ?
    334 334      Ŏ                      ?                      ?
    335 335      ŏ                      ?                      ?
    336 336      Ő                {\\H O}                {\\H O}
    337 337      ő                {\\H o}                {\\H o}
    338 338      Œ                 {\\OE}                 {\\OE}
    339 339      œ                 {\\oe}                 {\\oe}
    340 340      Ŕ                {\\a'R}                 {\\'R}
    341 341      ŕ                {\\a'r}                 {\\'r}
    342 342      Ŗ                      ?                      ?
    343 343      ŗ                      ?                      ?
    344 344      Ř                {\\v R}                {\\v R}
    345 345      ř                {\\v r}                {\\v r}
    346 346      Ś                {\\a'S}                 {\\'S}
    347 347      ś                {\\a's}                 {\\'s}
    348 348      Ŝ                      ?                      ?
    349 349      ŝ                      ?                      ?
    350 350      Ş                {\\c S}                {\\c S}
    351 351      ş                {\\c s}                {\\c s}
    352 352      Š                {\\v S}                {\\v S}
    353 353      š                {\\v s}                {\\v s}
    354 354      Ţ                {\\c T}                {\\c T}
    355 355      ţ                {\\c t}                {\\c t}
    356 356      Ť                {\\v T}                {\\v T}
    357 357      ť                {\\v t}                {\\v t}
    358 358      Ŧ                      ?                      ?
    359 359      ŧ                      ?                      ?
    360 360      Ũ                      ?                      ?
    361 361      ũ                      ?                      ?
    362 362      Ū                      ?                      ?
    363 363      ū                      ?                      ?
    364 364      Ŭ                      ?                      ?
    365 365      ŭ                      ?                      ?
    366 366      Ů                {\\r U}                {\\r U}
    367 367      ů                {\\r u}                {\\r u}
    368 368      Ű                {\\H U}                {\\H U}
    369 369      ű                {\\H u}                {\\H u}
    370 370      Ų                      ?                      ?
    371 371      ų                      ?                      ?
    372 372      Ŵ                      ?                      ?
    373 373      ŵ                      ?                      ?
    374 374      Ŷ                      ?                      ?
    375 375      ŷ                      ?                      ?
    376 376      Ÿ                 {\\"Y}                 {\\"Y}
    377 377      Ź                {\\a'Z}                 {\\'Z}
    378 378      ź                {\\a'z}                 {\\'z}
    379 379      Ż                 {\\.Z}                 {\\.Z}
    380 380      ż                 {\\.z}                 {\\.z}
    381 381      Ž                {\\v Z}                {\\v Z}
    382 382      ž                {\\v z}                {\\v z}
    383 383      ſ                      ?                      ?
    384 384      ƀ                      ?                      ?
    385 385      Ɓ                      ?                      ?
    386 386      Ƃ                      ?                      ?
    387 387      ƃ                      ?                      ?
    388 388      Ƅ                      ?                      ?
    389 389      ƅ                      ?                      ?
    390 390      Ɔ                      ?                      ?
    391 391      Ƈ                      ?                      ?
    392 392      ƈ                      ?                      ?
    393 393      Ɖ                      ?                      ?
    394 394      Ɗ                      ?                      ?
    395 395      Ƌ                      ?                      ?
    396 396      ƌ                      ?                      ?
    397 397      ƍ                      ?                      ?
    398 398      Ǝ                      ?                      ?
    399 399      Ə                      ?                      ?
    400 400      Ɛ                      ?                      ?
    401 401      Ƒ                      ?                      ?
    402 402      ƒ         {\\textflorin}         {\\textflorin}
    403 403      Ɠ                      ?                      ?
    404 404      Ɣ                      ?                      ?
    405 405      ƕ                      ?                      ?
    406 406      Ɩ                      ?                      ?
    407 407      Ɨ                      ?                      ?
    408 408      Ƙ                      ?                      ?
    409 409      ƙ                      ?                      ?
    410 410      ƚ                      ?                      ?
    411 411      ƛ                      ?                      ?
    412 412      Ɯ                      ?                      ?
    413 413      Ɲ                      ?                      ?
    414 414      ƞ                      ?                      ?
    415 415      Ɵ                      ?                      ?
    416 416      Ơ                      ?                      ?
    417 417      ơ                      ?                      ?
    418 418      Ƣ                      ?                      ?
    419 419      ƣ                      ?                      ?
    420 420      Ƥ                      ?                      ?
    421 421      ƥ                      ?                      ?
    422 422      Ʀ                      ?                      ?
    423 423      Ƨ                      ?                      ?
    424 424      ƨ                      ?                      ?
    425 425      Ʃ                      ?                      ?
    426 426      ƪ                      ?                      ?
    427 427      ƫ                      ?                      ?
    428 428      Ƭ                      ?                      ?
    429 429      ƭ                      ?                      ?
    430 430      Ʈ                      ?                      ?
    431 431      Ư                      ?                      ?
    432 432      ư                      ?                      ?
    433 433      Ʊ                      ?                      ?
    434 434      Ʋ                      ?                      ?
    435 435      Ƴ                      ?                      ?
    436 436      ƴ                      ?                      ?
    437 437      Ƶ                      ?                      ?
    438 438      ƶ                      ?                      ?
    439 439      Ʒ                      ?                      ?
    440 440      Ƹ                      ?                      ?
    441 441      ƹ                      ?                      ?
    442 442      ƺ                      ?                      ?
    443 443      ƻ                      ?                      ?
    444 444      Ƽ                      ?                      ?
    445 445      ƽ                      ?                      ?
    446 446      ƾ                      ?                      ?
    447 447      ƿ                      ?                      ?
    448 448      ǀ                      ?                      ?
    449 449      ǁ                      ?                      ?
    450 450      ǂ                      ?                      ?
    451 451      ǃ                      ?                      ?
    452 452      Ǆ                      ?                      ?
    453 453      ǅ                      ?                      ?
    454 454      ǆ                      ?                      ?
    455 455      Ǉ                      ?                      ?
    456 456      ǈ                      ?                      ?
    457 457      ǉ                      ?                      ?
    458 458      Ǌ                      ?                      ?
    459 459      ǋ                      ?                      ?
    460 460      ǌ                      ?                      ?
    461 461      Ǎ                      ?                      ?
    462 462      ǎ                      ?                      ?
    463 463      Ǐ                      ?                      ?
    464 464      ǐ                      ?                      ?
    465 465      Ǒ                      ?                      ?
    466 466      ǒ                      ?                      ?
    467 467      Ǔ                      ?                      ?
    468 468      ǔ                      ?                      ?
    469 469      Ǖ                      ?                      ?
    470 470      ǖ                      ?                      ?
    471 471      Ǘ                      ?                      ?
    472 472      ǘ                      ?                      ?
    473 473      Ǚ                      ?                      ?
    474 474      ǚ                      ?                      ?
    475 475      Ǜ                      ?                      ?
    476 476      ǜ                      ?                      ?
    477 477      ǝ                      ?                      ?
    478 478      Ǟ                      ?                      ?
    479 479      ǟ                      ?                      ?
    480 480      Ǡ                      ?                      ?
    481 481      ǡ                      ?                      ?
    482 482      Ǣ                      ?                      ?
    483 483      ǣ                      ?                      ?
    484 484      Ǥ                      ?                      ?
    485 485      ǥ                      ?                      ?
    486 486      Ǧ                      ?                      ?
    487 487      ǧ                      ?                      ?
    488 488      Ǩ                      ?                      ?
    489 489      ǩ                      ?                      ?
    490 490      Ǫ                      ?                      ?
    491 491      ǫ                      ?                      ?
    492 492      Ǭ                      ?                      ?
    493 493      ǭ                      ?                      ?
    494 494      Ǯ                      ?                      ?
    495 495      ǯ                      ?                      ?
    496 496      ǰ                      ?                      ?
    497 497      Ǳ                      ?                      ?
    498 498      ǲ                      ?                      ?
    499 499      ǳ                      ?                      ?
    500 500      Ǵ                      ?                      ?
    501 501      ǵ                      ?                      ?
    502 502      Ƕ                      ?                      ?
    503 503      Ƿ                      ?                      ?
    504 504      Ǹ                      ?                      ?
    505 505      ǹ                      ?                      ?
    506 506      Ǻ                      ?                      ?
    507 507      ǻ                      ?                      ?
    508 508      Ǽ                      ?                      ?
    509 509      ǽ                      ?                      ?
    510 510      Ǿ                      ?                      ?
    511 511      ǿ                      ?                      ?

