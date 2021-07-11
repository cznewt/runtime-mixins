local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';

{
  jvmOverviewRow(config)::
    g.row('JVM runtime overview'),
  jvmProcessStatsRow(config)::
    g.row('JVM process stats'),
  jvmGarbageCollectorRow(config)::
    g.row('JVM garbage collection stats'),
}
