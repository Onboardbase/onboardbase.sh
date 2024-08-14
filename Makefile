BINBATSBINPATH=./test/bats/bin/bats
BINBATSTESTSUITES=test/


.PHONY: test
test:
	$(BINBATSBINPATH) test/
