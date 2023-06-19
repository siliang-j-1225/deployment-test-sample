# Example of Deployment Testing for a Complex System

## Introduction

### Problem Statement

Deploying a complex system can be a challenging task, especially when the system consists of multiple interconnected components. Even small changes can have far-reaching consequences, and it's essential to ensure that the system remains reliable and stable throughout the deployment process.

That's where deployment testing comes in. Deployment testing is the process of verifying that a system can be deployed and operates correctly in a production-like environment. By testing the system before deployment, you can identify potential issues and ensure that the system is ready to handle real-world scenarios.

### Our Solution

This sample shows a flexible and easy-to-use testing solution which helps to write effective test cases and accelerate application delivery. We focus on deployment tests to ensure the reliability and correctness of the system, and can tailor our solution to meet the specific needs of any environment. 

While we use *bats-core* as an example tool, there are also other testing tools available that can achieve the desired testing outcomes. 


### Why *bats-core*?
We choose *bats-core* for the following reasons:
- It's simple and familiar for developers.  
- It's flexibable.  
- Enable parallel execution.  
- TAP Compliance.  

## Getting Started

### Installing bats-core
`bats-core` is a TAP-compliant testing framework for Bash scripts that provides a simple way to verify the behavior of UNIX programs. It is a powerful and flexible testing tool that can test a wide range of software components, including web applications, databases, APIs, and more.

You can follow these links to install bats-core:
- https://github.com/bats-core/bats-core
- https://bats-core.readthedocs.io/en/stable/tutorial.html

In our sample, we used git submodules to include *bats-core* into project. Depends on your project, you can choose to install *bats-core* in different ways.

```bash
git submodule add https://github.com/bats-core/bats-core.git submodules/bats
git submodule add https://github.com/bats-core/bats-support.git submodules/test_helper/bats-support
git submodule add https://github.com/bats-core/bats-assert.git submodules/bats-assert
```



### Running the Sample
Copy **.env.sh** to **dev.env.sh**. You don't need to change anything in this file, as the `MOCKING` is set to `1` and test cases will always return `0` (success) in this mode. 

Run all tests cases with following command:
```shell
cd src
./submodules/bats/bin/bats ./test_suite_default/.
```
## Run Your Own Test Cases

To run your own test cases with our sample, you can follow these steps:

1. Create a new test suite by creating a new folder with the name "test_suite_xxxx", where "xxxx" is a descriptive name for your suite.

2. Add your test cases to the new test suite by creating a new file with the .bats extension and adding your test cases following the same format as the other test cases in the sample. Here's an example test case:

   ```sh
   @test "My Test Case" {
     . test_cluster.sh my_test_case.sh
   }
   ```

3. Run your new test cases by running the following command:

   ```sh
   ./submodules/bats/bin/bats ./ -t ./test_suite_xxxx/my_test_case.bats
   ```

   Replace "my_test_case" with the name of your test case file.

By following these steps, you can easily add your own test cases to our sample and use them to test your own system. Remember to write clear and concise test cases, group them using suites, and use tags for filtering, as described in the best practices section.

## Deployment Tests Automation

#### Why automate deployment tests?
Automating deployment tests using Azure DevOps CI/CD can help ensure that solutions are thoroughly tested, reliable, and consistent, while at the same time accelerating the development and deployment process.

- Consistent and predictable testing
- Faster feedback and deployment
- Improved collaboration and transparency
- Continuous improvement and optimization

#### How to automate deployment tests?

In this sample, we Azure DevOps CICD to automate the deployment tests. We have created an Azure DevOps pipeline consisting of following steps:

- Run Bats-Core tests

  Bats-Core supports saving test results as JUnit XML format with the *--report-formatter* option, and it also supports exporting test outputs/logs to local path by *--gather-test-outputs-in* option, the test results and outputs/logs together provide a clear insights for executed tests.

  Below is an example of running Bats-Core tests with these two opitons, which runs all tests of test suite *test_suite_xxxx*, and saving test results and outputs to local paths.

  ```bash
  ./submodules/bats/bin/bats ./test_suite_xxxx/ --report-formatter junit -o ../test_results/test_reports --gather-test-outputs-in ../test_results/test_logs
  ```

- Publish Test Results

  Azure DevOps supports showing JUnit test results in the CICD pipeline UI, we could add one simple pipeline task like below to publish the test results generated by the above bats command.

  ```yml
  - task: PublishTestResults@2
    inputs:
      testResultsFormat: 'JUnit'
      testResultsFiles: '**/report.xml'
      testRunTitle: 'Bats autotest results'
      failTaskOnFailedTests: true
    displayName: 'Publish test results'
  ```

- Publish Tests Logs

  There're two options to publish test outputs/logs to Azure DevOps, one option is to publish them as pipeline artifacts, another is to publish them as attachments of a test run.
  
  - Publish as pipeline artifacts

    If we publish the test outputs/logs as pipeline artifacts with the sample pipeline task configs below, the published logs files could be found in the *Summary* tab of the Azure DevOps pipeline UI.

    ```yml
    - task: PublishPipelineArtifact@1
      displayName: 'Publish test logs as artifacts'
      inputs:
        targetPath: './test_results/test_logs'
        artifact: 'Bats_Auto_Test_Logs'
        publishLocation: 'pipeline'
    ```

  - Publish as attachments of test run

    If we choose to publish test logs as attachment of test run, we need to call the Azure DevOps REST APIs below, which requires a script task to complete relevant works.

    ```bash
    # The ADO_BASE_URL value could be passed from Azure DevOps predefined system variable $(System.CollectionUri),
    # and ADO_PROJECT_ID value is from system variable $(System.TeamProjectId).
    POST https://{ADO_BASE_URL}{ADO_PROJECT_ID}/_apis/test/Runs/{TEST_RUN_ID}/attachments?api-version=7.0
    
    # While the TEST_RUN_ID value of the above request could be fetched by calling the GET request below,
    # the BUILD_URI value could be passed from ADO predefined build variable $(Build.BuildUri).
    GET https://{ADO_BASE_URL}{ADO_PROJECT_ID}/_apis/test/runs?buildUri={BUILD_URI}&api-version=7.0
    ```

    For more detials about the above REST APIs, please refer to the two online document below.
    - [List test runs](https://learn.microsoft.com/en-us/rest/api/azure/devops/test/runs/list?view=azure-devops-rest-7.0&tabs=HTTP).
    - [Create test run attachment](https://learn.microsoft.com/en-us/rest/api/azure/devops/test/attachments/create-test-run-attachment?view=azure-devops-rest-7.0&tabs=HTTP).

Below is the sample ADO pipeline yaml snippet with all the above three tasks.

```yml
    steps:
    - script: |
        ./submodules/bats/bin/bats ./test_suite_xxxx/ --report-formatter junit -o ../test_results/test_reports --gather-test-outputs-in ../test_results/test_logs
      displayName: 'Run atuomation tests with Bats'

    - task: PublishTestResults@2
      inputs:
        testResultsFormat: 'JUnit'
        testResultsFiles: '**/report.xml'
        testRunTitle: 'Bats autotest results'
        failTaskOnFailedTests: true
      displayName: 'Publish test results'

    - task: PublishPipelineArtifact@1
      displayName: 'Publish test logs as artifacts'
      inputs:
        targetPath: './test_results/test_logs'
        artifact: 'Bats_Auto_Test_Logs'
        publishLocation: 'pipeline'
```

And if publishing test outputs/logs as test run attachment, please follow the below task configures instead.

```yml
    # The attach_test_logs shell script contains CURL commands to call the above introduced ADO REST endpoints to publish test logs as test run attachment, with input arguments from ADO predefined system/build variables. 
    - script: |
        chmod +x ./src/utilities/attach_test_logs.sh
        ./src/utilities/attach_test_logs.sh $(System.CollectionUri) $(System.TeamProjectId) $(Build.BuildUri) $(System.AccessToken)
      displayName: 'Attach test logs to related test run'
```

Below is the sample shell script to call ADO REST endpoints to publish test logs as test run attachment.

```sh
#!/bin/sh

adoRestAPIBaseUrl=$1
projectId=$2
buildUri=$3
accessToken=$4

# Prepare the GET test run Id URL
getTestRunIdUrl="$adoRestAPIBaseUrl$projectId/_apis/test/runs?buildUri=$buildUri&api-version=7.0"

testResults=$(curl --location --request GET "$getTestRunIdUrl" \
--header "Accept: application/json" \
--header "Authorization: Bearer $accessToken")

testRunId=$(echo $testResults | jq -r .value[0].id)

# Zip relevant logs files
test_logs_zip_file="test_logs.zip"
(cd $(pwd)/test_results && zip -r ~/$test_logs_zip_file ./test_logs)
logsZipStream=$(base64 -w 0 ~/$test_logs_zip_file)

# Attach logs zip file to target test run
curl --location --request POST "$adoRestAPIBaseUrl$projectId/_apis/test/Runs/$testRunId/attachments?api-version=7.0" \
--header "Accept: application/json" \
--header "Authorization: Bearer $accessToken" \
--header "Content-Type: application/json" \
--data-raw '{
    "Stream": "'$logsZipStream'",
    "FileName": "'$test_logs_zip_file'"
}'
```

## Contributing
Feel free to create an issue first.