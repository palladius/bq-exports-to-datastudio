

config:
	@echo You need to copy config.dist into config and edit away.
	exit 42

config-with-comment: config
	@echo Config is ok. Good.


install: config-with-comment
	@echo TODO apply Jinja templates with config 

run: config-with-comment
	ENV=prod ruby substitute_variables.rb

test: config-with-comment
	ENV=test ruby substitute_variables.rb
