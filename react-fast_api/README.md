# Containerized Deployment

## A full-stack application containerized and deployed as a practical DevOps exercise.

Architecture

* React frontend
* FastAPI backend
* PostgreSQL database
* Nginx reverse proxy
* Docker & Docker Compose
* Docker Hub image registry
* AWS EC2 deployment

## Docker

The application is split into separate containers and connected through Docker networks. The frontend uses a multi-stage Docker build, while the backend runs as a non-root user.
Images were scanned with Trivy for known vulnerabilities before deployment.

# Deployment Flow


  ```mermaid
flowchart TD
    A[GitHub Source] --> B[Build Container Image]
    B --> C[Scan Image with Trivy]
    C --> D[Push to Registery]
    D --> E[Pull from Registery to AWS server]
    E --> F[Docker Compose Build]
    F --> G[Deploy]
 ```

# Running Locally

Clone the repository:

`git clone https://github.com/Basharr-py/docker-projects`\
`cd first-docker-project`

Build and start the services:

`docker compose up --build -d`

Check running containers:

`docker compose ps`

# Project Purpose

This project was built to strengthen practical knowledge of:

Containerization → Networking → Reverse Proxying → Container Security → Image Registries → Deployment

> This is a learning/practice project rather than a production deployment.
> Refer to the app source code at nikhil-304/fastapi-playground
