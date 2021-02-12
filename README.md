# code-server-azure

Running code-server on Azure App Service

## This setup includes

- OpenSSH (SSH into your app)
- A domain+TLS (thanks Azure)
- Password (set by environment variable)

## How to run

Use image from Docker Hub: `bencdr/code-server-azure`.

Add an app `PASSWORD` to set your password and restart the service. Access through the default URL for the app.

## Troubleshooting

Azure, by default does not support tracking the logs. To enable this, follow these instructions: [https://docs.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs](https://docs.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs)
