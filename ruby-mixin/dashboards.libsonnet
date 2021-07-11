local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';
local rows = import 'rows.libsonnet';
{
  grafanaDashboards+: {
    'ruby-app.json':
      g.dashboard('Ruby app')
      .addTemplate($._config.rubyInstanceLabel, $._config.rubyInstanceFilter, $._config.rubyInstanceLabel)
      .addRow(rows.rubyOverviewRow($._config))
      .addRow(rows.rubyProcessStatsRow($._config))
      .addRow(rows.rubyGarbageCollectorRow($._config)),
  },
}
