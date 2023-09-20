build:
	@docker build --label mojo --tag mojo:v1 --no-cache --rm ./mojo/ubuntu_2204_v1

build_to_push:
	@docker build --label mojo --tag abequie/mojo:latest --no-cache --rm ./mojo/ubuntu_2204_v1

run_hello:
	@docker run --volume $(PWD)/examples:/home/mojo/examples mojo:v1 mojo examples/hello.🔥

run:
	@docker run --rm -it --name mojo --volume $(PWD)/examples:/home/mojo/examples mojo:v1

build_mojo_bullseye_slim:
	@docker build --label mojo_bullseye_slim --tag mojo_bullseye_slim:v1 --no-cache --rm ./mojo/debian_bullseye_slim

build_to_push_mojo_bullseye_slim:
	@docker build --label mojo_bullseye_slim --tag abequie/mojo_bullseye_slim:v1 --no-cache --rm ./mojo/debian_bullseye_slim

run_mojo_bullseye_slim:
	@docker run --rm -it --name mojo_bullseye_slim --volume $(PWD)/examples:/home/mojo/examples mojo_bullseye_slim:v1
