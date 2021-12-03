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

        dec             latex_base             latex_cffr
    1     1                      ?                      ?
    2     2                      ?                      ?
    3     3                      ?                      ?
    4     4                      ?                      ?
    5     5                      ?                      ?
    6     6                      ?                      ?
    7     7                      ?                      ?
    8     8                      ?                      ?
    9     9                      ?                      ?
    10   10                      ?                      ?
    11   11                      ?                      ?
    12   12                      ?                      ?
    13   13                      ?                      ?
    14   14                      ?                      ?
    15   15                      ?                      ?
    16   16                      ?                      ?
    17   17                      ?                      ?
    18   18                      ?                      ?
    19   19                      ?                      ?
    20   20                      ?                      ?
    21   21                      ?                      ?
    22   22                      ?                      ?
    23   23                      ?                      ?
    24   24                      ?                      ?
    25   25                      ?                      ?
    26   26                      ?                      ?
    27   27                      ?                      ?
    28   28                      ?                      ?
    29   29                      ?                      ?
    30   30                      ?                      ?
    31   31                      ?                      ?
    32   32                                              
    33   33                      !                      !
    34   34                      "                      "
    35   35                      #                      #
    36   36                      $                      $
    37   37                      %                      %
    38   38                      &                      &
    39   39                      '                      '
    40   40                      (                      (
    41   41                      )                      )
    42   42                      *                      *
    43   43                      +                      +
    44   44                      ,                      ,
    45   45                      -                      -
    46   46                      .                      .
    47   47                      /                      /
    48   48                      0                      0
    49   49                      1                      1
    50   50                      2                      2
    51   51                      3                      3
    52   52                      4                      4
    53   53                      5                      5
    54   54                      6                      6
    55   55                      7                      7
    56   56                      8                      8
    57   57                      9                      9
    58   58                      :                      :
    59   59                      ;                      ;
    60   60                      <                      <
    61   61                      =                      =
    62   62                      >                      >
    63   63                      ?                      ?
    64   64                      @                      @
    65   65                      A                      A
    66   66                      B                      B
    67   67                      C                      C
    68   68                      D                      D
    69   69                      E                      E
    70   70                      F                      F
    71   71                      G                      G
    72   72                      H                      H
    73   73                      I                      I
    74   74                      J                      J
    75   75                      K                      K
    76   76                      L                      L
    77   77                      M                      M
    78   78                      N                      N
    79   79                      O                      O
    80   80                      P                      P
    81   81                      Q                      Q
    82   82                      R                      R
    83   83                      S                      S
    84   84                      T                      T
    85   85                      U                      U
    86   86                      V                      V
    87   87                      W                      W
    88   88                      X                      X
    89   89                      Y                      Y
    90   90                      Z                      Z
    91   91                      [                      [
    92   92                     \\                     \\
    93   93                      ]                      ]
    94   94                      ^                      ^
    95   95                      _                      _
    96   96                      `                      `
    97   97                      a                      a
    98   98                      b                      b
    99   99                      c                      c
    100 100                      d                      d
    101 101                      e                      e
    102 102                      f                      f
    103 103                      g                      g
    104 104                      h                      h
    105 105                      i                      i
    106 106                      j                      j
    107 107                      k                      k
    108 108                      l                      l
    109 109                      m                      m
    110 110                      n                      n
    111 111                      o                      o
    112 112                      p                      p
    113 113                      q                      q
    114 114                      r                      r
    115 115                      s                      s
    116 116                      t                      t
    117 117                      u                      u
    118 118                      v                      v
    119 119                      w                      w
    120 120                      x                      x
    121 121                      y                      y
    122 122                      z                      z
    123 123                      {                      {
    124 124                      |                      |
    125 125                      }                      }
    126 126                      ~                      ~
    127 127                      ?                      ?
    128 128                      ?                      ?
    129 129                      ?                      ?
    130 130                      ?                      ?
    131 131                      ?                      ?
    132 132                      ?                      ?
    133 133                      ?                      ?
    134 134                      ?                      ?
    135 135                      ?                      ?
    136 136                      ?                      ?
    137 137                      ?                      ?
    138 138                      ?                      ?
    139 139                      ?                      ?
    140 140                      ?                      ?
    141 141                      ?                      ?
    142 142                      ?                      ?
    143 143                      ?                      ?
    144 144                      ?                      ?
    145 145                      ?                      ?
    146 146                      ?                      ?
    147 147                      ?                      ?
    148 148                      ?                      ?
    149 149                      ?                      ?
    150 150                      ?                      ?
    151 151                      ?                      ?
    152 152                      ?                      ?
    153 153                      ?                      ?
    154 154                      ?                      ?
    155 155                      ?                      ?
    156 156                      ?                      ?
    157 157                      ?                      ?
    158 158                      ?                      ?
    159 159                      ?                      ?
    160 160       {\\nobreakspace}       {\\nobreakspace}
    161 161     {\\textexclamdown}     {\\textexclamdown}
    162 162           {\\textcent}           {\\textcent}
    163 163       {\\textsterling}       {\\textsterling}
    164 164       {\\textcurrency}       {\\textcurrency}
    165 165            {\\textyen}            {\\textyen}
    166 166      {\\textbrokenbar}      {\\textbrokenbar}
    167 167                  {\\S}                  {\\S}
    168 168                  \\"{}                  \\"{}
    169 169      {\\textcopyright}      {\\textcopyright}
    170 170    {\\textordfeminine}    {\\textordfeminine}
    171 171      {\\guillemotleft}      {\\guillemotleft}
    172 172           {\\textlnot}           {\\textlnot}
    173 173                    \\-                    \\-
    174 174     {\\textregistered}     {\\textregistered}
    175 175               {\\a={}}                {\\={}}
    176 176         {\\textdegree}         {\\textdegree}
    177 177             {\\textpm}             {\\textpm}
    178 178    {\\mathtwosuperior}    {\\mathtwosuperior}
    179 179  {\\maththreesuperior}  {\\maththreesuperior}
    180 180               {\\a'{}}                {\\'{}}
    181 181             {\\textmu}             {\\textmu}
    182 182                  {\\P}                  {\\P}
    183 183 {\\textperiodcentered} {\\textperiodcentered}
    184 184               {\\c\\ }               {\\c\\ }
    185 185    {\\mathonesuperior}    {\\mathonesuperior}
    186 186   {\\textordmasculine}   {\\textordmasculine}
    187 187     {\\guillemotright}     {\\guillemotright}
    188 188     {\\textonequarter}     {\\textonequarter}
    189 189        {\\textonehalf}        {\\textonehalf}
    190 190  {\\textthreequarters}  {\\textthreequarters}
    191 191   {\\textquestiondown}   {\\textquestiondown}
    192 192                {\\a`A}                 {\\`A}
    193 193                {\\a'A}                 {\\'A}
    194 194                 {\\^A}                 {\\^A}
    195 195                 {\\~A}                 {\\~A}
    196 196                 {\\"A}                 {\\"A}
    197 197                {\\r A}                {\\r A}
    198 198                 {\\AE}                 {\\AE}
    199 199                {\\c C}                {\\c C}
    200 200                {\\a`E}                 {\\`E}
    201 201                {\\a'E}                 {\\'E}
    202 202                 {\\^E}                 {\\^E}
    203 203                {\\a`I}                 {\\`I}
    204 204                {\\a'I}                 {\\'I}
    205 205                 {\\^I}                 {\\^I}
    206 206                 {\\~I}                 {\\~I}
    207 207                 {\\"I}                 {\\"I}
    208 208                 {\\DH}                 {\\DH}
    209 209                 {\\~N}                 {\\~N}
    210 210                {\\a`O}                 {\\`O}
    211 211                {\\a'O}                 {\\'O}
    212 212                 {\\^O}                 {\\^O}
    213 213                 {\\~O}                 {\\~O}
    214 214                 {\\"O}                 {\\"O}
    215 215          {\\texttimes}          {\\texttimes}
    216 216                  {\\O}                  {\\O}
    217 217                {\\a`U}                 {\\`U}
    218 218                {\\a'U}                 {\\'U}
    219 219                 {\\^U}                 {\\^U}
    220 220                 {\\"U}                 {\\"U}
    221 221                {\\a`Y}                 {\\`Y}
    222 222                 {\\TH}                 {\\TH}
    223 223                 {\\ss}                 {\\ss}
    224 224                {\\a`a}                 {\\`a}
    225 225                {\\a'a}                 {\\'a}
    226 226                 {\\^a}                 {\\^a}
    227 227                 {\\~a}                 {\\~a}
    228 228                 {\\"a}                 {\\"a}
    229 229                {\\r a}                {\\r a}
    230 230                 {\\ae}                 {\\ae}
    231 231                {\\c c}                {\\c c}
    232 232                {\\a`e}                 {\\`e}
    233 233                {\\a'e}                 {\\'e}
    234 234                 {\\^e}                 {\\^e}
    235 235                 {\\"e}                 {\\"e}
    236 236              {\\a`\\i}               {\\`\\i}
    237 237              {\\a'\\i}               {\\'\\i}
    238 238               {\\^\\i}               {\\^\\i}
    239 239               {\\"\\i}               {\\"\\i}
    240 240                 {\\dh}                 {\\dh}
    241 241                 {\\~n}                 {\\~n}
    242 242                {\\a`o}                 {\\`o}
    243 243                {\\a'o}                 {\\'o}
    244 244                 {\\^o}                 {\\^o}
    245 245                 {\\~o}                 {\\~o}
    246 246                 {\\"o}                 {\\"o}
    247 247            {\\textdiv}            {\\textdiv}
    248 248                  {\\o}                  {\\o}
    249 249                {\\a`u}                 {\\`u}
    250 250                {\\a'u}                 {\\'u}
    251 251                 {\\^u}                 {\\^u}
    252 252                 {\\"u}                 {\\"u}
    253 253                {\\a`y}                 {\\`y}
    254 254                 {\\th}                 {\\th}
    255 255                 {\\"y}                 {\\"y}
    256 256                      ?                      ?
    257 257                      ?                      ?
    258 258                {\\u A}                {\\u A}
    259 259                {\\u a}                {\\u a}
    260 260                {\\k A}                 {\\ A}
    261 261                {\\k a}                 {\\ a}
    262 262                {\\a'C}                 {\\'C}
    263 263                {\\a'c}                 {\\'c}
    264 264                      ?                      ?
    265 265                      ?                      ?
    266 266                      ?                      ?
    267 267                      ?                      ?
    268 268                {\\v C}                {\\v C}
    269 269                {\\v c}                {\\v c}
    270 270                {\\v D}                {\\v D}
    271 271                {\\v d}                {\\v d}
    272 272                 {\\DJ}                 {\\DJ}
    273 273                 {\\dj}                 {\\dj}
    274 274                      ?                      ?
    275 275                      ?                      ?
    276 276                      ?                      ?
    277 277                      ?                      ?
    278 278                      ?                      ?
    279 279                      ?                      ?
    280 280                {\\k E}                 {\\ E}
    281 281                {\\k e}                 {\\ e}
    282 282                {\\v E}                {\\v E}
    283 283                {\\v e}                {\\v e}
    284 284                      ?                      ?
    285 285                      ?                      ?
    286 286                {\\u G}                {\\u G}
    287 287                {\\u g}                {\\u g}
    288 288                      ?                      ?
    289 289                      ?                      ?
    290 290                      ?                      ?
    291 291                      ?                      ?
    292 292                      ?                      ?
    293 293                      ?                      ?
    294 294                      ?                      ?
    295 295                      ?                      ?
    296 296                      ?                      ?
    297 297                      ?                      ?
    298 298                      ?                      ?
    299 299                      ?                      ?
    300 300                      ?                      ?
    301 301                      ?                      ?
    302 302                      ?                      ?
    303 303                      ?                      ?
    304 304                 {\\.I}                 {\\.I}
    305 305                  {\\i}                  {\\i}
    306 306                      ?                      ?
    307 307                      ?                      ?
    308 308                      ?                      ?
    309 309                      ?                      ?
    310 310                      ?                      ?
    311 311                      ?                      ?
    312 312                      ?                      ?
    313 313                {\\a'L}                 {\\'L}
    314 314                {\\a'l}                 {\\'l}
    315 315                      ?                      ?
    316 316                      ?                      ?
    317 317                {\\v L}                {\\v L}
    318 318                {\\v l}                {\\v l}
    319 319                      ?                      ?
    320 320                      ?                      ?
    321 321                  {\\L}                  {\\L}
    322 322                  {\\l}                  {\\l}
    323 323                {\\a'N}                 {\\'N}
    324 324                {\\a'n}                 {\\'n}
    325 325                      ?                      ?
    326 326                      ?                      ?
    327 327                {\\v N}                {\\v N}
    328 328                {\\v n}                {\\v n}
    329 329                      ?                      ?
    330 330                 {\\NG}                 {\\NG}
    331 331                 {\\ng}                 {\\ng}
    332 332                      ?                      ?
    333 333                      ?                      ?
    334 334                      ?                      ?
    335 335                      ?                      ?
    336 336                {\\H O}                {\\H O}
    337 337                {\\H o}                {\\H o}
    338 338                 {\\OE}                 {\\OE}
    339 339                 {\\oe}                 {\\oe}
    340 340                {\\a'R}                 {\\'R}
    341 341                {\\a'r}                 {\\'r}
    342 342                      ?                      ?
    343 343                      ?                      ?
    344 344                {\\v R}                {\\v R}
    345 345                {\\v r}                {\\v r}
    346 346                {\\a'S}                 {\\'S}
    347 347                {\\a's}                 {\\'s}
    348 348                      ?                      ?
    349 349                      ?                      ?
    350 350                {\\c S}                {\\c S}
    351 351                {\\c s}                {\\c s}
    352 352                {\\v S}                {\\v S}
    353 353                {\\v s}                {\\v s}
    354 354                {\\c T}                {\\c T}
    355 355                {\\c t}                {\\c t}
    356 356                {\\v T}                {\\v T}
    357 357                {\\v t}                {\\v t}
    358 358                      ?                      ?
    359 359                      ?                      ?
    360 360                      ?                      ?
    361 361                      ?                      ?
    362 362                      ?                      ?
    363 363                      ?                      ?
    364 364                      ?                      ?
    365 365                      ?                      ?
    366 366                {\\r U}                {\\r U}
    367 367                {\\r u}                {\\r u}
    368 368                {\\H U}                {\\H U}
    369 369                {\\H u}                {\\H u}
    370 370                      ?                      ?
    371 371                      ?                      ?
    372 372                      ?                      ?
    373 373                      ?                      ?
    374 374                      ?                      ?
    375 375                      ?                      ?
    376 376                 {\\"Y}                 {\\"Y}
    377 377                {\\a'Z}                 {\\'Z}
    378 378                {\\a'z}                 {\\'z}
    379 379                 {\\.Z}                 {\\.Z}
    380 380                 {\\.z}                 {\\.z}
    381 381                {\\v Z}                {\\v Z}
    382 382                {\\v z}                {\\v z}
    383 383                      ?                      ?
    384 384                      ?                      ?
    385 385                      ?                      ?
    386 386                      ?                      ?
    387 387                      ?                      ?
    388 388                      ?                      ?
    389 389                      ?                      ?
    390 390                      ?                      ?
    391 391                      ?                      ?
    392 392                      ?                      ?
    393 393                      ?                      ?
    394 394                      ?                      ?
    395 395                      ?                      ?
    396 396                      ?                      ?
    397 397                      ?                      ?
    398 398                      ?                      ?
    399 399                      ?                      ?
    400 400                      ?                      ?
    401 401                      ?                      ?
    402 402         {\\textflorin}         {\\textflorin}
    403 403                      ?                      ?
    404 404                      ?                      ?
    405 405                      ?                      ?
    406 406                      ?                      ?
    407 407                      ?                      ?
    408 408                      ?                      ?
    409 409                      ?                      ?
    410 410                      ?                      ?
    411 411                      ?                      ?
    412 412                      ?                      ?
    413 413                      ?                      ?
    414 414                      ?                      ?
    415 415                      ?                      ?
    416 416                      ?                      ?
    417 417                      ?                      ?
    418 418                      ?                      ?
    419 419                      ?                      ?
    420 420                      ?                      ?
    421 421                      ?                      ?
    422 422                      ?                      ?
    423 423                      ?                      ?
    424 424                      ?                      ?
    425 425                      ?                      ?
    426 426                      ?                      ?
    427 427                      ?                      ?
    428 428                      ?                      ?
    429 429                      ?                      ?
    430 430                      ?                      ?
    431 431                      ?                      ?
    432 432                      ?                      ?
    433 433                      ?                      ?
    434 434                      ?                      ?
    435 435                      ?                      ?
    436 436                      ?                      ?
    437 437                      ?                      ?
    438 438                      ?                      ?
    439 439                      ?                      ?
    440 440                      ?                      ?
    441 441                      ?                      ?
    442 442                      ?                      ?
    443 443                      ?                      ?
    444 444                      ?                      ?
    445 445                      ?                      ?
    446 446                      ?                      ?
    447 447                      ?                      ?
    448 448                      ?                      ?
    449 449                      ?                      ?
    450 450                      ?                      ?
    451 451                      ?                      ?
    452 452                      ?                      ?
    453 453                      ?                      ?
    454 454                      ?                      ?
    455 455                      ?                      ?
    456 456                      ?                      ?
    457 457                      ?                      ?
    458 458                      ?                      ?
    459 459                      ?                      ?
    460 460                      ?                      ?
    461 461                      ?                      ?
    462 462                      ?                      ?
    463 463                      ?                      ?
    464 464                      ?                      ?
    465 465                      ?                      ?
    466 466                      ?                      ?
    467 467                      ?                      ?
    468 468                      ?                      ?
    469 469                      ?                      ?
    470 470                      ?                      ?
    471 471                      ?                      ?
    472 472                      ?                      ?
    473 473                      ?                      ?
    474 474                      ?                      ?
    475 475                      ?                      ?
    476 476                      ?                      ?
    477 477                      ?                      ?
    478 478                      ?                      ?
    479 479                      ?                      ?
    480 480                      ?                      ?
    481 481                      ?                      ?
    482 482                      ?                      ?
    483 483                      ?                      ?
    484 484                      ?                      ?
    485 485                      ?                      ?
    486 486                      ?                      ?
    487 487                      ?                      ?
    488 488                      ?                      ?
    489 489                      ?                      ?
    490 490                      ?                      ?
    491 491                      ?                      ?
    492 492                      ?                      ?
    493 493                      ?                      ?
    494 494                      ?                      ?
    495 495                      ?                      ?
    496 496                      ?                      ?
    497 497                      ?                      ?
    498 498                      ?                      ?
    499 499                      ?                      ?
    500 500                      ?                      ?
    501 501                      ?                      ?
    502 502                      ?                      ?
    503 503                      ?                      ?
    504 504                      ?                      ?
    505 505                      ?                      ?
    506 506                      ?                      ?
    507 507                      ?                      ?
    508 508                      ?                      ?
    509 509                      ?                      ?
    510 510                      ?                      ?
    511 511                      ?                      ?

