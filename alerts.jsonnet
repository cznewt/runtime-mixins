local alerts = (import 'mixins.libsonnet').prometheusAlerts;

{
  [group.name + '.yaml']: std.manifestYamlDoc({ groups: [group] })
  for group in alerts.groups
}
