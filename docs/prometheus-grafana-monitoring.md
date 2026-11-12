# Phase 14 - Prometheus and Grafana Monitoring

## Objective
Monitor ShopSphere Kubernetes workloads and application-level metrics using Prometheus and Grafana.

## Environment
- Kubernetes: Docker Desktop
- Namespace: shopsphere
- Monitoring Namespace: monitoring
- Prometheus and Grafana: kube-prometheus-stack

## Application Metrics
Added prometheus-client to the Flask API.

Metrics endpoint:
- /metrics

Metrics collected:
- shopsphere_http_requests_total
- shopsphere_http_request_duration_seconds

## Kubernetes Configuration
- Created ServiceMonitor: shopsphere-api
- Namespace: monitoring
- Target namespace: shopsphere
- Scrape path: /metrics
- Scrape interval: 15 seconds

## Prometheus Verification
Prometheus query:

shopsphere_http_requests_total

Verified that metrics were collected from all three ShopSphere API pods.

HTTP status observed: 200

## Grafana Verification
Configured Prometheus as the Grafana data source.

Query used:

sum by (pod) (rate(shopsphere_http_requests_total{namespace="shopsphere"}[5m]))

Verified application request metrics for ShopSphere API pods.

## Result
Prometheus successfully scraped application metrics.
Grafana successfully queried and displayed the metrics.

Phase 14 completed successfully.