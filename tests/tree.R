## git2r, R bindings to the libgit2 library.
## Copyright (C) 2013-2014 The git2r contributors
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License, version 2,
## as published by the Free Software Foundation.
##
## git2r is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License along
## with this program; if not, write to the Free Software Foundation, Inc.,
## 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

library(git2r)

##
## Create a directory in tempdir
##
path <- tempfile(pattern="git2r-")
dir.create(path)

##
## Initialize a repository
##
repo <- init(path)
config(repo, user.name="Repo", user.email="repo@example.org")

##
## Create a file
##
writeLines("Hello world!", file.path(path, "test.txt"))

##
## add and commit
##
add(repo, 'test.txt')
commit(repo, "Commit message")

##
## Check tree
##
stopifnot(is(lookup(repo, "a0b0b9e615e9e433eb5f11859e9feac4564c58c5"), "git_tree"))
stopifnot(is(tree(commits(repo)[[1]]), "git_tree"))
stopifnot(identical(lookup(repo, "a0b0b9e615e9e433eb5f11859e9feac4564c58c5"),
                    tree(commits(repo)[[1]])))

##
## Cleanup
##
unlink(path, recursive=TRUE)