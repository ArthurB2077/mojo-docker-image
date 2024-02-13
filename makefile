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