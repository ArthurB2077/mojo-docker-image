build:
	@docker build --label mojo --tag mojo:v1 --no-cache --rm ./mojo/ubuntu_2204_v1

build_to_push:
	@docker build --label mojo --tag abequie/mojo:latest --no-cache --rm ./mojo/ubuntu_2204_v1

run_hello:
	@docker run --volume $(PWD)/examples:/home/mojo/examples mojo:v1 mojo examples/hello.🔥

run:
	@docker run --rm -it --name mojo --volume $(PWD)/examples:/home/mojo/examples mojo:v1

push_mojo_ubuntu_2204:
	@docker login
	@docker push abequie/mojo:latest

build_mojo_bullseye_slim:
	@docker build --label mojo_bullseye_slim --tag mojo_bullseye_slim:v1 --no-cache --rm ./mojo/debian_bullseye_slim

build_to_push_mojo_bullseye_slim:
	@docker build --label mojo_bullseye_slim --tag abequie/mojo:bullseye_slim --no-cache --rm ./mojo/debian_bullseye_slim

run_mojo_bullseye_slim:
	@docker run -d -it --name mojo_bullseye_slim --restart=always --volume $(PWD)/examples:/home/mojo/examples mojo_bullseye_slim:v1 tail -f /dev/null

push_mojo_bullseye_slim:
	@docker login
	@docker push abequie/mojo:bullseye_slim

# build_mojo_alpine_318:
# 	@docker build --label mojo_alpine_318 --tag mojo_alpine_318:v1 --no-cache --rm ./mojo/alpine_318

# build_to_push_mojo_alpine_318:
# 	@docker build --label mojo_alpine_318 --tag abequie/mojo_alpine_318:v1 --no-cache --rm ./mojo/alpine_318

# run_mojo_alpine_318:
# 	@docker run --rm -it --name mojo_alpine_318 --volume $(PWD)/examples:/home/mojo/examples mojo_alpine_318:v1
