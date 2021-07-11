local rules = (import 'mixins.libsonnet').prometheusRules;

{
  [group.name + '.yaml']: std.manifestYamlDoc({ groups: [group] })
  for group in rules.groups
}
