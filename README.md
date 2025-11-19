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
| `JAMULUS_MAX_USERS` | `10` | [`-u`](https://jamulus.io/wiki/Running-a-Server#-u-or---numchannels) | Maximum number of concurrent users |
| `SERVER_WELCOME_MESSAGE` | `jamulus-docker` | [`-w`](https://jamulus.io/wiki/Running-a-Server#-w-or---welcomemessage) | Welcome message displayed to clients |

**Note:** The server always runs with [`-s`](https://jamulus.io/wiki/Running-a-Server#-s-or---server) (server mode) and `-n` (headless/no GUI).

### Server Registration

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `SERVER_DIRECTORY` | _(not set)_ | [`--directoryaddress`](https://jamulus.io/wiki/Running-a-Server#-e-or---directoryaddress) | Directory server address (format: `hostname:port`). When set, registers the server with the specified directory. Use built-in directories like `anygenre1.jamulus.io:22124`, `rock.jamulus.io:22424`, `jazz.jamulus.io:22324`, etc. |
| `SERVER_NAME` | `Jamulus Server` | [`--serverinfo`](https://jamulus.io/wiki/Running-a-Server#-o-or---serverinfo) | Server name (requires `SERVER_DIRECTORY` to be set) |
| `SERVER_LOCATION` | `Unknown` | [`--serverinfo`](https://jamulus.io/wiki/Running-a-Server#-o-or---serverinfo) | Server location (requires `SERVER_DIRECTORY` to be set) |

### JSON RPC API

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `JSON_RPC_SECRET` | _(not set)_ | `--jsonrpcsecretfile` | Enables JSON RPC API on port 22222. When set, the secret is written to `/etc/jamulus_rpc_secret.txt` and `--jsonrpcport 22222` is automatically added. |

### Performance Options

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `MULTITHREADING` | `0` | [`-T`](https://jamulus.io/wiki/Running-a-Server#-t-or---multithreading) | Enable multithreading (set to `1` to enable) |
| `FASTUPDATE` | `0` | [`-F` / `--fastupdate`](https://jamulus.io/wiki/Running-a-Server#-f-or---fastupdate) | Reduces latency for clients with Small Network Buffers (set to `1` to enable). Requires faster CPU to avoid dropouts and more bandwidth. |

### Audio Options

| Environment Variable | Default | Jamulus CLI Flag | Description |
|---------------------|---------|------------------|-------------|
| `DELAY_PAN` | `0` | [`--delaypan`](https://jamulus.io/wiki/Running-a-Server#-p-or---delaypan) | Enable delay panning effect (set to `1` to enable) |

## More Information

- [Jamulus Website](https://jamulus.io/)
- [Jamulus Documentation](https://jamulus.io/wiki/)
- [Jamulus GitHub](https://github.com/jamulussoftware/jamulus)
