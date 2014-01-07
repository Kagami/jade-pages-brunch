COFFEE=node_modules/.bin/coffee

all: build

install-deps:
	npm install

build: clean
	$(COFFEE) -o lib -c src

watch w: clean
	$(COFFEE) -w -o lib -c src

clean c:
	rm -rf lib
