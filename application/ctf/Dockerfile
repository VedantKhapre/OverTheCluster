FROM docker.io/library/node:22-slim AS builder
WORKDIR /opt/terminal
RUN npm install --no-audit --no-fund @devboxer/terminal-server@1.1.1

FROM docker.io/library/node:22-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends file binutils xxd less openssl \
 && rm -rf /var/lib/apt/lists/* \
 && for i in $(seq 1 10); do useradd -m -s /bin/bash level$i; done

RUN rm -rf /usr/local/lib/node_modules /usr/local/bin/npm /usr/local/bin/npx \
           /usr/local/bin/corepack /usr/local/bin/yarn* /opt/yarn-*

COPY --from=builder /opt/terminal /opt/terminal
RUN sed -i \
    -e "s/#1e1e1e/#0b0b0b/g" \
    -e "s/'#d4d4d4'/'#ffffff'/" \
    -e "/foreground:/a cursor: '#3b82f6', selectionBackground: '#3b82f655'," \
    -e "/foreground:/a black: '#0b0b0b', red: '#f87171', green: '#4ade80', yellow: '#facc15'," \
    -e "/foreground:/a blue: '#3b82f6', magenta: '#a78bfa', cyan: '#22d3ee', white: '#d4d4d8'," \
    /opt/terminal/node_modules/@devboxer/terminal-server/bin/server.js
ENV PATH="/opt/terminal/node_modules/.bin:${PATH}"

RUN --mount=type=bind,source=levels,target=/opt/levels \
    for i in $(seq 1 10); do bash /opt/levels/level$i/setup.sh; chmod 700 /home/level$i; done

USER level1
WORKDIR /home/level1
EXPOSE 8080
CMD ["devboxer-terminal", "--host", "0.0.0.0", "--port", "8080", "--no-welcome"]