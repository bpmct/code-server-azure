# code-server-azure

Running code-server on Azure App Service

## This setup includes

- OpenSSH (SSH into your app)
- A domain+TLS (thanks Azure)
- Password (set by environment variable)

## How to run

Use image from Docker Hub: `bencdr/code-server-azure`.

Add an app setting under `Settings->Configuration`. Name it `PASSWORD` to set your password, it will restart your service after saving. Access through the default URL for the app.

## Troubleshooting

You can connect to your code server instance via SSH under `Development Tools -> SSH`

Azure, by default does not support tracking the logs. To enable this, follow these instructions: [https://docs.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs](https://docs.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs)

Then, you can preview logs under `Monitoring > Log Stream` or via this with the Azure CLI:

```sh
$ az webapp log tail --name [app] --resource-group [resource group]
```

