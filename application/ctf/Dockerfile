FROM node:22-slim
RUN npm install -g @devboxer/terminal-server
EXPOSE 8080
# Run as a non-root user for basic hardening
RUN useradd -m -u 10001 terminal
USER terminal
CMD ["devboxer-terminal", "--host", "0.0.0.0", "--port", "8080"]