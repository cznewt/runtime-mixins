local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';
local rows = import 'rows.libsonnet';
{
  grafanaDashboards+: {
    'go-app.json':
      g.dashboard('Go app')
      .addTemplate($._config.goInstanceLabel, $._config.goInstanceFilter, $._config.goInstanceLabel)
      .addRow(rows.goOverviewRow($._config))
      .addRow(rows.goProcessStatsRow($._config))
      .addRow(rows.goGarbageCollectorRow($._config))
  },
}
