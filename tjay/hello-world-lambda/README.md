# team-delta hackathon

## AWS

### 1. Tutorial: Deploying a Hello World Application [(link)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html)


![diagram](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/images/sam-getting-started-hello-world.png)

```bash
#Step 1 - Download a sample application
sam init

#Step 2 - Build your application
cd sam-app
sam build

#Step 3 - Deploy your application
sam deploy --guided
```

#### Step 1: Download a Sample AWS SAM Application
```bash
sam init
```

```bash
❯ tree
.
├── README.md
├── events
│   └── event.json
├── hello_world
│   ├── __init__.py
│   ├── app.py                  # Contains your AWS Lambda handler logic.
│   └── requirements.txt        # Contains any Python dependencies the application requires, used for sam build
├── template.yaml               # Contains the AWS SAM template defining your application's AWS resources.
└── tests
    └── unit
        ├── __init__.py
        └── test_handler.py
```

#### Step 2: Build Your Application
```bash
sam build
```

The AWS SAM CLI comes with abstractions for a number of Lambda runtimes to build your dependencies, and copies the source code into staging folders so that everything is ready to be packaged and deployed. The sam build command builds any dependencies that your application has, and copies your application source code to folders under aws-sam/build to be zipped and uploaded to Lambda.

```bash
.aws_sam/
   └── build/
       ├── HelloWorldFunction/
       └── template.yaml
```

#### Step 3: Deploy Your Application to the AWS Cloud
```bash
sam deploy --guided
```
This command deploys your application to the AWS cloud. It take the deployment artifacts you build with the sam build command, packages and uploads them to an Amazon S3 bucket created by AWS SAM CLI, and deploys the application using AWS CloudFormation. In the output of the deploy command you can see the changes being made to your AWS CloudFormation stack.

```text
Error: Failed to create managed resources: An error occurred (OptInRequired) when calling the CreateChangeSet operation: The AWS Access Key Id needs a subscription for the service
```

Amazon required Card Authorization... I had to manually trigger it from the AWS console billing settings.

Deployed: https://h4962hjku9.execute-api.eu-central-1.amazonaws.com/Prod/hello/

#### Step 4: Testing Your Application Locally (Optional)

When you're developing your application, you might also find it useful to test locally. The AWS SAM CLI provides the sam local command to run your application using Docker containers that simulate the execution environment of Lambda. There are two options to do this:

  - Host your API locally
  - Invoke your Lambda function directly

##### 1. Host Your API Locally

```bash
sam local start-api
```
The start-api command starts up a local endpoint that replicates your REST API endpoint. It downloads an execution container that you can run your function locally in. The end result is the same output that you saw when you called your function in the AWS Cloud.

```bash
❯ time curl -v http://127.0.0.1:3000/hello
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to 127.0.0.1 (127.0.0.1) port 3000 (#0)
> GET /hello HTTP/1.1
> Host: 127.0.0.1:3000
> User-Agent: curl/7.64.1
> Accept: */*
>
* HTTP 1.0, assume close after body
< HTTP/1.0 200 OK
< Content-Type: application/json
< Content-Length: 26
< Server: Werkzeug/0.16.0 Python/3.7.5
< Date: Fri, 13 Dec 2019 10:01:44 GMT
<
* Closing connection 0
{"message": "hello world"}curl -v http://127.0.0.1:3000/hello

0.01s user 0.01s system 0% cpu 3.791 total
```

##### 2. Making One-off Invocations

```bash
❯ sam local invoke "HelloWorldFunction" -e events/event.json
Invoking app.lambda_handler (python3.7)

Fetching lambci/lambda:python3.7 Docker container image......
Mounting /Users/tjay/Code/netguru-hackathon/delta-serverless/tjay/sam-app-python/.aws-sam/build/HelloWorldFunction as /var/task:ro,delegated inside runtime container
START RequestId: 509b80e1-fd37-1afe-fbf9-127f17829c42 Version: $LATEST
END RequestId: 509b80e1-fd37-1afe-fbf9-127f17829c42
REPORT RequestId: 509b80e1-fd37-1afe-fbf9-127f17829c42	Init Duration: 208.40 ms	Duration: 6.05 ms	Billed Duration: 100 ms	Memory Size: 128 MB	Max Memory Used: 23 MB

{"statusCode":200,"body":"{\"message\": \"hello world\"}"}
```

The invoke command directly invokes your Lambda functions, and can pass input event payloads that you provide. With this command, you pass the event payload in the file event.json that's provided by the sample application.

Your initialized application came with a default aws-proxy event for API Gateway. A number of values are prepopulated for you. In this case, the HelloWorldFunction doesn't care about the particular values, so a stubbed request is OK. You can specify a number of values to be substituted in to the request to simulate what you would expect from an actual request. This following is an example of generating your own input event and comparing the output with the default event.json object:

```bash
sam local generate-event apigateway aws-proxy --body "" --path "hello" --method GET > api-event.json
```

#### Step 5: Clean Up

If you no longer need the AWS resources you created by running this tutorial, you can remove them by deleting the AWS CloudFormation stack that you deployed.
To delete the AWS CloudFormation stack created with this tutorial using the AWS Management Console, follow these steps:
  - Sign in to the AWS Management Console and open the AWS CloudFormation console at https://console.aws.amazon.com/cloudformation.
  - In the left navigation pane, choose Stacks.
  - In the list of stacks, choose aws-sam-getting-started.
  - Choose Delete.

When done, the status of the of the stack will change to DELETE_COMPLETE.

Alternatively, you can delete the AWS CloudFormation stack by executing the following AWS CLI command:
```bash
aws cloudformation delete-stack --stack-name sam-app-python --region eu-central-1
```

#### Conclusion
In this tutorial, you've done the following:
  - Created, built, and deployed a serverless application to AWS with AWS SAM.
  - Tested your application locally by using the AWS SAM CLI and Docker.
  - Deleted the AWS resources that you no longer need.

#### Debug
```ruby
def lambda_handler(event:, context:)
```
```ruby
event: {
  "httpMethod"=>"GET",
  "body"=>nil,
  "resource"=>"/hello",
  "requestContext"=>{
    "resourceId"=>"123456",
    "apiId"=>"1234567890",
    "resourcePath"=>"/hello",
    "httpMethod"=>"GET",
    "requestId"=>"c6af9ac6-7b61-11e6-9a41-93e8deadbeef",
    "accountId"=>"123456789012",
    "stage"=>"Prod",
    "identity"=>{
      "apiKey"=>nil,
      "userArn"=>nil,
      "cognitoAuthenticationType"=>nil,
      "caller"=>nil,
      "userAgent"=>"Custom User Agent String",
      "user"=>nil,
      "cognitoIdentityPoolId"=>nil,
      "cognitoAuthenticationProvider"=>nil,
      "sourceIp"=>"127.0.0.1",
      "accountId"=>nil
    },
    "extendedRequestId"=>nil,
    "path"=>"/hello"
  },
  "queryStringParameters"=>nil,
  "multiValueQueryStringParameters"=>nil,
  "headers"=>{
    "Host"=>"127.0.0.1:3000",
    "User-Agent"=>"curl/7.64.1",
    "Accept"=>"*/*",
    "X-Forwarded-Proto"=>"http",
    "X-Forwarded-Port"=>"3000"
  },
  "multiValueHeaders"=>{
    "Host"=>["127.0.0.1:3000"],
    "User-Agent"=>["curl/7.64.1"],
    "Accept"=>["*/*"],
    "X-Forwarded-Proto"=>["http"],
    "X-Forwarded-Port"=>["3000"]
  },
  "pathParameters"=>nil,
  "stageVariables"=>nil,
  "path"=>"/hello",
  "isBase64Encoded"=>false
}
```
```ruby
context:
  #<LambdaContext:0x0000560098a15740
    @clock_diff=1576214993753,
    @deadline_ms=1576233728207,
    @aws_request_id="d8ec5a5a-d4ea-1d06-dfaf-f32eb507277a",
    @invoked_function_arn="arn:aws:lambda:eu-central-1:1533663119:function:test",
    @log_group_name="/aws/lambda/test",
    @log_stream_name="2019/12/13/[$LATEST]70a339df73d3264d8dae38f7687f95d6",
    @function_name="test",
    @memory_limit_in_mb="128",
    @function_version="$LATEST"
  >
```

Gems have to be bundled before using Ruby 2.5.x and put into the `vendor/bundle` directory.

Final structure need to look like this (example):
```ruby
  {
    statusCode: 200,
    body: {
      message: "something"
    }
  }
```
