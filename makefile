build:
	@docker build --label mojo --tag mojo:v1 --no-cache --rm ./mojo/ubuntu_2204_v1

run:
	@docker run --rm -it --name mojo --volume $(PWD)/examples:/home/mojo/examples mojo:v1

run_hello:
	@docker run --volume $(PWD)/examples:/home/mojo/examples mojo:v1 mojo examples/hello.🔥