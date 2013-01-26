
all: compile

compile:
	coffee -cb *.coffee

watch:
	coffee --watch -cb *.coffee

