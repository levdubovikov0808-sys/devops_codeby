# Reddit App Monitoring Stack

## Architecture
- **Reddit App**: UI, Post, Comment services with MongoDB backends
- **Prometheus**: Metrics collection and storage
- **Grafana**: Visualization with auto-provisioned dashboards
- **cAdvisor**: Container monitoring
- **Blackbox Exporter**: Endpoint health and performance monitoring

## Quick Start

1. **Setup and run**:
```bash
make setup
