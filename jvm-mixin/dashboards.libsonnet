local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';
local rows = import 'rows.libsonnet';
{
  grafanaDashboards+: {
    'jvm-app.json':
      g.dashboard('JVM app')
      .addTemplate($._config.jvmInstanceLabel, $._config.jvmInstanceFilter, $._config.jvmInstanceLabel)
      .addRow(rows.jvmOverviewRow($._config))
      .addRow(rows.jvmProcessStatsRow($._config))
      .addRow(rows.jvmGarbageCollectorRow($._config)),
  },
}
