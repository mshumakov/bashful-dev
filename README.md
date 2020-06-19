# bashful-dev

[![build](https://github.com/mshumakov/bashful-dev/workflows/build/badge.svg)](https://github.com/mshumakov/bashful-dev/actions)

This project is a configuration for the implementation of a common structure for the needs of development using the https://github.com/wagoodman/bashful tool.

## Installation

First install [wagoodman/bashful](https://github.com/wagoodman/bashful) >= 0.1.1.

**Use for shell**:

```shell script 
[ -e ~/.dev ] || git clone https://github.com/mshumakov/bashful-dev --depth 1 ~/.dev
```

## Getting Started

```shell script
usage: make [target]

Other:
  help                            Show this help.

Project:
  project-create                  Creating a project.
  project-delete                  Deleting a project.
  project-archive                 Project archiving.

Sandbox:
  sandbox-create                  Creating a project in the sandbox.
  sandbox-delete                  Deleting a project in the sandbox.
  sandbox-delete-all              Deleting all in the sandbox.
  sandbox-archive                 Sandbox project archiving.
  sandbox-archive-all             Archiving all sandbox projects.

Test:
  test                            Configuration testing.

Utils:
  check                           Configuration of dev-structures.
  ps                              List of items in the sandbox.
  update                          Update structure.
```