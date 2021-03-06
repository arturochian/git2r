% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/blame.r
\docType{methods}
\name{blame}
\alias{blame}
\alias{blame,git_repository,character-method}
\title{Get blame for file}
\usage{
blame(repo, path)

\S4method{blame}{git_repository,character}(repo, path)
}
\arguments{
\item{repo}{The repository}

\item{path}{Path to the file to consider}
}
\value{
S4 class git_blame object
}
\description{
Get blame for file
}
\examples{
\dontrun{
## Initialize a temporary repository
path <- tempfile(pattern="git2r-")
dir.create(path)
repo <- init(path)

## Create a first user and commit a file
config(repo, user.name="User One", user.email="user.one@example.org")
writeLines("Hello world!", file.path(path, "example.txt"))
add(repo, "example.txt")
commit(repo, "First commit message")

## Create a second user and change the file
config(repo, user.name="User Two", user.email="user.two@example.org")
writeLines(c("Hello world!", "HELLO WORLD!", "HOLA"),
           file.path(path, "example.txt"))
add(repo, "example.txt")
commit(repo, "Second commit message")

## Check blame
blame(repo, "example.txt")
}
}
\keyword{methods}

