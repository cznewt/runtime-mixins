
test:
	@mkdir -p tests/alerts
	jsonnet -J vendor -S -m ./tests/alerts alerts.jsonnet
	@mkdir -p tests/rules
	jsonnet -J vendor -S -m ./tests/rules rules.jsonnet
	@mkdir -p tests/dashboards
	jsonnet -J vendor -S -m ./tests/dashboards dashboards.jsonnet

clean:
	@rm -rf tests/dashboards
	@rm -rf tests/alerts
	@rm -rf tests/rules
