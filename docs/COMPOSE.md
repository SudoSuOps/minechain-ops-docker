# Docker Compose Examples

## Miner Fleet

```bash
docker compose -f compose/miner-compose.yml up -d
```

## Monitoring Stack

```bash
docker compose -f compose/monitoring-compose.yml up -d
```

Ensure `configs/` directory contains miner JSON configs and `compose/monitoring-compose.yml` references a valid Prometheus configuration.
