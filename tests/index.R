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
config(repo, user.name="Repo", user.email="repo@example.org")

##
## Create directories
##
dir.create(file.path(path, "sub-folder"));
dir.create(file.path(path, "sub-folder", "sub-sub-folder"));

##
## Create files
##
writeLines("Hello world!", file.path(path, "file-1.txt"))
writeLines("Hello world!", file.path(path, "sub-folder", "file-2.txt"))
writeLines("Hello world!", file.path(path, "sub-folder", "file-3.txt"))
writeLines("Hello world!", file.path(path, "sub-folder", "sub-sub-folder", "file-4.txt"))
writeLines("Hello world!", file.path(path, "sub-folder", "sub-sub-folder", "file-5.txt"))

##
## Add
##
add(repo, "sub-folder")
status_exp <- structure(list(staged = structure(list(
                                 new = "sub-folder/file-2.txt",
                                 new = "sub-folder/file-3.txt",
                                 new = "sub-folder/sub-sub-folder/file-4.txt",
                                 new = "sub-folder/sub-sub-folder/file-5.txt"),
                                 .Names = c("new", "new", "new", "new")),
                             unstaged = structure(list(), .Names = character(0)),
                             untracked = structure(list(untracked = "file-1.txt"),
                                 .Names = "untracked")),
                        .Names = c("staged", "unstaged", "untracked"))
status_obs <- status(repo)
stopifnot(identical(status_obs, status_exp))

##
## Cleanup
##
unlink(path, recursive=TRUE)
