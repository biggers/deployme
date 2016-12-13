## deployme -- Twisted/Klein app builder / runner, using Docker(files)

include makefile.docker

PORTS = 8081:8081

chown_wh:
	sudo chown -R ${USER}.root wheelhouse

build_base: base.docker
	mkdir -p wheelhouse
	docker build -t deployme-base -f base.docker .

build_builder: build.docker build_base 
	docker build -t deployme-builder -f build.docker .

build_app: build_builder  requirements.txt
	docker run --rm \
	  -v "$$(pwd)":/application -v "$$(pwd)"/wheelhouse:/wheelhouse \
	  deployme-builder;

build_runner: run.docker build_app
	docker build -t deployme-run -f run.docker .

run_app: build_runner
#	docker run --rm -it -p ${PORTS} deployme-run
	docker run  -it --name=deployme-run -p ${PORTS} --entrypoint /bin/sh  deployme-run
	echo "docker exec -it deployme-run /bin/sh"
