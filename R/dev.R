#' options(repos = c(
#'   ropensci = "https://ropensci.r-universe.dev",
#'   CRAN = "https://cloud.r-project.org"
#' ))
#'
#' # Install some packages
#' install.packages("rrricanes")
#'
#' devtools::load_all()
#' test_local()
#'
#'
#' usethis::use_r("bibtex")
#' s <- "a\bc"
#'
#'
#' gsub("\\\*","", s)
#'
#' ff <- cff_create("rrricanes")
#' cff_validate(ff)
#'
#' s <- enc2utf8("ñ")
#' as.raw(s)
#' intt("o")
#'
#'
#' range <- 1:511
#'
#' df_encoded <- data.frame(ascii_value = range,
#'                      utf8=intToUtf8(range, multiple = TRUE))
#'
#' df_encoded$latex <- encoded_text_to_latex(df_encoded$utf8, encoding = "UTF-8")
#'
#'
#'
#'                      latex = encoded_text_to_latex(df, encoding = "UTF-8"))
#'
#' utf_to_latex <- function(x ="An example of this"){
#'
#'   encoded <- enc2utf8(x)
#'   out <- encoded_text_to_latex(encoded, encoding = "UTF-8")
#'   out <- gsub("(?<=\\\\)a(?=[[:punct:]])", "", out, perl = TRUE)
#'   out
#'
#' }
#'
#' int_to_latex <- function(x =192:511){
#'
#'   encoded <- intToUtf8(x)
#'   out <- encoded_text_to_latex(encoded, encoding = "UTF-8")
#'   out <- gsub("(?<=\\\\)a(?=[[:punct:]])", "", out, perl = TRUE)
#'   out
#'
#' }
#'
#' f <- enc2utf8("Hernangómez")
#' encoded_text_to_latex(f, encoding = "UTF-8")
#'
#' title <- intToUtf8(191:511, multiple = TRUE)
#'
#'
#' strange_text <- bibentry("Article",
#'   key = "crazyexample",
#'   author = person(
#'     "Diego",
#'     utf_to_latex("Hernangómez")
#'   ),
#'   title = paste("{",
#'     utf_to_latex(title), "}",
#'     collapse = " "
#'   ),
#'   journal = "Some journal",
#'   year = 2022
#' )
#'
#' devtools::install()
#' class(citation("mapSpain"))
#' RefManageR::w
#'
#' strange_text_utf8 <- bibentry("Article",
#'   key = "notencoded",
#'   author = person(
#'     "Daniel",
#'     "Hernangómez"
#'   ),
#'   title = paste("{",
#'     enc2utf8(title), "}",
#'     collapse = " "
#'   ),
#'   journal = "Some journal",
#'   year = 2021
#' )
#'
#' s <- toBibtex(c(strange_text, strange_text_utf8))
#' print(s, con=file("example.bib", encoding = "UTF-8"))
#'
#' writel
#'
#' f <- intToUtf8(169)
#' f_enc <- enc2utf8(f)
#' encoded_text_to_latex(f_enc)
#'
#' a <- as.integer(charToRaw("Hernangómez Herrero, Diego"))
#' a
#' intToUtf8(a)
#'
#'
#' s <- citation("Article",
#'               )
#'
#'
#' a > 127
#' as.integer(a)
#'
#' raw
#'
#' letter <- enc2utf8("ñ")
#' s <- iconv(letter,"UTF-8", to="latin1", toRaw = FALSE)
#' sum(s)
#'
#'
#' strange_citation <-
#'
#' utf_to_latex("Diego Hernangómez")
#'
#' #' #'
#' #'
#' #' # Reading .bib files
#' #'
#' #' file <- system.file("examples/bibtex_example.bib",
#' #'  package = "cffr")
#' #' parsed <- cff_read_bib(file)
#' #'
#' #'
#' #' print(parsed, bibtex = TRUE)
#' #'
#' #' # Compare with the file
#' #' cat(readLines(file), sep = "\n")
#' #'
#' #' # To cffr citation
#' #'
#' #' cff_parse_citation(parsed)
#'
#'
#' knitr::write_bib("mapSpain", tweak = TRUE, file="a.bib")
#'
#' x <- "ababba ass z"
#' splits <- strsplit(x, "")[[1]]
#' firstchar <- splits[1]
#' lastchar <- rev(splits)[1]
#'
#'
#'
#'
#'
#' s1 <-enc2utf8("ó")
#' s <- encoded_text_to_latex(s1, encoding = "UTF-8")
#'
#' s2 <- parseLatex("á")
#' deparseLatex(s2)
#'
#' intToUtf8(138)
#'
#' x <- rawToChar(as.raw(160:512), multiple = TRUE)
#' x
#'
#' enco
#'
#' library(stringi)
#'
#'
#' f2 = encoded_text_to_latex("Hernangómez Ñ ö a \\af \\a-")
#' see <- function(rx) stringr::str_view_all(f2, rx)
#'
#' gsubf2
#'
#' f2
#' cat(gsub("(?<=\\\\)a(?=[[:punct:]])", "", f2, perl = TRUE))
#'
#' ss <- cff_read_bib("inst/examples/bibtex_ascii.bib")
#' lt <- toBibtex(ss)
#' l <- toBibtex(ss, file("mask_utf2.bib",  encoding = "UTF-8"))
#' print(l, prefix = "aaanana", con =file("mask_utf22.bib",  encoding = "UTF-8") )
#'
#' ff <- tools::parseLatex(lt)
#' tools::deparseLatex(lt)
#' lt
#' futf <- file("mask_utf.bib",  encoding = "UTF-8")
#' writeLines(l,futf)
#' close(futf)
#'
#' s <- "Hernangómezöôñçẞ"
#' f2 <- tools::encoded_text_to_latex(s, "UTF-8")
#' f2
#' s <- c(1:9, LETTERS, letters, "~")
#' s
#'
#' utf8ToInt(paste(s, collapse = ""))
#'
#'
#' x = "rrricanes"
#' ff <- citation(x)
#' s <- ff$url
#' s
#'
#' rege
#'
#'
#' strsplit(s, "\\n")
