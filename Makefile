
all: compile

compile:
	coffee -cb wanda/*.coffee
	java -jar compiler.jar \
		--js wanda/wanda.js \
		--js_output_file wanda/wanda.min.js \
		--warning_level=VERBOSE \
		--compilation_level ADVANCED_OPTIMIZATIONS

watch:
	coffee --watch -cb wanda/*.coffee

install-devlibs:
	apt-get install coffeescript

