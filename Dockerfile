FROM debian:oldstable-slim

RUN apt-get update && apt-get install -y \
  curl \
  && rm -rf /var/lib/apt/lists/*

ARG JAMULUS_TAG

RUN REPO_URL="https://github.com/jamulussoftware/jamulus/releases/download/$JAMULUS_TAG" && \
  echo "deb $REPO_URL/ ./" > /etc/apt/sources.list.d/jamulus.list && \
  curl -sLo /etc/apt/trusted.gpg.d/jamulus.asc "$REPO_URL/key.asc" && \
  apt-get update && apt-get install -y jamulus-headless \
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
  SERVER_WELCOME_MESSAGE="jamulus-docker" \
  FASTUPDATE="0" \
  DIRECTORY_MODE="0" \
  DIRECTORY_FILE=""

# Run Jamulus server
# To customize: docker run -e JAMULUS_MAX_USERS=40 -e JAMULUS_SERVER_NAME="My Server" ...
COPY ./jamulus-server.sh /jamulus-server.sh
CMD /jamulus-server.sh
