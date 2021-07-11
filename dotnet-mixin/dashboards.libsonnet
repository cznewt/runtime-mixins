local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';
local rows = import 'rows.libsonnet';
{
  grafanaDashboards+: {
    'dotnet-app.json':
      g.dashboard('.net app')
      .addTemplate($._config.dotnetInstanceLabel, $._config.dotnetInstanceFilter, $._config.dotnetInstanceLabel)
      .addRow(rows.dotnetOverviewRow($._config))
      .addRow(rows.dotnetProcessStatsRow($._config))
      .addRow(rows.dotnetGarbageCollectorRow($._config)),
  },
}
