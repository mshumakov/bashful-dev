# Makefile for project (git@github.com:mshumakov/bashful-dev.git)

help:
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo " - check                                   Configuration of dev-structures."
	@echo " - ps                                      List of items in the sandbox."
	@echo " - test                                    Configuration testing."
	@echo " - update                                  Update structure."
	@echo ""
	@echo "Other commands:"
	@echo " - {sandbox, project}-create               Creating a project in the sandbox or projects."
	@echo " - {sandbox, project}-delete               Deleting a project in the sandbox or projects."
	@echo " - {sandbox, project}-archive              Project Archiving (sandbox or projects)."
	@echo " - sandbox-delete-all                      Deleting all in the sandbox."
	@echo " - sandbox-archive-all                     Archiving all sandbox projects."
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

project-create:
	@bashful run dev.yml --tags project-create ${ARG} \
	&& echo 'Info: Add the project to the created structure for the project.' \
	&& echo 'git clone git@github.com:user/project.git ./data/projects/name-project/app'

project-delete:
	@bashful run dev.yml --tags project-delete ${ARG}

project-archive:
	@bashful run dev.yml --tags project-archive ${ARG}

ps:
	@echo 'Sandbox list:' \
	&& [ -e ./data/sandbox ] \
	&& ls ./data/sandbox \
	|| echo '-'

	@echo 'Project list:' \
	&& [ -e ./data/projects ] \
	&& ls ./data/projects \
	|| echo '-'

update:
	@git pull --rebase

test:
	@make ps | grep 'Sandbox list:' > /dev/null \
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