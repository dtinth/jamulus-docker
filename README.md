# Jamulus Docker

Docker container for running a [Jamulus](https://jamulus.io/) headless server.

## Docker Images

- **Docker Hub**: https://hub.docker.com/r/dtinth/jamulus
- **GitHub Container Registry**: https://github.com/dtinth/jamulus-docker/pkgs/container/jamulus

## Environment Variables

Configure your Jamulus server using environment variables. Each variable maps to specific Jamulus command-line options.

### Core Server Settings

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `JAMULUS_PORT` | `22124` | `-p` | Server port (UDP) |
| `JAMULUS_MAX_USERS` | `10` | `-u` | Maximum number of concurrent users |
| `SERVER_WELCOME_MESSAGE` | `jamulus-docker` | `-w` | Welcome message displayed to clients |

**Note:** The server always runs with `-s` (server mode) and `-n` (headless/no GUI).

### Server Registration

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `SERVER_DIRECTORY` | _(not set)_ | `--directoryaddress` | Directory server address (format: `hostname:port`) |
| `SERVER_NAME` | `Jamulus Server` | `--serverinfo` | Server name (first part of serverinfo) |
| `SERVER_LOCATION` | `Unknown` | `--serverinfo` | Server location (second part of serverinfo) |

**Details:**
- When `SERVER_DIRECTORY` is set, the server registers with the specified directory
- The `--serverinfo` flag is constructed as `"$SERVER_NAME;$SERVER_LOCATION"`
- Built-in directories include:
  - `anygenre1.jamulus.io:22124` (Any Genre 1)
  - `anygenre2.jamulus.io:22224` (Any Genre 2)
  - `rock.jamulus.io:22424` (Rock)
  - `jazz.jamulus.io:22324` (Jazz)
  - `classical.jamulus.io:22524` (Classical/Folk)
  - `choral.jamulus.io:22724` (Choral/Barbershop)

### JSON RPC API

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `JSON_RPC_SECRET` | _(not set)_ | `--jsonrpcsecretfile` | Enables JSON RPC API on port 22222 |

**Details:**
- When set, the secret is written to `/etc/jamulus_rpc_secret.txt`
- Automatically adds `--jsonrpcport 22222` and `--jsonrpcsecretfile /etc/jamulus_rpc_secret.txt`

### Performance Options

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `MULTITHREADING` | `0` | `-T` | Enable multithreading (set to `1` to enable) |
| `FASTUPDATE` | `0` | `--fastupdate` or `-F` | Reduce latency for clients with Small Network Buffers (set to `1` to enable) |

**FASTUPDATE Details:**
- Reduces latency when clients connect with the Small Network Buffers option
- Requires faster CPU to avoid dropouts
- Requires more bandwidth to enabled clients

### Audio Options

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `DELAY_PAN` | `0` | `--delaypan` | Enable delay panning effect (set to `1` to enable) |

## More Information

- [Jamulus Website](https://jamulus.io/)
- [Jamulus Documentation](https://jamulus.io/wiki/)
- [Jamulus GitHub](https://github.com/jamulussoftware/jamulus)
