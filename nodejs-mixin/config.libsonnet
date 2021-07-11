{
  _config+:: {
    grafana72: true,
    grafanaIntervalVar: if self.grafana72 then '$__rate_interval' else '$__interval',
    nodejsInstanceFilter: 'nodejs_info',
    nodejsInstanceSelector: 'instance=~"$instance"',
    nodejsInstancesSelector: 'instance=~"$instance"',
    nodejsInstanceLabel: 'instance',
  },
}
