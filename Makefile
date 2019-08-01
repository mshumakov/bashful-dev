# Makefile for project (git@github.com:mshumakov/bashful-dev.git)

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "### Manager stands:"
	@echo " - test                         Configuration testing."
	@echo " - sandbox-try                  Creating a project in the sandbox."
	@echo " - sandbox-archive              Sandbox project archiving."
	@echo " - sandbox-archive-all          Archiving all sandbox projects."
	@echo ""
	@echo "Example:"
	@echo "  make ARG="app-test01" sandbox-try"
	@echo ""

sandbox-try:
	@bashful run dev.yml --tags sandbox-try ${ARG}

sandbox-archive:
	@bashful run dev.yml --tags sandbox-archive ${ARG}

sandbox-archive-all:
	@bashful run dev.yml --tags sandbox-archive-all

test:
	@make ARG=test01 sandbox-try && echo 'OK'
	@make ARG=test02 sandbox-try && echo 'OK'
	@make ARG=test01 sandbox-archive && [ -e data/archives/*_sandbox_test01.tar.bz2 ] && echo 'OK'
	@make sandbox-archive-all && [ -e data/archives/*_sandbox_all.tar.bz2 ] && echo 'OK'