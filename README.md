# Jamulus Docker

Docker container for running a [Jamulus](https://jamulus.io/) headless server.

## Quick Start

```bash
docker run -d \
  -p 22124:22124/udp \
  -e JAMULUS_MAX_USERS=20 \
  -e SERVER_NAME="My Jamulus Server" \
  dtinth/jamulus
```

## Environment Variables

Configure your Jamulus server using the following environment variables:

### Core Server Settings

| Variable | Default | Description |
|----------|---------|-------------|
| `JAMULUS_PORT` | `22124` | Server port (UDP). Must match the exposed port. |
| `JAMULUS_MAX_USERS` | `10` | Maximum number of concurrent users allowed. |
| `SERVER_WELCOME_MESSAGE` | `jamulus-docker` | Welcome message displayed to clients when they connect. |

### Server Registration

| Variable | Default | Description |
|----------|---------|-------------|
| `SERVER_DIRECTORY` | _(not set)_ | Directory server URL for public listing. When set, enables server registration. |
| `SERVER_NAME` | `Jamulus Server` | Server name shown in the directory (requires `SERVER_DIRECTORY`). |
| `SERVER_LOCATION` | `Unknown` | Server location/city (requires `SERVER_DIRECTORY`). |

**Example:**
```bash
docker run -d \
  -p 22124:22124/udp \
  -e SERVER_DIRECTORY="jamulus.io:22124" \
  -e SERVER_NAME="My Studio" \
  -e SERVER_LOCATION="New York" \
  dtinth/jamulus
```

### JSON RPC API

| Variable | Default | Description |
|----------|---------|-------------|
| `JSON_RPC_SECRET` | _(not set)_ | Secret token for JSON RPC API access. When set, enables the RPC API on port 22222. |

**Example:**
```bash
docker run -d \
  -p 22124:22124/udp \
  -p 22222:22222/tcp \
  -e JSON_RPC_SECRET="your-secret-token" \
  dtinth/jamulus
```

### Performance Options

| Variable | Default | Description |
|----------|---------|-------------|
| `MULTITHREADING` | `0` | Enable multithreading (`1` to enable). Can improve performance on multi-core systems. |
| `FASTUPDATE` | `0` | Enable fast update mode (`1` to enable). Reduces latency for clients using Small Network Buffers. **Requires faster CPU** and more bandwidth. |

**Example:**
```bash
docker run -d \
  -p 22124:22124/udp \
  -e MULTITHREADING=1 \
  -e FASTUPDATE=1 \
  dtinth/jamulus
```

### Audio Options

| Variable | Default | Description |
|----------|---------|-------------|
| `DELAY_PAN` | `0` | Enable delay panning effect (`1` to enable). |

## Docker Compose Example

```yaml
version: '3.8'
services:
  jamulus:
    image: dtinth/jamulus:latest
    ports:
      - "22124:22124/udp"
    environment:
      - JAMULUS_MAX_USERS=20
      - SERVER_NAME=My Jamulus Server
      - SERVER_LOCATION=Berlin
      - SERVER_DIRECTORY=jamulus.io:22124
      - SERVER_WELCOME_MESSAGE=Welcome to my server!
      - MULTITHREADING=1
      - FASTUPDATE=1
    restart: unless-stopped
```

## Advanced Usage

### Custom Port

```bash
docker run -d \
  -p 12345:12345/udp \
  -e JAMULUS_PORT=12345 \
  dtinth/jamulus
```

### High-Performance Server

For a low-latency, high-capacity server:

```bash
docker run -d \
  -p 22124:22124/udp \
  -e JAMULUS_MAX_USERS=50 \
  -e MULTITHREADING=1 \
  -e FASTUPDATE=1 \
  dtinth/jamulus
```

**Note:** `FASTUPDATE` requires more CPU and bandwidth. Monitor your server resources.

## Command-Line Flags

The following Jamulus flags are always enabled:
- `-s` - Start in server mode
- `-n` - No GUI (headless mode)

## More Information

- [Jamulus Website](https://jamulus.io/)
- [Jamulus Documentation](https://jamulus.io/wiki/)
- [Jamulus GitHub](https://github.com/jamulussoftware/jamulus)

## License

This Docker configuration is open source. Jamulus itself is licensed under the GPL.
