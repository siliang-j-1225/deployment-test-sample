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
 TBA

## Contributing
Feel free to create an issue first.