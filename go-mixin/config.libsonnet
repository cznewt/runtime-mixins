{
  _config+:: {
    grafana72: true,
    grafanaIntervalVar: if self.grafana72 then '$__rate_interval' else '$__interval',
    goInstanceFilter: 'go_info',
    goInstanceSelector: 'instance="$instance"',
    goInstancesSelector: 'instance=~"$instance"',
    goInstanceLabel: 'instance',
  },
}
