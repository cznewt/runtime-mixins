{
  prometheusAlerts+:: {
    groups+: [{
      name: 'jvm-app-alerts',
      rules: [
        {
          alert: 'JvmHeapUsageTooMuch',
          expr: |||
            100 * (
              jvm_memory_bytes_used{area="heap"} 
                /
              jvm_memory_bytes_max
            ) > 90
          |||,
          'for': '1m',
          labels: {
            severity: 'critical',
          },
          annotations: {
            summary: 'JVM instance memory usage > 90%',
            description: '{{ $labels.instance }} of job {{ $labels.job }} has been in status [heap usage > 90%] for more than 1 minutes. current usage ({{ $value }}%)',
          },
        },
        {
          alert: 'JvmHeapUsageTooMuch',
          expr: |||
            increase(jvm_gc_collection_seconds_sum{gc="PS MarkSweep"}[5m])
            > 5 * 60 * 0.5
          |||,
          'for': '5m',
          labels: {
            severity: 'critical',
          },
          annotations: {
            summary: 'JVM instance old GC time > 50% running time',
            description: '{{ $labels.instance }} of job {{ $labels.job }} has been in status [Old GC time > 50% running time] for more than 5 minutes. current seconds ({{ $value }}%)',
          },
        },
      ],
    }],
  },
}
