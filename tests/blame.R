## git2r, R bindings to the libgit2 library.
## Copyright (C) 2013-2015 The git2r contributors
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
config(repo, user.name="User One", user.email="user.one@example.org")

##
## Create a file and commit
##
writeLines("Hello world!", file.path(path, "test.txt"))
add(repo, "test.txt")
commit.1 <- commit(repo, "First commit message")

##
## Create new user and change file
##
config(repo, user.name="User Two", user.email="user.two@example.org")
writeLines(c("Hello world!", "HELLO WORLD!", "HOLA"),
           file.path(path, "test.txt"))
add(repo, "test.txt")
commit.2 <- commit(repo, "Second commit message")

##
## Check blame
##
b <- blame(repo, "test.txt")
stopifnot(identical(length(b@hunks), 2L))

## Hunk: 1
stopifnot(identical(b@hunks[[1]]@lines_in_hunk, 1L))
stopifnot(identical(b@hunks[[1]]@final_commit_id, commit.1@sha))
stopifnot(identical(b@hunks[[1]]@final_start_line_number, 1L))
stopifnot(identical(b@hunks[[1]]@final_signature@name, "User One"))
stopifnot(identical(b@hunks[[1]]@final_signature@email, "user.one@example.org"))
stopifnot(identical(b@hunks[[1]]@orig_commit_id, commit.1@sha))
stopifnot(identical(b@hunks[[1]]@orig_start_line_number, 1L))
stopifnot(identical(b@hunks[[1]]@orig_signature@name, "User One"))
stopifnot(identical(b@hunks[[1]]@orig_signature@email, "user.one@example.org"))
stopifnot(identical(b@hunks[[1]]@orig_path, "test.txt"))
stopifnot(identical(b@hunks[[1]]@boundary, TRUE))

## Hunk: 2
stopifnot(identical(b@hunks[[2]]@lines_in_hunk, 2L))
stopifnot(identical(b@hunks[[2]]@final_commit_id, commit.2@sha))
stopifnot(identical(b@hunks[[2]]@final_start_line_number, 2L))
stopifnot(identical(b@hunks[[2]]@final_signature@name, "User Two"))
stopifnot(identical(b@hunks[[2]]@final_signature@email, "user.two@example.org"))
stopifnot(identical(b@hunks[[2]]@orig_commit_id, commit.2@sha))
stopifnot(identical(b@hunks[[2]]@orig_start_line_number, 2L))
stopifnot(identical(b@hunks[[2]]@orig_signature@name, "User Two"))
stopifnot(identical(b@hunks[[2]]@orig_signature@email, "user.two@example.org"))
stopifnot(identical(b@hunks[[2]]@orig_path, "test.txt"))
stopifnot(identical(b@hunks[[2]]@boundary, FALSE))

##
## Cleanup
##
unlink(path, recursive=TRUE)
