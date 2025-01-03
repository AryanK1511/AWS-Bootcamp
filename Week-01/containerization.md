# Containerizing an Application

## Helpful Resources to Check

- [Open Container Initiative](https://opencontainers.org)

## Registries and Artifactories

### Registry

- **Definition:** A **Registry** is a centralized storage system used to store and manage **container images** (such as Docker images) or **software packages** (e.g., npm, Maven packages).
- **Purpose:** The registry is primarily focused on storing, sharing, and versioning containers or code artifacts so they can be pulled and used in different environments.
- **Common Examples:**

  - **Docker Hub:** A popular container registry that stores Docker images.
  - **GitHub Container Registry:** A registry that stores Docker images alongside code repositories.
  - **Google Container Registry (GCR):** A registry service by Google Cloud for storing Docker images.

- **Functionality:**
  - Storing **images** and **versioning** them.
  - Ensures that container images can be easily **pulled** and **pushed** across environments (e.g., development, testing, production).
- **Use Case:** When deploying applications using Docker containers, you would store your container images in a registry.

### Artifactory

- **Definition:** **Artifactory** is a universal **artifact repository manager**. It is designed to store and manage a variety of software artifacts such as **build artifacts, libraries, dependencies, container images**, and more, across different programming languages and tools.
- **Purpose:** Artifactory is more comprehensive than a registry and is used for managing **all types of artifacts** throughout the software development lifecycle, from building to deployment. It supports **multiple repository formats** and integrates with various CI/CD tools.
- **Common Examples:**
  - **JFrog Artifactory:** A widely-used artifact repository that supports Docker images, npm packages, Maven artifacts, etc.
- **Functionality:**
  - Can store **multiple types of artifacts** (not just container images).
  - Provides **security**, **access control**, and **metadata** for the artifacts.
  - Supports a **wide range of package formats** (e.g., npm, Maven, NuGet, Docker, and more).
  - Includes **integration with CI/CD tools**, allowing artifacts to be stored and retrieved as part of build and deployment processes.
- **Use Case:** Artifactory is used in **enterprise-level DevOps pipelines** for managing software packages, dependencies, and build outputs, alongside Docker images.

### Some moe notes

- **Docker Images**:
  - Every Docker image starts from the [scratch](https://hub.docker.com/_/scratch) image (a minimal image).
  - Each command in a Dockerfile (e.g., `RUN`, `COPY`) creates a layer in the image. For example, a minimal `scratch` image will have 3 layers (each command you run adds a layer).
- **Union File System**:

  - Docker containers use a **union file system** to combine all these layers into a single merged layer at runtime, which makes the container start faster and saves storage space.

- **RUN Command**:
  - The `RUN` command creates a new image layer and executes instructions (like installing packages) during the build process.
- **CMD Command**:
  - The `CMD` instruction specifies the **default command** to run when the container starts. This can be overridden when running the container.
- **Attaching to a Running Container**:
  - In some extensions (like Docker in VSCode), you can click to **attach a shell** to interact with the running container.
  - Alternatively, you can use basic Docker commands to interact with containers.

### Basic Docker Commands

1. **Build an image from a Dockerfile**:

   ```bash
   docker build -t <image-name> .
   ```

   - `-t <image-name>`: Tags the image with a name.
   - `.`: Specifies the build context (the current directory).

2. **Run a container**:

   ```bash
   docker run -p <host-port>:<container-port> <image-name>
   ```

   - `-p <host-port>:<container-port>`: Maps ports from the host to the container.
   - `<image-name>`: The image you want to run.

3. **List running containers**:

   ```bash
   docker ps
   ```

4. **List all containers (including stopped)**:

   ```bash
   docker ps -a
   ```

5. **Attach to a running container**:

   ```bash
   docker exec -it <container-id> /bin/bash
   ```

   - `exec -it <container-id>`: Executes a command in the running container.
   - `/bin/bash`: Opens a bash shell inside the container.

6. **Stop a running container**:

   ```bash
   docker stop <container-id>
   ```

7. **Remove a stopped container**:

   ```bash
   docker rm <container-id>
   ```

8. **Remove a Docker image**:

   ```bash
   docker rmi <image-name>
   ```

9. **View Docker images**:

   ```bash
   docker images
   ```

10. **Build and run a container in one step (detached mode)**:

    ```bash
    docker run -d -p <host-port>:<container-port> <image-name>
    ```

    - `-d`: Runs the container in **detached mode**, meaning in the background.
