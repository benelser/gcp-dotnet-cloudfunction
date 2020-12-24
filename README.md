# dotnet-on-gcp

## Steps as of December 23, 2020
- Make project directory
```bash
mkdir my-first-gcp-func
cd my-first-gcp-func
```
- Create global.json in Project directory created above dotnet looks in current working directory first for version and global config
```bash
touch global.json
nano global.json
```
- Edit global.json
```json
{
  "sdk": {
    "version": "<SUPPORTED DOTNET VERSION>"
  }
}
```
- Install Google Cloud Functions templates (as of date above dependent on version 3.1)
```bash
dotnet new -i Google.Cloud.Functions.Templates::1.0.0-beta04
```
- Create Project
```bash
dotnet new gcf-http 
```
- Run
Followed above steps in cli then opened cs.proj in Visual Studio on Mac. Process should just work inside VS Code. This builds local kerasol server listening on 8080 just like the public Cloud Function url will. So local dev should be identical to deploying.
```bash
dotnet run
```

## References 
- [Functions-Framework](https://github.com/GoogleCloudPlatform/functions-framework-dotnet)
