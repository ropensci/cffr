# Article

    Code
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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

---

    Code
      toBibtex(bib)
    Output
      @InProceedings{oaho_etall:1983,
        title = {On Notions of Information Transfer in VLSI Circuits},
        author = {Alfred V. Oaho and Jeffrey D. Ullman and Mihalis Yannakakis},
        year = {1983},
        booktitle = {I Am a conference},
        publisher = {Academic Press},
        address = {Boston},
        editor = {Wizard V. Oz and Mihalis Yannakakis},
        volume = {41},
        number = {17},
        pages = {133--139},
        note = {Example modified for testing purposes},
        organization = {ACM},
      }

# Manual

    Code
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
    Output
      - type: unpublished
        title: Demonstratives
        authors:
        - family-names: Kaplan
          given-names: D.
        notes: Unpublished manuscript, UCLA
        year: '1977'
        month: '8'

---

    Code
      toBibtex(bib)
    Output
      @Unpublished{kaplan:1977,
        title = {Demonstratives},
        author = {D. Kaplan},
        year = {1977},
        month = {aug},
        note = {Extracted with cffr R package},
      }

# InBook with booktitle

    Code
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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
      bib_cff
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

# Duplicate entries

    Code
      bib_cff <- as_cff(rep(bib, 2))
    Message
      i Removing duplicate <bibentry> objects.

# Identifiers and dois

    Code
      as_cff(checf)
    Output
      url: https://www.R-project.org/
      doi: 10.5281/zenodo.5366600
      identifiers:
      - type: doi
        value: 10.5281/zenodo.5366601
      - type: doi
        value: 10.5281/zenodo.5366602
      - type: url
        value: https://google.com/

---

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

