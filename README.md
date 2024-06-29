

[![Build Status](https://dev.azure.com/odluser260641/udacityproject3namnm/_apis/build/status%2Fmanhnam91.udacity_devops_project_3?branchName=main)](https://dev.azure.com/odluser260641/udacityproject3namnm/_build/latest?definitionId=1&branchName=main)

# Ensuring Quality Releases - Project Overview

In this project, you'll develop and demonstrate your skills in using a variety of industry leading tools, especially Microsoft Azure, to create disposable test environments and run a variety of automated tests with the click of a button. Additionally, you'll monitor and provide insight into your application's behavior, and determine root causes by querying the application’s custom log files.

![enter image description here](https://video.udacity-data.com/topher/2020/June/5ed816b3_screen-shot-2020-06-03-at-2.27.42-pm/screen-shot-2020-06-03-at-2.27.42-pm.png)

## Dependencies
| Dependency | Link |
| ------ | ------ |
| Terraform | https://www.terraform.io/downloads.html |
| JMeter |  https://jmeter.apache.org/download_jmeter.cgi|
| Postman | https://www.postman.com/downloads/ |
| Python | https://www.python.org/downloads/ |
| Selenium | https://sites.google.com/a/chromium.org/chromedriver/getting-started |
| Azure DevOps | https://azure.microsoft.com/en-us/services/devops/ |


## Terraform
1.  Clone source code from Github repo
2.  Open a Terminal and connect to your Azure account to get the Subscription ID
```
	az login 
	az account list --output table
	az account set --subscription  "your subscription"
```
3. Create a storage account to Store Terraform state
```
    terraform/environments/test/configure-tfstate-storage-account.sh
```
4. Copy the storage_account_name, container_name, and access_key, and update the corresponding values in terraform/environments/test/main.tf accordingly.

```
terraform  {
	backend  "azurerm"  {
    	storage_account_name = "tfstatexxxxxxx"
    	container_name = "tfstate"
    	key = "test.terraform.tfstate"
    	access_key = 	"xxxxxxxx"
	}
}
```

5. Create a Service Principal for Terraform using the command below:
```
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/<your-subscription-id> --query "{ client_id: appId, client_secret: password, tenant_id: tenant }" 
```
copy the command output and update the corresponding values in terraform/environments/test/terraform.tfvars.

```
# Azure subscription vars
subscription_id = "xxxxxxxxxxxx"
client_id = "xxxxxxxxxxxx"
client_secret = "xxxxxxxxxxxx"
tenant_id = "xxxxxxxxxxxx"
```


6. Generate an SSH key and perform a keyscan of your GitHub to obtain the known hosts.
```
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```
![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/ssh-keygen.png?raw=true)

## Azure DevOps Pipeline

1. Go to https://dev.azure.com/, create new project
2. Install below extensions :

|Extensions|Link|
|--|--|
|JMeter|https://marketplace.visualstudio.com/items?itemName=AlexandreGattiker.jmeter-tasks&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|
|PublishHTMLReports|https://marketplace.visualstudio.com/items?itemName=LakshayKaushik.PublishHTMLReports&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|
|Terraform|https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList|

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/jmeter_addon.png?raw=true)

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/public_html_report_addon.png?raw=true)

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/terraform_addon.png?raw=true)

3. Go to Project Settings > Pipelines > Service Connection, Create the new Service Connection

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/screate_service_connection.png?raw=true)

4. Go to Project Settings > Agent pools > Add pool

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/create_agent_pool.png?raw=true)

5. Create a VM to use as an Agent
![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/create_agent_vm.png?raw=true)

6. Back to Azure Devops, Click to New Agent, copy the command, SSH to the VM and setup connection, make sure the Agent online:
![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/setup_agent.png?raw=true)

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/run_agent.png?raw=true)

7. Create a New Pipeline > select GitHub > Existing Azure Pipelines YAML file > Choose  **azure-pipelines.yaml**  file

8. Run pipeline, when step "Selenium Tests_Deploy_vmtest"you can see error : "No resource found ...". you must Registration VM on environment Pipeline and you only need to run it once

9. Go to Azure pipeline > Environments > test > Add resource > Virtual machines
10. Copy command, SSH to the VM > run copied command

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/vm_resource.png?raw=true) 

11. Back to pipeline and re-run
12. Wait the Pipeline is going to execute on the following Stages: Build > Deploy > Test
![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/pipeline_overview.png?raw=true)

The screenshots step-by-step:

![1.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/1.png?raw=true)
![2.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/2.png?raw=true)
![3.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/3.png?raw=true)
![4.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/4.png?raw=true)
![5.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/5.png?raw=true)
![6.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/6.png?raw=true)
![7.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/7.png?raw=true)
![8.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/8.png?raw=true)
![9.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/9.png?raw=true)
![10.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/10.png?raw=true)
![11.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/11.png?raw=true)
![12.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/12.png?raw=true)
![13.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/13.png?raw=true)
![14.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/14.png?raw=true)
![15.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/15.png?raw=true)
![16.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/16.png?raw=true)
![17.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/17.png?raw=true)
![18.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/18.png?raw=true)
![19.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/19.png?raw=true)
![20.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/20.png?raw=true)
![21.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/21.png?raw=true)
![22.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/22.png?raw=true)
![23.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/23.png?raw=true)
![24.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/24.png?raw=true)
![25.png](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/azure_pipeline/25.png?raw=true)

13. After the pipeline run complete, check the Test result and application service is online

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/test_plan.png?raw=true)

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/test_plan_detail.png?raw=true)

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/test_plan_result.png?raw=true)

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/fakerestapi_web.png?raw=true)


## Configure Logging

1. Create a Log Analytics workspace

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/create_LAW.png?raw=true)

### Set up email alerts in the App Service:

1. Log into Azure portal and go to the AppService that you have created.
2. On the left-hand side, under **Monitoring**, click **Alerts**, then **New Alert Rule**.

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/law_add_resource.png?raw=true)

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/law_action.png?raw=true)

3. Verify the resource is correct, then, click **Add a Condition** and choose **Http 404**.

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/law_condition_4xx.png?raw=true)

4. Set the Threshold value of `1`. Then click **Done**.
5. Create an action group and name it `myActionGroup`
6. Add “Send Email” for the Action Name, and choose **Email/SMS/Push/Voice** for the action type, and enter your email. Click **OK**.
7. Name the alert rule `Http 404`, and leave the severity at `3`, then click **Create**.


### Log Analytics

1. Go to the App service, then **Diagnostic Settings** > **Add Diagnostic Setting**.
2. Tick **AppServiceHTTPLogs** and **Send to Log Analytics Workspace** created in the previous step, then **Save**.
3. Go back to the App Service, then **App Service Logs**.
4. Turn on **Detailed Error Messages** and **Failed Request Tracing**, then **Save**.
5. Restart the app service.

###  Set up log analytics workspace properly to get logs:

1. Go to **Virtual Machines** and connect the VM created with Terraform to the Workspace (**Connect**).
2. Wait until it shows **Connected**.
![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/law_connect_vm.png?raw=true)

### Set up custom logging:

1. In the log analytics workspace, go to **Tables** > **Create** > **New Custom Logs (MMA) > **Choose selenium.log File**.
   - Select the file `selenium.log` > **Next** > **Next**.
   - Enter the following paths as type Linux: `/var/log/selenium/selenium.log`.
   - Give it a name (`selenium_logs_CL`) and click **Done**.

2. Go to the App Service web page, navigate the links, and generate 404 not found errors (e.g., by visiting non-existent pages).

3. After some minutes ( 3 to 10 minutes) , check the email inbox

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/email_alert.png?raw=true)

### Monitoring & Observability
![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/law_query.png?raw=true)

![enter image description here](https://github.com/quyetnn1102/udacity-azure-devops-project3/blob/main/screenshots/law_query_cl.png?raw=true)

