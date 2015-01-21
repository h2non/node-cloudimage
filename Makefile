MOCHA = ./node_modules/.bin/mocha
CUCUMBER = ./node_modules/.bin/cucumber-js
STUBBY = ./node_modules/.bin/stubby
KARMA = ./node_modules/karma/bin/karma

define release
	VERSION=`node -pe "require('./bower.json').version"` && \
	NEXT_VERSION=`node -pe "require('semver').inc(\"$$VERSION\", '$(1)')"` && \
	node -e "\
		var j = require('./component.json');\
		j.version = \"$$NEXT_VERSION\";\
		var s = JSON.stringify(j, null, 2);\
		require('fs').writeFileSync('./component.json', s);" && \
	node -e "\
		var j = require('./bower.json');\
		j.version = \"$$NEXT_VERSION\";\
		var s = JSON.stringify(j, null, 2);\
		require('fs').writeFileSync('./bower.json', s);" && \
	git commit -am "release $$NEXT_VERSION" && \
	git tag "$$NEXT_VERSION" -m "Version $$NEXT_VERSION"
endef

default: all
all: test
test: mocha

mocha:
	$(MOCHA) --reporter spec --ui tdd

cucumber:
	$(CUCUMBER) -f pretty -r features/support -r features/step_definitions

loc:
	wc -l resilient.js

mock-server:
	$(STUBBY) -d ./test/fixtures/mocks.yaml > /dev/null & echo $$! > .server.pid

mock-server-stop:
	[ -f .server.pid ] && kill -9 `cat .server.pid | head -n 1` && rm -f .server.pid || exit 0

release:
	@$(call release, patch)

release-minor:
	@$(call release, minor)

publish: browser release
	git push --tags origin HEAD:master
