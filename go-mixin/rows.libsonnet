local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';

{
  goOverviewRow(config)::
    g.row('Go runtime overview')
    .addPanel(
      g.panel('$instance') +
      g.statPanel('go_info{%(goInstanceLabel)s}' % config, 'none')
    ),
  goProcessStatsRow(config)::
    g.row('Go process stats')
    .addPanel(
      g.panel('CPU usage') +
      g.queryPanel(
        'sum by (%(goInstanceLabel)s) (rate(process_cpu_seconds_total{%(goInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(goInstanceLabel)s}}' % config
      ) + { yaxes: g.yaxes('percentunit') }
    )
    .addPanel(
      g.panel('Memory set size') +
      g.queryPanel(
        [
          'process_virtual_memory_bytes{%(goInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
          'process_resident_memory_bytes{%(goInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        ],
        [
          '{{%(goInstanceLabel)s}} virtual' % config,
          '{{%(goInstanceLabel)s}} resident' % config,
        ]
      ) + { yaxes: g.yaxes('bytes') }
    ),
  goGarbageCollectorRow(config)::
    g.row('Go garbage collection stats')
    .addPanel(
      g.panel('GC collections') +
      g.queryPanel(
        'sum by (%(goInstanceLabel)s, generation) (rate(go_gc_collections_total{(goInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(goInstanceLabel)s}} generation {{ generation }}' % config
      ) + { yaxes: g.yaxes('ops') }
    ),
}
