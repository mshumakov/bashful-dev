# Makefile for project (git@github.com:mshumakov/bashful-dev.git)

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "### Manager stands:"
	@echo " - sandbox-try                  Creating a project in the sandbox."
	@echo " - sandbox-archive              Sandbox project archiving."
	@echo " - sandbox-archive-all          Archiving all sandbox projects."
	@echo ""
	@echo "Example:"
	@echo "  make ARG="app-test01" sandbox-try"
	@echo ""

sandbox-try:
	@bashful run dev-structure.yml --tags sandbox-try ${ARG}

sandbox-archive:
	@bashful run dev-structure.yml --tags sandbox-archive ${ARG}

sandbox-archive-all:
	@bashful run dev-structure.yml --tags sandbox-archive-all
