# Makefile for ahrf - see LICENSE for copyright and license
# Ypnose - http://ywstd.fr

AWKV = nawk mawk gawk
RUNT = verify_regr.sh

all: check

check: ${RUNT}
	@sh ${RUNT}

check-all: ${RUNT}
	@for i in ${AWKV}; do echo "Running tests with $${i}:"; \
		sh ${RUNT} "$$i"; echo; done

clean: test
	@rm -rf test/*.gen

.PHONY: all check check-all clean
