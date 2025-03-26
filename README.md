# LGTM Stack Deployment Package

## Stack Overview

The LGTM (Loki, Grafana, Alloy, Mimir) stack provides comprehensive observability:
- **Loki**: Log aggregation
- **Grafana**: Visualization
- **Alloy**: Collection agent
- **Mimir**: Metrics storage

## Features

- **Automated Setup:** Installs and configures the entire LGTM stack with minimal effort.
- **Preconfigured Dashboards:** Comes with example dashboard JSON templates to visualize your logs, metrics, and traces.
- **Data Source Provisioning:** Automatically sets up key data sources using Grafana’s provisioning mechanism.
- **Alloy Configuration:** Includes guidance for configuring Grafana Alloy to process and route telemetry data.
- **Extensible Design:** Easily customize dashboards, add new data sources, or modify configuration files to tailor the stack to your needs.

## Quick Start

1. Prerequisites
   - Ubuntu >= 20.04
   - Ideally >= 2GB RAM

2. Installation & Usage

```bash
# Git clone repo and cd into it
git clone https://github.com/hawi-claire/Network_Security_And_Log_Monitoring_Dashboard.git && cd Network_Security_And_Log_Monitoring_Dashboard

# To set up the lgtm stack
./run
# To setup datasources and preconfigured dashboards, run:
./setup_dashboards

# The following tests cover the necessary stuff for the setup to work
# To run tests, run:
tests/testrunner

# When done with the setup and wish to remove it from your system, run:
./uninstall
```

## Customization Guides

To customize the pre-configured dashboards and data sources, check the services directory in this repo. Once done with modifications, remember to `cp` them to the appropriate directories and restart the concerned service.

### Provisioning

- **Location**: `/etc/grafana/provisioning/` directory
- Automate configuration of:
  - Data sources
  - Dashboards
  - Alerting rules

### Alloy Configuration

[Grafana Alloy](https://grafana.com/docs/alloy/latest/) enables flexible observability collection:

- Custom pipeline creation
- Unified metrics/logs/traces processing
- Configuration: `/etc/config.alloy` (This is the location alloy.service expects) or `/etc/alloy/config.alloy`

#### Sample Alloy Config
```yaml
logging {
  level = "warn"
}

prometheus.exporter.unix "default" {
  include_exporter_metrics = true
  disable_collectors       = ["mdadm"]
}

prometheus.scrape "default" {
  targets = array.concat(
    prometheus.exporter.unix.default.targets,
    [{
      // Self-collect metrics
      job         = "alloy",
      __address__ = "127.0.0.1:12345",
    }],
  )

  forward_to = [
  // TODO: components to forward metrics to (like prometheus.remote_write or
  // prometheus.relabel).
  ]
}
```

### Dashboard Development

1. Create JSON Templates
   - Export from Grafana UI
   - Store in `/var/lib/grafana/dashboards/`
   - Use variables for reusability

2. Key Dashboard Best Practices
   - Implement template variables
   - Add documentation
   - Ensure consistent naming

## More Resources

- [Grafana Docs](https://grafana.com/docs/)
- [Alloy Docs](https://grafana.com/docs/alloy/latest/)
- [Loki Docs](https://grafana.com/docs/loki/latest/)
- [Mimir Docs](https://grafana.com/docs/mimir/latest/)
- [Alloy configurator](https://grafana.github.io/alloy-configurator/)
- [Grafana dashboard templates](https://grafana.com/grafana/dashboards/)
- [Getting started with the Grafana LGTM Stack](https://grafana.com/go/webinar/getting-started-with-grafana-lgtm-stack/)

## Troubleshooting

- run tests -  `tests/testrunner`

## Contributing

Contributions are welcome. Submit PRs or open issues with detailed descriptions.
