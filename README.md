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
msdev at node-dev in ~/.dev/sandbox/bashful-dev on master [!]
$ make
usage: make COMMAND

Commands:
 - check                        Configuration of dev-structures.
 - test                         Configuration testing.

Other commands:
 - sandbox-create               Creating a project in the sandbox.
 - sandbox-delete               Deleting a project in the sandbox.
 - sandbox-delete-all           Deleting all in the sandbox.
 - sandbox-archive              Sandbox project archiving.
 - sandbox-archive-all          Archiving all sandbox projects.

Example:
  make check && make ARG=app-test01 sandbox-create
```