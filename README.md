# Backstage Test

This project is used to test configuration in backstage using a dummy application.

1. It deploys a local instance of [Backstage](https://backstage.io).
2. It registers a component in the catalog (weather-proxy).
3. It registers an API in the catalog.
4. It registers a resource in the catalog.
5. It registers a system in the catalog.
6. It registers a group in the catalog.
7. It registers a domain in the catalog.

## Prerequisites

*   [Docker Desktop](https://www.docker.com/products/docker-desktop/)
*   [Node.js](https://nodejs.org/) (for running the registration script)

## Installation & Setup

1.  **Start the Environment**
    Run the following command in the root directory to start Backstage and the Weather Proxy:
    ```bash
    - install-docker.bat (windows)
    - install-docker.sh (linux)
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
