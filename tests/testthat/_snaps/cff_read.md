# Test errors on cff_read

    Code
      cff_read(c("abcde", "b"))
    Condition
      Error in `cff_read()`:
      ! Use a single value, `path` has length 2

---

    Code
      cff_read("abcde")
    Condition
      Error in `file_exist_abort()`:
      ! 'abcde' doesn't exist. Check the '.' directory

# cff_read citation.cff

    Code
      cff_read_cff_citation("a")
    Condition
      Error in `file_exist_abort()`:
      ! 'a' doesn't exist. Check the '.' directory

# cff_read DESCRIPTION

    Code
      cff_read_description("a")
    Condition
      Error in `file_exist_abort()`:
      ! 'a' doesn't exist. Check the '.' directory

# cff_read bib

    Code
      cff_read_bib("a")
    Condition
      Error in `file_exist_abort()`:
      ! 'a' doesn't exist. Check the '.' directory

---

    Code
      d
    Output
      type: article
      title: 'cffr: Generate Citation File Format Metadata for R Packages'
      authors:
      - family-names: Hernangómez
        given-names: Diego
      year: '2021'
      journal: Journal of Open Source Software
      publisher:
        name: The Open Journal
      volume: '6'
      issue: '67'
      doi: 10.21105/joss.03900
      url: https://doi.org/10.21105/joss.03900
      copyright: All rights reserved
      notes: 'Publisher: The Open Journal'
      start: '3900'

# cff_read citation messages

    Code
      cff_read_citation("a")
    Condition
      Error in `file_exist_abort()`:
      ! 'a' doesn't exist. Check the '.' directory

---

    Code
      s <- cff_read(f, meta = "aa")
    Message
      ! `meta` should be "NULL" or a <packageDescription> object not a string. Using `meta = NULL`

# Creating cff from packages encoded in latin1

    Code
      cffobj
    Output
      cff-version: 1.2.0
      message: 'To cite package "surveillance" in publications use:'
      type: software
      license: GPL-2.0-only
      title: 'surveillance: Temporal and Spatio-Temporal Modeling and Monitoring of Epidemic
        Phenomena'
      version: 1.19.1
      abstract: Statistical methods for the modeling and monitoring of time series of counts,
        proportions and categorical data, as well as for the modeling of continuous-time
        point processes of epidemic phenomena. The monitoring methods focus on aberration
        detection in count data time series from public health surveillance of communicable
        diseases, but applications could just as well originate from environmetrics, reliability
        engineering, econometrics, or social sciences. The package implements many typical
        outbreak detection procedures such as the (improved) Farrington algorithm, or the
        negative binomial GLR-CUSUM method of Höhle and Paul (2008) <https://doi.org/10.1016/j.csda.2008.02.015>.
        A novel CUSUM approach combining logistic and multinomial logistic modeling is also
        included. The package contains several real-world data sets, the ability to simulate
        outbreak data, and to visualize the results of the monitoring in a temporal, spatial
        or spatio-temporal fashion. A recent overview of the available monitoring procedures
        is given by Salmon et al. (2016) <https://doi.org/10.18637/jss.v070.i10>. For the
        retrospective analysis of epidemic spread, the package provides three endemic-epidemic
        modeling frameworks with tools for visualization, likelihood inference, and simulation.
        hhh4() estimates models for (multivariate) count time series following Paul and
        Held (2011) <https://doi.org/10.1002/sim.4177> and Meyer and Held (2014) <https://doi.org/10.1214/14-AOAS743>.
        twinSIR() models the susceptible-infectious-recovered (SIR) event history of a fixed
        population, e.g, epidemics across farms or networks, as a multivariate point process
        as proposed by Höhle (2009) <https://doi.org/10.1002/bimj.200900050>. twinstim()
        estimates self-exciting point process models for a spatio-temporal point pattern
        of infective events, e.g., time-stamped geo-referenced surveillance data, as proposed
        by Meyer et al. (2012) <https://doi.org/10.1111/j.1541-0420.2011.01684.x>. A recent
        overview of the implemented space-time modeling frameworks for epidemic phenomena
        is given by Meyer et al. (2017) <https://doi.org/10.18637/jss.v077.i11>.
      authors:
      - family-names: Höhle
        given-names: Michael
        email: hoehle@math.su.se
        orcid: https://orcid.org/0000-0002-0423-6702
      - family-names: Meyer
        given-names: Sebastian
        email: seb.meyer@fau.de
        orcid: https://orcid.org/0000-0002-1791-9449
      - family-names: Paul
        given-names: Michaela
      repository: https://CRAN.R-project.org/package=surveillance
      url: https://surveillance.R-Forge.R-project.org/
      date-released: '2021-03-30'
      contact:
      - family-names: Meyer
        given-names: Sebastian
        email: seb.meyer@fau.de
        orcid: https://orcid.org/0000-0002-1791-9449
      references:
      - type: article
        title: 'Monitoring Count Time Series in R: Aberration Detection in Public Health
          Surveillance'
        authors:
        - family-names: Salmon
          given-names: Maëlle
        - family-names: Schumacher
          given-names: Dirk
        - family-names: Höhle
          given-names: Michael
        journal: Journal of Statistical Software
        year: '2016'
        volume: '70'
        issue: '10'
        doi: 10.18637/jss.v070.i10
        start: '1'
        end: '35'
      - type: article
        title: Spatio-Temporal Analysis of Epidemic Phenomena Using the R Package surveillance
        authors:
        - family-names: Meyer
          given-names: Sebastian
        - family-names: Held
          given-names: Leonhard
        - family-names: Höhle
          given-names: Michael
        journal: Journal of Statistical Software
        year: '2017'
        volume: '77'
        issue: '11'
        doi: 10.18637/jss.v077.i11
        start: '1'
        end: '55'

