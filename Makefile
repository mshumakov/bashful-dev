# Makefile for project (git@github.com:mshumakov/bashful-dev.git)

.DEFAULT_GOAL := help

#COLORS
GREEN  := $(shell tput -Txterm setaf 2)
WHITE  := $(shell tput -Txterm setaf 7)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
# A category can be added with @category
HELP_FUN = \
    %help; \
    while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
    print "usage: make [target]\n\n"; \
    for (sort keys %help) { \
    print "${WHITE}$$_:${RESET}\n"; \
    for (@{$$help{$$_}}) { \
    $$sep = " " x (32 - length $$_->[0]); \
    print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
    }; \
    print "\n"; }

help: ##@Other Show this help.
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

.PHONY: check
check: ##@Utils Configuration of dev-structures.
	@bashful run dev.yml --tags check

.PHONY: sandbox-create
sandbox-create: ##@Sandbox Creating a project in the sandbox.
	@bashful run dev.yml --tags sandbox-create ${ARG}

.PHONY: sandbox-delete
sandbox-delete: ##@Sandbox Deleting a project in the sandbox.
	@bashful run dev.yml --tags sandbox-delete ${ARG}

.PHONY: sandbox-delete-all
sandbox-delete-all: ##@Sandbox Deleting all in the sandbox.
	@bashful run dev.yml --tags sandbox-delete-all

.PHONY: sandbox-archive
sandbox-archive: ##@Sandbox Sandbox project archiving.
	@bashful run dev.yml --tags sandbox-archive ${ARG}

.PHONY: sandbox-archive-all
sandbox-archive-all: ##@Sandbox Archiving all sandbox projects.
	@bashful run dev.yml --tags sandbox-archive-all

.PHONY: project-create
project-create: ##@Project Creating a project.
	@bashful run dev.yml --tags project-create ${ARG} \
	&& echo 'Info: Add the project to the created structure for the project.' \
	&& echo 'git clone git@github.com:user/project.git ./data/projects/name-project/app'

.PHONY: project-delete
project-delete: ##@Project Deleting a project.
	@bashful run dev.yml --tags project-delete ${ARG}

.PHONY: project-archive
project-archive: ##@Project Project archiving.
	@bashful run dev.yml --tags project-archive ${ARG}

.PHONY: ps
ps: ##@Utils List of items in the sandbox.
	@echo '-- Archive list --' \
	&& [ -e ./data/archives ] \
	&& ls ./data/archives \
	|| echo '-'

	@echo '-- Sandbox list --' \
	&& [ -e ./data/sandbox ] \
	&& ls ./data/sandbox \
	|| echo '-'

	@echo '-- Project list --' \
	&& [ -e ./data/projects ] \
	&& ls ./data/projects \
	|| echo '-'

.PHONY: update
update: ##@Utils Update structure.
	@git pull --rebase

.PHONY: test
test: ##@Test Configuration testing.
	@make ps | grep 'Sandbox list' > /dev/null \
	&& echo '-> Get a warning about missing `./data`.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make check > /dev/null \
	&& [ -e ./data ] \
	&& echo '-> The structure will be created for work.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make ARG=test01 sandbox-create > /dev/null \
	&& make ARG=test02 sandbox-create > /dev/null \
	&& [ -e ./data/sandbox/test01 ] \
	&& echo '-> The project will be created in the sandbox.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make ps | grep 'Sandbox list' > /dev/null \
	&& echo '-> Show project list in development environment.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make ARG=test01 sandbox-archive > /dev/null \
	&& [ -e data/archives/*_sandbox_test01.tar.bz2 ] \
	&& echo '-> This will create an archive for the project from the sandbox.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make ARG=test01 sandbox-delete > /dev/null \
	&& echo '-> Will remove the project from the sandbox.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make sandbox-archive-all > /dev/null \
	&& [ -e data/archives/*_sandbox_all.tar.bz2 ] \
	&& echo '-> Archive all projects in the sandbox.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make sandbox-delete-all > /dev/null \
	&& echo '-> All projects will be removed from the sandbox.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make ARG=test01 project-create > /dev/null \
	&& make ARG=test02 project-create > /dev/null \
	&& [ -e ./data/projects/test01 ] \
	&& echo '-> The project will be created in the projects.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make ARG=test01 project-archive > /dev/null \
	&& [ -e data/archives/*_project_test01.tar.bz2 ] \
	&& echo '-> This will create an archive for the project from the projects.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1

	@make ARG=test01 project-delete > /dev/null \
	&& echo '-> Will remove the project from the projects.' \
	&& echo '.. OK' && exit 0 || echo '.. FAIL' && exit 1