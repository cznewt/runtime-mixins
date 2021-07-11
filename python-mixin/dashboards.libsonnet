local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';
local rows = import 'rows.libsonnet';
{
  grafanaDashboards+: {
    'python-app.json':
      g.dashboard('Python app')
      .addTemplate($._config.pythonInstanceLabel, $._config.pythonInstanceFilter, $._config.pythonInstanceLabel)
      .addRow(rows.pythonOverviewRow($._config))
      .addRow(rows.pythonProcessStatsRow($._config))
      .addRow(rows.pythonGarbageCollectorRow($._config)),
  },
}
