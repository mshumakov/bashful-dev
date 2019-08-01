# Makefile for project (git@github.com:mshumakov/bashful-dev.git)

help:
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo " - check                        Configuration of dev-structures."
	@echo " - test                         Configuration testing."
	@echo ""
	@echo "Other commands:"
	@echo " - sandbox-create               Creating a project in the sandbox."
	@echo " - sandbox-delete               Deleting a project in the sandbox."
	@echo " - sandbox-delete-all           Deleting all in the sandbox."
	@echo " - sandbox-archive              Sandbox project archiving."
	@echo " - sandbox-archive-all          Archiving all sandbox projects."
	@echo ""
	@echo "Example:"
	@echo "  make ARG="app-test01" sandbox-create"

check:
	@bashful run dev.yml --tags check

sandbox-create:
	@bashful run dev.yml --tags sandbox-create ${ARG}

sandbox-delete:
	@bashful run dev.yml --tags sandbox-delete ${ARG}

sandbox-delete-all:
	@bashful run dev.yml --tags sandbox-delete-all

sandbox-archive:
	@bashful run dev.yml --tags sandbox-archive ${ARG}

sandbox-archive-all:
	@bashful run dev.yml --tags sandbox-archive-all

test:
	@make check
	@make ARG=test01 sandbox-create && echo 'OK'
	@make ARG=test02 sandbox-create && echo 'OK'
	@make ARG=test01 sandbox-archive && [ -e data/archives/*_sandbox_test01.tar.bz2 ] && echo 'OK'
	@make ARG=test01 sandbox-delete && echo 'OK'
	@make sandbox-archive-all && [ -e data/archives/*_sandbox_all.tar.bz2 ] && echo 'OK'
	@make sandbox-delete-all && echo 'OK'