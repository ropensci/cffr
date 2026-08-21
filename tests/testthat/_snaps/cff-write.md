# Add new keys

    Code
      s
    Output
      cff-version: 1.2.0
      message: This overwrites fields
      type: software
      license: GPL-3.0-only
      title: 'basicdesc: A Basic Description'
      version: 0.1.6
      abstract: New abstract
      authors:
      - family-names: Nadie
        given-names: Don
      repository-code: https://github.com/basic/package
      url: https://basic.github.io/package
      date-released: '1900-01-01'
      contact:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com
      keywords:
      - A
      - new
      - list
      - of
      - keywords

# Append keys

    Code
      desc_file
    Output
      cff-version: 1.2.0
      message: 'To cite package "basicdesc" in publications use:'
      type: software
      license: GPL-3.0-only
      title: 'basicdesc: A Basic Description'
      version: 0.1.6
      abstract: A very basic description. Should parse without problems.
      authors:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com
      repository-code: https://github.com/basic/package
      url: https://basic.github.io/package
      contact:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com

---

    Code
      s
    Output
      cff-version: 1.2.0
      message: 'To cite package "basicdesc" in publications use:'
      type: software
      license: GPL-3.0-only
      title: 'basicdesc: A Basic Description'
      version: 0.1.6
      abstract: A very basic description. Should parse without problems.
      authors:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com
      - family-names: author
        given-names: New
        website: https://stackoverflow.com/
        country: IT
      repository-code: https://github.com/basic/package
      url: https://basic.github.io/package
      contact:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com

# cff_write creates and updates inst/CITATION in a mock package

    Code
      auto_cit1
    Output
      Basic M (????). "manyurls: A lot of urls."
      <https://test.github.io/package/>.
      
      A BibTeX entry for LaTeX users is
      
        @Misc{basic,
          title = {manyurls: A lot of urls},
          author = {Marc Basic},
          url = {https://test.github.io/package/},
          abstract = {This package has many urls. Specifically, 1 Bug Reports and 6 URLs. Expected is to have 1 repository-code, 1 url and 3 URLs, since there is 1 duplicate and 1 invalid url.},
          version = {0.1.6},
        }

---

    Code
      auto_cit3
    Output
      Basic M (????). "manyurls: A lot of urls."
      <https://test.github.io/package/>.
      
      A BibTeX entry for LaTeX users is
      
        @Misc{basic,
          title = {manyurls: A lot of urls},
          author = {Marc Basic},
          url = {https://test.github.io/package/},
          abstract = {This package has many urls. Specifically, 1 Bug Reports and 6 URLs. Expected is to have 1 repository-code, 1 url and 3 URLs, since there is 1 duplicate and 1 invalid url.},
          version = {1.0.0},
        }

