local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';

{
  pythonOverviewRow(config)::
    g.row('Python overview'),
  pythonProcessStatsRow(config)::
    g.row('Python process stats')
    .addPanel(
      g.panel('CPU usage') +
      g.queryPanel(
        'sum by (%(pythonInstanceLabel)s) (rate(process_cpu_seconds_total{%(pythonInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(pythonInstanceLabel)s}}' % config
      ) + { yaxes: g.yaxes('percentunit') }
    )
    .addPanel(
      g.panel('Memory set size') +
      g.queryPanel(
        [
          'process_virtual_memory_bytes{%(pythonInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
          'process_resident_memory_bytes{%(pythonInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        ],
        [
          '{{%(pythonInstanceLabel)s}} virtual' % config,
          '{{%(pythonInstanceLabel)s}} resident' % config,
        ]
      ) + { yaxes: g.yaxes('bytes') }
    )
    .addPanel(
      g.panel('File descriptors') +
      g.queryPanel(
        [
          'process_open_fds{%(pythonInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
          'process_max_fds{%(pythonInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        ],
        [
          '{{%(pythonInstanceLabel)s}} open' % config,
          '{{%(pythonInstanceLabel)s}} max' % config,
        ]
      ) + { yaxes: g.yaxes('short') }
    ),
  pythonGarbageCollectorRow(config)::
    g.row('Python garbage collection stats')
    .addPanel(
      g.panel('GC collections') +
      g.queryPanel(
        'sum by (%(pythonInstanceLabel)s, generation) (rate(python_gc_collections_total{(pythonInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(pythonInstanceLabel)s}} generation {{ generation }}' % config
      ) + { yaxes: g.yaxes('ops') }
    )
    .addPanel(
      g.panel('GC objects collected') +
      g.queryPanel(
        'sum by (%(pythonInstanceLabel)s, generation) (rate(python_gc_objects_collected_total{(pythonInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(pythonInstanceLabel)s}} generation {{ generation }}' % config
      ) + { yaxes: g.yaxes('short') }
    )
    .addPanel(
      g.panel('Uncollectable GC objects') +
      g.queryPanel(
        'sum by (%(pythonInstanceLabel)s, generation) (rate(python_gc_objects_uncollectable_total{(pythonInstanceSelector)s}[%(grafanaIntervalVar)s]))' % config,
        '{{%(pythonInstanceLabel)s}} generation {{ generation }}' % config
      ) + { yaxes: g.yaxes('short') }
    ),
}
