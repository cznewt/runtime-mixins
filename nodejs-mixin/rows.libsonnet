local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';

{
  nodejsOverviewRow(config)::
    g.row('Node.js overview'),
  nodejsProcessStatsRow(config)::
    g.row('Node.js process stats'),
  nodejsGarbageCollectorRow(config)::
    g.row('Node.js garbage collection stats'),
}
