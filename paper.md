---
title: 'cffr: Generate Citation File Format Metadata for R Packages'
tags:
  - R
  - cff
  - citation
  - credit
  - metadata
authors:
  - name: Diego Hernangómez
    orcid: 0000-0001-8457-4658
    affiliation: 1
affiliations:
 - name: Independent Researcher
   index: 1
date: 08 Nov 2021
bibliography: paper.bib
---

# Summary

The Citation File Format project [@druskat_citation_2021] defines a standardized
format for providing software or datasets citation metadata in plaintext files
that are easy to read by both humans and machines.

This metadata format is being adopted by GitHub as the primary format for its
built-in citation support [@github_about_citation]. Other leading archives for
scientific software, including Zenodo and Zotero [@druskat_stephan_making_2021],
have included as well support for CITATION.cff files in their GitHub
integration.

The cffr package provides utilities to generate and validate these CITATION.cff
files automatically for R [@R_2021] packages by parsing the DESCRIPTION file and
the native R citation file. The package also includes utilities and examples for
parsing components as persons and additional citations, as well as several
vignettes which illustrate both the basic usage of the package as well as some
more technical details about the metadata extraction process.

# Statement of need

Citation of research software on research project is often omitted [@salmon2021]
. Among many reasons why software is not cited, one is the lack of a clear
citation information from package developers.

Some of the main reasons for citing software used on research are:

1.  **Reproducibility**: Software and their versions are important information
    to include in any research project. It helps peers to understand and
    reproduce effectively the results of any work. Including versions is also
    crucial as a way of recording the context of your manuscript when software
    changes.
2.  **Developer Credit:** On the context of Free and Open Source Software
    (FOSS), many of the software developers themselves are also researches.
    Receive credit for software development shouldn't be different from the
    credit received on other formats, as books or articles.

CITATION.cff files provides a clear citation rules for software. The format is
easily readable by humans and also can be parsed by appropriate software. The
adoption of GitHub of this format sends a strong message that research software
is something worthy of citation, and therefore deserves credit.

The cffr package allow R software developers to create CITATION.cff files from
the metadata already included on the package. Additionally, the package also
include validation tools via the jsonvalidate package [@jsonvalidate2021], that
allow developers to assess the validity of the file created using the latest CFF
schema.json.

# Acknowledgements

I would like to thank Carl Boettiger, Maëlle Salmon and the rest of contributors
of the codemetar [@codemetar2021] package. This package was the primary
inspiration for developing cffr and shares a common goal of increasing awareness
on the efforts of software developers.

I would like also to thank João Martins and Scott Chamberlain for thorough
reviews, that helps improving the package and the documentation as well as Emily
Riederer for handling the review process on rOpenSci.

# References
