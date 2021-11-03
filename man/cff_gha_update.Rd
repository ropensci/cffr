% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cff_gha_update.R
\name{cff_gha_update}
\alias{cff_gha_update}
\title{Install a cffr GitHub Action}
\usage{
cff_gha_update(path = ".", overwrite = FALSE)
}
\arguments{
\item{path}{Project directory}

\item{overwrite}{If already present, do you want to overwrite your action?}
}
\value{
Invisible, this function is called by its side effects.
}
\description{
This function would install a GitHub Action on your repo. The action
will update your \code{CITATION.cff} when any of these events occur:
\itemize{
\item You publish a new release of the package.
\item Your DESCRIPTION or inst/CITATION are modified.
\item The action can be run also manually.
}
}
\details{
Triggers on your action can be modified, see
\href{https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows}{Events that trigger workflows}.
}
\examples{
\dontrun{
cff_gha_update()
}
}