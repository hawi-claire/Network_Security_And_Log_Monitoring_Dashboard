#!/usr/bin/env bats
# These tests verify service status and restarts, basic connectivity, datasource validation,
# log generation, metric collection and resource consumption etc...

# Service tests
@test "All required services (grafana, alloy, loki and mimir) are running..." {
  services=("grafana-server" "alloy" "loki" "mimir")

  for service in "${services[@]}"; do
    run systemctl is-active $service
    echo "Service: $service"
    [ "$output" = "active" ]
  done
}

@test "Services survive a restart..." {
  services=("grafana-server" "alloy" "loki" "mimir")
  
  for service in "${services[@]}"; do
    run sudo -p $'\n[sudo] password for %u: ' systemctl restart $service
    [ "$status" -eq 0 ]
    sleep 5
    run systemctl is-active $service
    [ "$output" = "active" ]
  done
}

# Basic connectivity tests
@test "Grafana is accessible locally on port 3000..." {
    run curl -s -o /dev/null -w "%{http_code}" -L http://localhost:3000/
    [ "$output" = "200" ]
}

@test "Grafana is accessible @ $TEST_IP on port 3000..." {
    run curl -s -o /dev/null -w "%{http_code}" -L http://$TEST_IP:3000/
    [ "$output" = "200" ]
}

@test "Loki is ready on port 3100..." {
    run curl -s -o /dev/null -w "%{http_code}" http://localhost:3100/ready
    sleep 15
    run curl -s -o /dev/null -w "%{http_code}" http://localhost:3100/ready
    sleep 15
    run curl -s -o /dev/null -w "%{http_code}" http://localhost:3100/ready
    [ "$output" = "200" ]
}

@test "Mimir is ready on port 9009..." {
    run curl -s -o /dev/null -w "%{http_code}" http://localhost:9009/ready
    sleep 15
    run curl -s -o /dev/null -w "%{http_code}" http://localhost:9009/ready
    [ "$output" = "200" ]
}

# Dashboard and datasource validation
@test "Grafana provisioning directories exist..." {
  [ -d "/etc/grafana/provisioning/dashboards" ]
  [ -d "/etc/grafana/provisioning/datasources" ]
}

@test "Dashboard and datasource provisioning files exist..." {
  [ -f "/etc/grafana/provisioning/dashboards/default.yaml" ]
  [ -f "/etc/grafana/provisioning/datasources/default.yaml" ]
  run ls -la /var/lib/grafana/dashboards/*.json
  [ "$status" -eq 0 ]
}

@test "Expected datasources (Loki & Mimir) are configured and ready..." {
  required_datasources=("Loki" "Mimir")
  
  for datasource in "${required_datasources[@]}"; do
    run curl -u admin:admin -s http://localhost:3000/api/datasources/name/$datasource
    echo "Output: $output"
    [ "$status" -eq 0 ]
    echo "$output" | grep -o $datasource
  done
}


# Log generation and metric collection tests
@test "System can generate test logs for Loki..." {
  run logger "BATS test log message $(date)"
  [ "$status" -eq 0 ]
}

@test "Metrics (Node exporter) are being collected by Mimir..." {
  # Assuming node_exporter is running
  run curl -s "http://localhost:9009/prometheus/api/v1/query?query=node_memory_MemFree_bytes"
  [ "$status" -eq 0 ]
  echo "$output" | grep -q "node_memory_MemFree_bytes"
}


# Resource usage test
@test "Services are not consuming excessive memory - < 2GB..." {
  services=("grafana" "alloy" "loki" "mimir")

  for service in "${services[@]}"; do
    run bash -c "ps -o rss= -C $service | sort -nr | head -1"
    mem_usage=$(echo "$output" | awk '{print $1}')

    echo "mem_usage: '$mem_usage'"
    [ "$mem_usage" -lt 2000000 ]
  done
}
