# bashful-dev

[![Build Status](https://github-ci.msdev-storage.com/api/badges/mshumakov/bashful-dev/status.svg)](https://github-ci.msdev-storage.com/mshumakov/bashful-dev)

This project is a configuration for the implementation of a common structure for the needs of development using the https://github.com/wagoodman/bashful tool.

## Installation

First install [wagoodman/bashful](https://github.com/wagoodman/bashful) >= 0.1.1.

**Use for shell**:

```shell script 
[ -e ~/.dev ] || git clone https://github.com/mshumakov/bashful-dev --depth 1 ~/.dev
```

## Getting Started

```shell script
$ make
usage: make COMMAND

Commands:
 - check                                   Configuration of dev-structures.
 - ps                                      List of items in the sandbox.
 - test                                    Configuration testing.
 - update                                  Update structure.

Other commands:
 - {sandbox, project}-create               Creating a project in the sandbox or projects.
 - {sandbox, project}-delete               Deleting a project in the sandbox or projects.
 - {sandbox, project}-archive              Project Archiving (sandbox or projects).
 - sandbox-delete-all                      Deleting all in the sandbox.
 - sandbox-archive-all                     Archiving all sandbox projects.

Example:
  make check && make ARG=app-test01 sandbox-create
```