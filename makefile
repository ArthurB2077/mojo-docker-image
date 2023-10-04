# mu22 = mojo ubuntu 22.04, mbs = mojo bullseye slim

# Mojo ubuntu commands
build_mu22:
	@docker build --label mojo --tag abequie/mojo:latest --no-cache --rm ./mojo/ubuntu_2204_v1

build_locally_mu22:
	@docker build --label mojo --tag mojo:latest --no-cache --rm ./mojo/ubuntu_2204_v1

start_mu22:
	@docker run -d -it --name mojo --restart=always --volume $(PWD)/examples:/home/mojo/examples abequie/mojo:latest tail -f /dev/null

start_locally_mu22:
	@docker run -d -it --name mojo --restart=always --volume $(PWD)/examples:/home/mojo/examples mojo:latest tail -f /dev/null

run_hello_mu22:
	@docker exec mojo mojo examples/hello.🔥

run_check_python_module_mu22:
	@docker exec mojo /bin/bash -c "./examples/import_deps.sh"
	@docker exec mojo mojo ./examples/pymod.🔥

push_mu22:
	@docker login
	@docker tag abequie/mojo:latest abequie/mojo:latest
	@docker push abequie/mojo:latest

# Mojo debian commands
build_mbs:
	@docker build --label mojo_bullseye_slim --tag abequie/mojo:bullseye_slim --no-cache --rm ./mojo/debian_bullseye_slim

build_locally_mbs:
	@docker build --label mojo_bullseye_slim --tag mojo:bullseye_slim --no-cache --rm ./mojo/debian_bullseye_slim

start_mbs:
	@docker run -d -it --name mojo_bullseye_slim --restart=always --volume $(PWD)/examples:/home/mojo/examples abequie/mojo:bullseye_slim tail -f /dev/null

start_locally_mbs:
	@docker run -d -it --name mojo_bullseye_slim --restart=always --volume $(PWD)/examples:/home/mojo/examples mojo:bullseye_slim tail -f /dev/null

run_hello_mbs:
	@docker exec mojo_bullseye_slim mojo ./examples/hello.🔥

run_check_python_module_mbs:
	@docker exec mojo /bin/bash -c "./examples/import_deps.sh"
	@docker exec mojo_bullseye_slim mojo ./examples/pymod.🔥

push_mbs:
	@docker login
	@docker tag abequie/mojo:bullseye_slim abequie/mojo:bullseye_slim
	@docker push abequie/mojo:bullseye_slim
