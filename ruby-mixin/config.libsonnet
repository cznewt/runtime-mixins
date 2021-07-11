{
  _config+:: {
    grafana72: true,
    grafanaIntervalVar: if self.grafana72 then '$__rate_interval' else '$__interval',
    rubyInstanceFilter: 'ruby_info',
    rubyInstanceSelector: 'instance="$instance"',
    rubyInstancesSelector: 'instances="$instance"',
    rubyInstanceLabel: 'instance',
  },
}
