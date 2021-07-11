{
  _config+:: {
    grafana72: true,
    grafanaIntervalVar: if self.grafana72 then '$__rate_interval' else '$__interval',
    pythonInstanceFilter: 'python_info',
    pythonInstanceSelector: 'instance="$instance"',
    pythonInstancesSelector: 'instance=~"$instance"',
    pythonInstanceLabel: 'instance',
  },
}
