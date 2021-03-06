% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/status.r
\docType{methods}
\name{status}
\alias{status}
\alias{status,git_repository-method}
\title{Status}
\usage{
status(repo, staged = TRUE, unstaged = TRUE, untracked = TRUE,
  ignored = FALSE, verbose = TRUE)

\S4method{status}{git_repository}(repo, staged = TRUE, unstaged = TRUE,
  untracked = TRUE, ignored = FALSE, verbose = TRUE)
}
\arguments{
\item{repo}{The \code{git_repository} to get status from.}

\item{staged}{Include staged files. Default TRUE.}

\item{unstaged}{Include unstaged files. Default TRUE.}

\item{untracked}{Include untracked files. Default TRUE.}

\item{ignored}{Include ignored files. Default FALSE.}

\item{verbose}{Display status. Default TRUE.}
}
\value{
invisible(list) with repository status
}
\description{
Display state of the repository working directory and the staging
area.
}
\examples{
\dontrun{
## Initialize a repository
path <- tempfile(pattern="git2r-")
dir.create(path)
repo <- init(path)

## Config user
config(repo, user.name="User", user.email="user@example.org")

## Create a file
writeLines("Hello world!", file.path(path, "test.txt"))

## Check status; untracked file
status(repo)

## Add file
add(repo, "test.txt")

## Check status; staged file
status(repo)

## Commit
commit(repo, "First commit message")

## Check status; clean
status(repo)

## Change the file
writeLines(c("Hello again!", "Here is a second line", "And a third"),
           file.path(path, "test.txt"))

## Check status; unstaged file
status(repo)

## Add file and commit
add(repo, "test.txt")
commit(repo, "Second commit message")

## Check status; clean
status(repo)
}
}
\keyword{methods}

