FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  sudo \
  && rm -rf /var/lib/apt/lists/*

# Download and run the official Jamulus setup script
RUN curl https://raw.githubusercontent.com/jamulussoftware/jamulus/main/linux/setup_repo.sh > /tmp/setup_repo.sh && \
  chmod +x /tmp/setup_repo.sh && \
  /tmp/setup_repo.sh && \
  apt-get update && apt-get install -y \
  jamulus-headless \
  && rm -rf /var/lib/apt/lists/*

# Expose the default Jamulus port (UDP)
EXPOSE 22124/udp

# Set working directory
WORKDIR /home/jamulus

# Default configuration
# These can be overridden with environment variables or command-line arguments
ENV JAMULUS_PORT=22124 \
  JAMULUS_MAX_USERS=10 \
  SERVER_NAME="Jamulus Server" \
  SERVER_LOCATION="Unknown" \
  SERVER_WELCOME_MESSAGE="jamulus-docker"

# Run Jamulus server
# To customize: docker run -e JAMULUS_MAX_USERS=40 -e JAMULUS_SERVER_NAME="My Server" ...
COPY ./jamulus-server.sh /jamulus-server.sh
CMD /jamulus-server.sh
