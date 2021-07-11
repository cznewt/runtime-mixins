local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';

{
  dotnetOverviewRow(config)::
    g.row('.net runtime overview')
    .addPanel(
      g.panel('version') +
      g.statPanel('dotnet_build_info{%(goInstanceLabel)s}' % config, 'none')
    ),
  dotnetProcessStatsRow(config)::
    g.row('.net process stats')
    .addPanel(
      g.panel('CPU usage') +
      g.queryPanel(
        'sum by (%(dotnetInstanceLabel)s) (rate(process_cpu_seconds_total{%(dotnetInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(dotnetInstanceLabel)s}}' % config
      ) + { yaxes: g.yaxes('percentunit') }
    )
    .addPanel(
      g.panel('Memory set size') +
      g.queryPanel(
        [
          'process_virtual_memory_bytes{%(dotnetInstanceSelector)s}' % config,
          'process_private_memory_bytes{%(dotnetInstanceSelector)s}' % config,
        ],
        [
          '{{%(dotnetInstanceLabel)s}} virtual' % config,
          '{{%(dotnetInstanceLabel)s}} private' % config,
        ]
      ) + { yaxes: g.yaxes('bytes') }
    )
    .addPanel(
      g.panel('Total threads') +
      g.queryPanel(
        [
          'process_num_threads{%(dotnetInstanceSelector)s}' % config,
        ],
        [
          '{{%(dotnetInstanceLabel)s}} threads' % config,
        ]
      ) + { yaxes: g.yaxes('bytes') }
    ),
  dotnetGarbageCollectorRow(config)::
    g.row('.net garbage collection stats')
    .addPanel(
      g.panel('GC collections') +
      g.queryPanel(
        'sum by (%(dotnetInstanceLabel)s, generation) (rate(dotnet_gc_collection_seconds_bucket{(dotnetInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(dotnetInstanceLabel)s}} generation {{ generation }}' % config
      ) + { yaxes: g.yaxes('ops') }
    )
    .addPanel(
      g.panel('GC collections') +
      g.queryPanel(
        'increase(dotnet_collection_count_total{(dotnetInstanceSelector)s}[%(grafanaIntervalVar)s])' % config,
        '{{%(dotnetInstanceLabel)s}} generation {{ generation }}' % config
      ) + { yaxes: g.yaxes('ops') }
    ),
}
