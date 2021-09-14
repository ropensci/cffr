# Add wrong field to citation

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: My Research Software
    authors:
    - family-names: Druskat
      given-names: Stephan
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
    - family-names: Druskat
      given-names: Stephan
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
    - family-names: Druskat
      given-names: Stephan
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

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: My Research Software
    authors:
    - family-names: Druskat
      given-names: Stephan
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

# Article

    type: article
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    journal: JOSS

# Book

    type: book
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    month: '8'
    publisher:
      name: Graham Hill

# InBook

    type: book
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    month: '8'
    publisher:
      name: Graham Hill

# InCollection

    type: generic
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    month: '8'
    publisher:
      name: Graham Hill

# InProceedings

    type: proceedings
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    month: '8'

# Manual

    type: manual
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    month: '8'

# MastersThesis

    type: thesis
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    month: '8'

# PhdThesis

    type: thesis
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    month: '8'

# Proceedings

    type: proceedings
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    month: '8'

# TechReport

    type: report
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    institution:
      name: MIT
    month: '8'

# Unpublished

    type: unpublished
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'

# Parse persons on CITATION

    type: manual
    title: A Language and Environment for Statistical Computing
    authors:
    - name: R Core Team
    year: '2021'
    contact:
    - family-names: name
      given-names: A
    conference:
      name: A conference
    database-provider:
      name: Database provider
    editors:
    - family-names: editor
      given-names: A
    editors-series:
    - family-names: series
      given-names: A editor
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

