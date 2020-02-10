# This file is run on deployment to create the compressed assets

ASSETS := $(addsuffix .gz,$(wildcard *.js *.css *.html *.json js/*.js css/*.css))

.PHONY: deploy

%.gz: %
	gzip -fk9 $<

deploy: $(ASSETS)
