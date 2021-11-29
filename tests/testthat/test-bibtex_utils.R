# test_that("Bibtex Article", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["article"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex Book", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["book"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex Booklet", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["booklet"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex Conference", {
#   # Note: R does not support natively this entry type
#   # However this is similar to InProceedings, see bibtex standard  0.99b
#   # https://osl.ugr.es/CTAN/biblio/bibtex/contrib/doc/btxdoc.pdf:
#   # conference The same as INPROCEEDINGS, included for Scribe compatibility.
#
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["conference"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
#
# test_that("Bibtex Book", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["book"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex InBook", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["inbook"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
#
# test_that("Bibtex InCollection", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["incollection"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex InProceedings", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["inproceedings"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
#
# test_that("Bibtex Manual", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["manual"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex MastersThesis", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["mastersthesis"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
#
# test_that("Bibtex Misc", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["misc"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex PhDThesis", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["phdthesis"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex Proceedings", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["proceedings"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
#
# test_that("Bibtex TechReport", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["techreport"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
#
# test_that("Bibtex Unpublished", {
#   skip_if_not_installed("bibtex")
#
#   # Read
#   all <-
#     bibtex::read.bib(system.file("examples/bibtex_test.bib", package = "cffr"))
#
#   bib <- all["unpublished"]
#   bibparsed <- cff_parse_citation(bib)
#
#   expect_snapshot_output(bibparsed)
#
#   cffobj <- cff_create(cff(),
#     keys = list(references = list(bibparsed))
#   )
#
#   expect_true(cff_validate(cffobj, verbose = FALSE))
# })
