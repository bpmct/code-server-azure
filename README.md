# code-server-azure

Deploying code-server on Azure App Service. Can use [--link](https://github.com/cdr/code-server#cloud-program-%EF%B8%8F) or an Azure domain.

## This setup includes

- OpenSSH (connect via Azure's portal)
- Domain+TLS (Provided by --link or Azure)
- Authentication (Provided by --link or password)
- A mini redirect web server (if running --link)

## How to run

1. Create a [new web app](https://portal.azure.com/#create/Microsoft.WebSite) from Azure's portal
1. Deploy this container from the Docker Hub: `bencdr/code-server-azure`
1. Track the status of your deployment via the "Deployment Center"
1. Hit "Browse" on the app overview page to visit your code-server workspace

After deploying, you can configure with the following settings (Settings > Configuration > Application Settings)

- `LINK_NAME`: A custom name used for code-server --link (ex. `[linkname]-githubusername.cdr.co`)
- `PASSWORD`: Password to log into code-server. Adding this will disable the use of --link
- `GIT_REPO`: A public git repo to clone (see [#3](https://github.com/bpmct/code-server-azure/issues/3))
- `START_DIR`: The directory code-server opens (default: `/home/coder/project`)
- `DISABLE_SSH`: Disable SSH access via the Azure portal, saves resources

⚠️  If you are using the **Free (F1) app service plan:** do not set a password. code-server --link will handle your access. See [#2](https://github.com/bpmct/code-server-azure/issues/2) additional info

## Troubleshooting

You can connect to your code server instance via SSH under `Development Tools -> SSH`. Logs for code-server and the mini web server are stored in `/home/coder/`.

By default, Azure does not have logging enabled. To enable logs, go to "Monitoring -> App Service Logs" and turn on. Retention period can be set to 1 day. Then, you can preview logs under "Monitoring > Log Stream" or via the Azure CLI:

```sh
$ az webapp log tail --name [app] --resource-group [resource group]
```
