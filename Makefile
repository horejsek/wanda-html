
all: compile

compile:
	coffee -c *.coffee

watch:
	coffee --watch -c *.coffee

