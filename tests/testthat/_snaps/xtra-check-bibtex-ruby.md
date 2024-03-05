# preferred-citation-book-missing

    Code
      s <- as_bibentry(x)
    Message
      x Can't convert to `bibentry()`: 
      i A bibentry of bibtype 'Book' has to specify the field: publisher
      ! Returning empty <bibentry>

# preferred-citation-book

    Code
      toBibtex(bib)
    Output
      @Book{bueler:2021,
        title = {PETSc for Partial Differential Equations: Numerical Solutions in C and Python},
        author = {Ed Bueler},
        year = {2021},
        publisher = {SIAM Press},
        address = {Philadelphia},
        isbn = {978111976304},
        url = {https://github.com/bueler/p4pdes},
      }

# preferred-citation-conference-paper-2

    Code
      toBibtex(bib)
    Output
      @InProceedings{gamblin_etall:2016,
        title = {The Spack Package Manager: Bringing Order to HPC Software Chaos},
        author = {Todd Gamblin and Matthew LeGendre and Michael R. Collette and Gregory L. Lee and Adam Moody and Bronis R. {de Supinski} and Scott Futral},
        year = {2016},
        month = {dec},
        booktitle = {Proceedings of Supercomputing 2015},
        publisher = {ACM/IEEE},
        address = {Austin, Texas, USA},
        doi = {10.1244/2886907.2879400},
      }

# preferred-citation-conference-paper-missing

    Code
      toBibtex(bib)
    Output
      @InProceedings{gamblin_etall:2015,
        title = {The Spack Package Manager: Bringing Order to HPC Software Chaos},
        author = {Todd Gamblin and Matthew LeGendre and Michael R. Collette and Gregory L. Lee and Adam Moody and Bronis R. {de Supinski} and Scott Futral},
        year = {2015},
        month = {nov},
        booktitle = {Proceedings of Supercomputing 2015},
        doi = {10.1244/2886907.2879400},
      }

# preferred-citation-conference-paper

    Code
      toBibtex(bib)
    Output
      @InProceedings{rampin_etall:2016,
        title = {ReproZip: Computational Reproducibility With Ease},
        author = {Rémi Rampin and Juliana Freire and Fernando Chirigati and Dennis Shasha},
        year = {2016},
        month = {jun},
        booktitle = {Proceedings of the 2016 ACM SIGMOD International Conference on Management of Data (SIGMOD)},
        publisher = {ACM},
        address = {San Francisco, US},
        pages = {2085--2088},
        doi = {10.1145/2882903.2899401},
        date = {2016-06-26},
      }

# preferred-citation-manual

    Code
      toBibtex(bib)
    Output
      @Manual{hernangomez:2021,
        title = {cffr: Generate Citation File Format ('cff') Metadata for R Packages},
        author = {Diego Hernangómez},
        year = {2021},
        doi = {10.5281/zenodo.5509766},
        url = {https://dieghernan.github.io/cffr/},
      }

# preferred-citation-no-month

    Code
      toBibtex(bib)
    Output
      @Article{lisa:2021,
        title = {My awesome research software},
        author = {Mona Lisa},
        year = {2021},
        journal = {Journal Title},
      }

# preferred-citation-no-vol

    Code
      toBibtex(bib)
    Output
      @Article{hartmann_etall:2020,
        title = {An image-based data-driven analysis of cellular architecture in a developing tissue},
        author = {Jonas Hartmann and Mie Wong and Elisa Gallo and Darren Gilmour},
        year = {2020},
        journal = {eLife},
        pages = {888},
        doi = {10.7554/eLife.55913},
        url = {https://elifesciences.org/articles/55913},
      }

# preferred-citation-pamphlet

    Code
      toBibtex(bib)
    Output
      @Booklet{haines:2021,
        title = {Why and how to use CFF},
        author = {Robert Haines},
        year = {2021},
        month = {sep},
        doi = {10.5281/zenodo.1184077},
        url = {https://github.com/citation-file-format/ruby-cff},
      }

# preferred-citation-report-no-institution

    Code
      toBibtex(bib)
    Output
      @TechReport{haines:2021,
        title = {The benefits of using CFF files},
        author = {Robert Haines},
        year = {2021},
        month = {sep},
        doi = {10.5281/zenodo.1184077},
        url = {https://github.com/citation-file-format/ruby-cff},
        institution = {The University of Manchester},
      }

# preferred-citation-report

    Code
      toBibtex(bib)
    Output
      @TechReport{haines:2021,
        title = {The benefits of using CFF files},
        author = {Robert Haines},
        year = {2021},
        month = {sep},
        doi = {10.5281/zenodo.1184077},
        url = {https://github.com/citation-file-format/ruby-cff},
        institution = {The CFF Institute},
      }

# preferred-citation-unpublished

    Code
      toBibtex(bib)
    Output
      @Unpublished{haines:2021,
        title = {Why and how to use CFF},
        author = {Robert Haines},
        year = {2021},
        month = {sep},
        doi = {10.5281/zenodo.1184077},
        url = {https://github.com/citation-file-format/ruby-cff},
        note = {Self-published by the author.},
      }

# reprozip

    Code
      toBibtex(bib)
    Output
      @Proceedings{rampin_etall:2016,
        title = {ReproZip: Computational Reproducibility With Ease},
        author = {Remi Rampin and Juliana Freire and Fernando Chirigati and Dennis Shasha},
        year = {2016},
        month = {jun},
        address = {San Francisco, US},
        doi = {10.1145/2882903.2899401},
        abstract = {We present ReproZip, the recommended packaging tool for the SIGMOD Reproducibility Review. ReproZip was designed to simplify the process of making an existing computational experiment reproducible across platforms, even when the experiment was put together without reproducibility in mind. The tool creates a self-contained package for an experiment by automatically tracking and identifying all its required dependencies. The researcher can share the package with others, who can then use ReproZip to unpack the experiment, reproduce the findings on their favorite operating system, as well as modify the original experiment for reuse in new research, all with little effort. The demo will consist of examples of non-trivial experiments, showing how these can be packed in a Linux machine and reproduced on different machines and operating systems. Demo visitors will also be able to pack and reproduce their own experiments.},
        date = {2016-06-26},
      }

# smith-et-al

    Code
      toBibtex(bib)
    Output
      @Article{smith_etall:2016,
        title = {Software citation principles},
        author = {A. M. Smith and D. S. Katz and K. E. Niemeyer and {FORCE11 Software Citation Working Group}},
        year = {2016},
        month = {sep},
        journal = {PeerJ Computer Science},
        volume = {2},
        number = {123},
        pages = {e86},
        doi = {10.7717/peerj-cs.86},
      }

# tidyverse-joss-paper

    Code
      toBibtex(bib)
    Output
      @Article{wickham:2019,
        title = {Welcome to the Tidyverse},
        author = {Hadley Wickham},
        year = {2019},
        month = {nov},
        journal = {Journal of Open Source Software},
        volume = {4},
        number = {43},
        pages = {1686},
        doi = {10.21105/joss.01686},
      }

