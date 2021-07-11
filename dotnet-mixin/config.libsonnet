{
  _config+:: {
    grafana72: true,
    grafanaIntervalVar: if self.grafana72 then '$__rate_interval' else '$__interval',
    dotnetInstanceFilter: 'dotnet_build_info',
    dotnetInstanceSelector: 'instance="$instance"',
    dotnetInstancesSelector: 'instance=~"$instance"',
    dotnetInstanceLabel: 'instance',
  },
}
