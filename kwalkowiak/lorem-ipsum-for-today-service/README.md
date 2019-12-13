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
Use `serverless deploy` to deploy the function using config data provided in the `serverless.yml`.
You can access the function using the `serverless invoke --function lorem-ipsum-html` function or by hitting the
URL given in `endpoints (web actions)` section after deployment.

# Dependencies management

In order to be able to use Ruby gem dependencies, you need to install the bundler in the standalone version
(so that all gems are included in the service catalog). Then, you need to exclude the `Gemfile`, `Gemfile.lock` and
`.bundle` catalog from the serverless deploy (you can do that using the `package -> exclude` option in the
`serverless.yml` file).
