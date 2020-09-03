

help:
	cat Makefile | egrep -v '^$$'

config.yaml:
	@echo You need to copy config.yaml.dist into config.yaml and edit away.
	exit 42

config-with-comment: config.yaml
	@echo Config is ok. Good.


install: config-with-comment
	@echo TODO apply Jinja templates with config 

run: config-with-comment
	ENV=prod ruby substitute_variables.rb api

run-bq-cli:
	@echo Executing BQ queries from CLI to make sure your config is correct.
	ENV=prod ruby substitute_variables.rb bqcli

test: config-with-comment
	ENV=test ruby substitute_variables.rb
