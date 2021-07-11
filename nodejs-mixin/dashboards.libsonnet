local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';
local rows = import 'rows.libsonnet';
{
  grafanaDashboards+: {
    'nodejs-app.json':
      g.dashboard('Node.js app')
      .addTemplate($._config.nodejsInstanceLabel, $._config.nodejsInstanceFilter, $._config.nodejsInstanceLabel)
      .addRow(rows.nodejsOverviewRow($._config))
      .addRow(rows.nodejsProcessStatsRow($._config))
      .addRow(rows.nodejsGarbageCollectorRow($._config)),
  },
}
