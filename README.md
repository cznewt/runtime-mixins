# Runtime monitoring mixins

Collection of reusable application runtime mixins to be included in specific service monitoring models.

## Supported runtime environments

### dotnet-mixin

Mixin for .net applications, and contains a dashboard for visualizing the runtime
metrics produced by Prometheus .net client process and platform collectors.

### python-mixin

Mixin for Python applications, and contains a dashboard for visualizing the runtime
metrics produced by Prometheus Python client process and platform collectors.

## Installation

Add mixins you want use to your `jsonnetfile.json` definition and run the `jb` command.
Runtime mixins rely on `grafana-builder` library, so don't forget to install it as well.

```
{
    "version": 1,
    "dependencies": [
        {
            "source": {
                "git": {
                    "remote": "https://github.com/cznewt/runtime-mixins.git",
                    "subdir": "python-mixin"
                }
            },
            "version": "master"
        },
        {
            "source": {
                "git": {
                    "remote": "https://github.com/cznewt/runtime-mixins.git",
                    "subdir": "ruby-mixin"
                }
            },
            "version": "master"
        },
        {
            "source": {
                "git": {
                    "remote": "https://github.com/grafana/jsonnet-libs.git",
                    "subdir": "grafana-builder"
                }
            },
            "version": "master"
        }
    ],
    "legacyImports": false
}
```

## Configuration

Each runtime mixin can be further configured to suilt your needs.

```
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
```

## Usage

You can then import the mixins in your model definition and use it. For example the
dashboard definition.

```
local g = import 'github.com/grafana/jsonnet-libs/grafana-builder/grafana.libsonnet';
local p_rows = import 'github.com/cznewt/runtime-mixins/python-mixin/rows.libsonnet';

{
  grafanaDashboards+: {
    'sample-python-app.json':
      g.dashboard('Sample python app')
      .addTemplate('instance', 'some_metric', 'instance')
      .addRow(p_rows.rubyOverviewRow($._config))
      .addRow(p_rows.rubyProcessStatsRow($._config))
      .addRow(p_rows.rubyGarbageCollectorRow($._config)),
  },
}
```
