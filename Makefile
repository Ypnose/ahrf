all: check

check: verify_regr.sh
	@mksh verify_regr.sh

clean: test
	@rm -rf test/*.gen

.PHONY: all check clean
