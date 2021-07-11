{
  _config+:: {
    grafana72: true,
    grafanaIntervalVar: if self.grafana72 then '$__rate_interval' else '$__interval',
    jvmInstanceFilter: 'jvm_info',
    jvmInstanceSelector: 'instance="$instance"',
    jvmInstancesSelector: 'instance=~"$instance"',
    jvmInstanceLabel: 'instance',
  },
}
