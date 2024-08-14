BINBATSBINPATH=./test/bats/bin/bats
BINBATSTESTSUITES=./test/bats/bin/bats


.PHONY: test
test: $(BINBATSPATH) $(BINBATSTESTSUITES)
	
