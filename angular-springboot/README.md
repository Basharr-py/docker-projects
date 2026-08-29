# Angular + Spring Boot + PostgreSQL

A full-stack contact management application containerized and deployed with Docker Compose on AWS EC2.

## Architecture

```text
                    Internet
                       │
                  HTTPS :443
                       │
                       ▼
                ┌─────────────┐
                │    Nginx    │
                │             │
                │ SSL + Proxy │
                │ Angular SPA │
                └──────┬──────┘
                       │
              ┌────────┴────────┐
              │                 │
           /* │              /api/*
              │                 │
              ▼                 ▼
          Angular          Spring Boot
          Frontend           Backend
                                │
                                ▼
                           PostgreSQL
```

### Components

* **Angular** — frontend
* **Spring Boot** — REST API
* **PostgreSQL** — database
* **Nginx** — HTTPS termination, static file serving and reverse proxy
* **Docker Compose** — container orchestration
* **Let's Encrypt / Certbot** — SSL certificate
* **DuckDNS** — DNS
* **AWS EC2** — deployment

## Request Flow

Users access the application through a DNS hostname:

```text
https://basharr-tester.duckdns.org
```

DNS resolves the hostname to the EC2 instance.

Nginx receives HTTPS traffic on port `443` and:

```text
/          → Angular
/api/*     → Spring Boot
```

The backend communicates with PostgreSQL through Docker's internal network.

Only Nginx is publicly exposed.

## Docker Workflow

```text
Angular source
      │
      ▼
Node.js build stage
      │
      ▼
Production Angular files
      │
      ▼
Nginx image
      │
      ▼
Docker Compose
      │
      ├── Nginx
      ├── Spring Boot
      └── PostgreSQL
```

The Angular application is built during the Docker image build using a multi-stage Dockerfile. The resulting static files are served directly by the Nginx container.

## HTTPS

Let's Encrypt certificates are generated with Certbot on the EC2 host:

```bash
sudo certbot certonly --standalone -d basharr-tester.duckdns.org
```

The certificate directory is mounted read-only into the Nginx container:

```yaml
- /etc/letsencrypt:/etc/letsencrypt:ro
```

Nginx terminates TLS and serves the application over HTTPS.

## Key Docker Commands

```bash
# Build images
docker compose build

# Start application
docker compose up -d

# View services
docker compose ps

# View logs
docker compose logs -f nginx

# Test Nginx configuration
docker compose exec nginx nginx -t

# Stop application
docker compose down
```

## Lessons Demonstrated

* Docker and Docker Compose
* Multi-stage container builds
* Container networking
* Nginx reverse proxy
* Angular SPA deployment
* PostgreSQL persistence
* DNS configuration
* HTTPS/TLS with Let's Encrypt
* AWS EC2 deployment
* Basic production-oriented container architecture
* Container registry

## Future Improvements

* CI/CD
* Automated certificate renewal
* Infrastructure as Code
* Monitoring and centralized logging

## Author - Basharr

This project was built as a hands-on learning project focused on Docker, Linux, networking, Nginx, cloud deployment, and production-oriented application infrastructure.
>The original source code I built into the image can be viewed at [Source-Code](githubs.com/docker-fullstack-lab/angular-springboot)
