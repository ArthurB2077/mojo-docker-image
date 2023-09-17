build:
	@docker build --label mojo --tag mojo:v1 --no-cache --rm .

run:
	@docker run --rm -it --name mojo mojo:v1