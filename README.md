# Backstage Weather Proxy Demo

This project demonstrates a simple Node.js "Weather Proxy" application integrated with a local instance of [Spotify Backstage](https://backstage.io).

## Prerequisites

*   [Docker Desktop](https://www.docker.com/products/docker-desktop/)
*   [Node.js](https://nodejs.org/) (for running the registration script)

## Installation & Setup

1.  **Start the Environment**
    Run the following command in the root directory to start Backstage and the Weather Proxy:
    ```bash
    docker-compose up -d --build
    ```
    *   Backstage will be available at: [http://localhost:7007](http://localhost:7007)
    *   Weather Proxy will be running at: [http://localhost:3001](http://localhost:3001)

2.  **Wait for Backstage**
    It may take a minute or two for the Backstage container (`janus-idp/backstage-showcase`) to fully start. You can check the logs with `docker-compose logs -f backstage`.

## Deploying / Registering the App

To "push" the app configuration to Backstage (i.e., register the component in the catalog):

1.  Navigate to the `weather-proxy` directory:
    ```bash
    cd weather-proxy
    ```

2.  Run the registration script:
    ```bash
    npm run register-backstage
    ```
    This script sends a request to the Backstage API to register the `catalog-info.yaml` file. Since we are using Docker volumes, we register the file path *inside the container*.

3.  **Verify in Backstage**
    *   Open Backstage at [http://localhost:7007](http://localhost:7007).
    *   Log in as "Guest" if prompted.
    *   Navigate to the **Catalog**.
    *   You should see the `weather-proxy` component.
    *   Click on **Docs** to view the generated documentation.
