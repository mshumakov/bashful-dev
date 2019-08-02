# Makefile for project (git@github.com:mshumakov/bashful-dev.git)

help:
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo " - check                        Configuration of dev-structures."
	@echo " - ps                           List of items in the sandbox."
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
	@echo "  make check && make ARG=app-test01 sandbox-create"

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

ps:
	@`[ -e ./data ]` \
	&& echo 'Sandbox list:' \
	&& ls ./data/sandbox \
	|| echo 'Data does not exist. \nUse: `make check`.'

test:
	@make ps | grep 'Use: `make check`.' > /dev/null \
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

	@make ps | grep 'Sandbox list:' > /dev/null \
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