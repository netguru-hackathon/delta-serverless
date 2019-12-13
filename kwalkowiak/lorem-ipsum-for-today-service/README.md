# Lorem ipsum for today in HTML
Simple Ruby app run on Serverless framework using Apache OpenWhisk.

# Installation
1. Install Node.js v6.5.0 or later.
2. Install Serverless framework alongside the OpenWhisk plugin provider.
```
npm install --global serverless serverless-openwhisk
```
3. Install any other NPM dependencies.
```
npm install
```
4. Install Ruby dependencies.
```
bundle install
```
5. Login to your IBM OpenWhisk Account:
```
ibmcloud login
```
6. Set the target organization (if you have a `Lite` account, the org name is your account email) and space
(you can have multiple namespaces e.g. each for a development life cycle step (`dev`, `test`, `production`, ect.))
```
ibmcloud target -o ORG -s SPACE
```

# Deployment



Before you can deploy your service to OpenWhisk, you need to have an account registered with the platform.

- *Want to run the platform locally?* Please read the project's [*Quick Start*](https://github.com/openwhisk/openwhisk#quick-start) guide for deploying it locally.
- *Want to use a hosted provider?* Please sign up for an account with [IBM Bluemix](https://console.ng.bluemix.net/) and then follow the instructions for getting access to [OpenWhisk on Bluemix](https://console.ng.bluemix.net/openwhisk/).

Account credentials for OpenWhisk can be provided through a configuration file or environment variables. This plugin requires the API endpoint, namespace and authentication credentials.

**Do you want to use a configuration file for storing these values?** Please [follow the instructions](https://console.ng.bluemix.net/openwhisk/cli) for setting up the OpenWhisk command-line utility. This tool stores account credentials in the `.wskprops` file in the user's home directory. The plugin automatically extracts credentials from this file at runtime.  No further configuration is needed.

**Do you want to use environment variables for credentials?** Use the following environment variables to be pass in account credentials. These values override anything extracted from the configuration file.

- *OW_APIHOST* - Platform endpoint, e.g. `openwhisk.ng.bluemix.net`
- *OW_AUTH* - Authentication key, e.g. `xxxxxx:yyyyy

### Have you installed the provider plugin?

Install project dependencies which includes the OpenWhisk provider plugin.

```
$ npm install
```

**_…and that's it!_**

### Deploy Service

Use the `serverless` command to deploy your service. The sample `handler.js` file can be deployed without modification.

```shell
serverless deploy
```



### Issues / Feedback / Feature Requests?

If you have any issues, comments or want to see new features, please file an issue in the project repository:

https://github.com/serverless/serverless-openwhisk
