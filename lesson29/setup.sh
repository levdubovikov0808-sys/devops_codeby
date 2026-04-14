#!/bin/bash

echo "Starting Reddit App with Monitoring Stack..."

# Create necessary directories
mkdir -p prometheus grafana/dashboards grafana/datasources blackbox

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "docker-compose could not be found. Please install docker-compose first."
    exit 1
fi

# Start all services
docker-compose up -d

echo "Waiting for services to be ready..."
sleep 10

# Check service health
echo "Checking services:"
docker-compose ps

# Display access information
echo ""
echo "=== Access Information ==="
echo "Reddit UI: http://localhost:9292"
echo "Prometheus: http://localhost:9090"
echo "Grafana: http://localhost:3000 (admin/admin)"
echo "cAdvisor: http://localhost:8080"
echo "Blackbox Exporter: http://localhost:9115"
echo ""

# Function to wait for Grafana API
wait_for_grafana() {
    echo "Waiting for Grafana to be ready..."
    until curl -s http://localhost:3000/api/health > /dev/null; do
        sleep 2
    done
    echo "Grafana is ready!"
}

# Wait for Grafana
wait_for_grafana

echo "Setup complete! Grafana dashboard will be automatically provisioned."
echo "You can now access the monitoring stack at the URLs above."
