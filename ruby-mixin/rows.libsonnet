local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';

{
  rubyOverviewRow(config)::
    g.row('Ruby runtime overview'),
  rubyProcessStatsRow(config)::
    g.row('Ruby process stats')
    .addPanel(
      g.panel('CPU usage') +
      g.queryPanel(
        'sum by (%(rubyInstanceLabel)s) (rate(process_cpu_seconds_total{%(rubyInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(rubyInstanceLabel)s}}' % config
      ) + { yaxes: g.yaxes('percentunit') }
    )
    .addPanel(
      g.panel('Memory set size') +
      g.queryPanel(
        [
          'process_virtual_memory_bytes{%(rubyInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
          'process_resident_memory_bytes{%(rubyInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        ],
        [
          '{{%(rubyInstanceLabel)s}} virtual' % config,
          '{{%(rubyInstanceLabel)s}} resident' % config,
        ]
      ) + { yaxes: g.yaxes('bytes') }
    )
    .addPanel(
      g.panel('File descriptors') +
      g.queryPanel(
        [
          'process_open_fds{%(rubyInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
          'process_max_fds{%(rubyInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        ],
        [
          '{{%(rubyInstanceLabel)s}} open' % config,
          '{{%(rubyInstanceLabel)s}} max' % config,
        ]
      ) + { yaxes: g.yaxes('short') }
    ),
  rubyGarbageCollectorRow(config)::
    g.row('Ruby garbage collection stats')
    .addPanel(
      g.panel('GC collections') +
      g.queryPanel(
        'sum by (%(rubyInstanceLabel)s, generation) (rate(ruby_gc_collections_total{(rubyInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(rubyInstanceLabel)s}} generation {{ generation }}' % config
      ) + { yaxes: g.yaxes('ops') }
    )
    .addPanel(
      g.panel('GC objects collected') +
      g.queryPanel(
        'sum by (%(rubyInstanceLabel)s, generation) (rate(ruby_gc_objects_collected_total{(rubyInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(rubyInstanceLabel)s}} generation {{ generation }}' % config
      ) + { yaxes: g.yaxes('short') }
    ),
}
