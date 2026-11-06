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
ENV PATH="/opt/terminal/node_modules/.bin:${PATH}"

RUN --mount=type=bind,source=levels,target=/opt/levels \
    for i in $(seq 1 10); do bash /opt/levels/level$i/setup.sh; chmod 700 /home/level$i; done

USER level1
WORKDIR /home/level1
EXPOSE 8080
CMD ["devboxer-terminal", "--host", "0.0.0.0", "--port", "8080", "--no-welcome"]