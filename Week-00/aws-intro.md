# Introduction to Amazon Web Services (AWS)

Here’s a polished version of your notes:

## AWS Budgets

[AWS Budgets](https://aws.amazon.com/aws-cost-management/aws-budgets/) is a service that allows you to effectively plan and monitor your AWS costs and usage.

You can set budgets based on various parameters such as time, cost, or usage thresholds. The setup process is straightforward, making it easy to configure budgets that align with your financial or operational goals.

You get 2 budgets for free and if you go over the limit, it costs you a dollar for each budget that you create.

If you navigate to **Billing and Cost Management** -> **Cost and Usage Analysis** -> **Free Tier**, you can see how much of the free tier you have used and the services that you are using.

## IAM (Identity Access Management)

AWS Identity and Access Management (IAM) is a service that helps you securely control access to AWS resources. It allows you to manage who can access your AWS environment (authentication) and what they can do (authorization).

1. **User Management**:

   - Create individual users to allow specific people or applications to access AWS.
   - Assign permissions to users through policies.

2. **Groups**:

   - Combine users into groups to simplify permission management.
   - Policies attached to a group apply to all its members.

3. **Roles**:

   - Assign roles to AWS services or applications running on AWS to grant them specific permissions.
   - Useful for temporary access or when AWS resources need to act on your behalf.

4. **Policies**:

   - JSON documents that define permissions (e.g., allow or deny actions on specific resources).
   - Attach policies to users, groups, or roles.

5. **Fine-Grained Permissions**:

   - Control access at the level of services, resources, and actions (e.g., read-only access to S3 buckets).

6. **Multi-Factor Authentication (MFA)**:

   - Enhance security by requiring users to provide a second form of authentication (e.g., OTP).

7. **Access Keys**:
   - Provide programmatic access to AWS via CLI, SDKs, or APIs.
   - Must be securely stored and rotated regularly.

### Best Practices for IAM

1. **Least Privilege Principle**:

   - Grant only the permissions necessary for tasks.

2. **Use IAM Roles**:

   - Prefer IAM roles over long-term access keys for applications and services.

3. **Enable MFA**:

   - Use Multi-Factor Authentication for critical accounts, including the root user.

4. **Audit and Monitor Permissions**:

   - Regularly review IAM policies and permissions.
   - Use AWS CloudTrail for auditing IAM activities.

5. **Avoid Using the Root Account**:

   - Use the root account only for initial setup or critical tasks.

6. **Rotate Credentials Regularly**:
   - Rotate access keys and passwords frequently to enhance security.

### Common Use Cases

1. **Securing Access for Team Members**:

   - Create separate users for team members with appropriate permissions.

2. **Application-Level Access**:

   - Use IAM roles for applications to access other AWS services (e.g., Lambda accessing DynamoDB).

3. **Temporary Credentials**:

   - Use AWS STS (Security Token Service) for temporary access via roles.

4. **Service-to-Service Communication**:
   - Assign roles to EC2, Lambda, or ECS to allow interaction with other AWS resources securely.

Here’s a refined version of your notes on **Creating a User in AWS IAM**:

### Creating a User in AWS IAM

1. **Navigate to User Management**:

   - Go to the **IAM Console** → **Access Management** → **Users** → Click **Create User**.

2. **Specify User Details**:

   - Enter a **username** for the new user.
   - Check the **Enable console access** option if the user needs to log in to the AWS Management Console.
   - Optionally, configure programmatic access if the user requires API, CLI, or SDK access.

3. **Assign Permissions**:

   - Choose **Attach user to group**:
     - Select an existing group with the required permissions, or
     - Create a **new group** and attach the necessary policies (e.g., AdministratorAccess, S3FullAccess).

4. **Review and Create**:

   - Review the user details and permissions.
   - Click **Create User** to finalize.

5. **Set up an Alias (Recommended)**:
   - Navigate to the IAM **Dashboard**.
   - Create a **custom alias** for your account to make the login URL more user-friendly (e.g., `https://your-account-alias.signin.aws.amazon.com/console`).

## Using the AWS CLI

The AWS Command Line Interface (CLI) allows you to interact with AWS services directly from your terminal, either within the AWS Console (e.g., using **CloudShell**) or installed locally on your machine.

### Setting Up AWS CLI Auto-Prompt

The CLI auto-prompt feature guides you through AWS commands interactively. To enable it, run:

```bash
aws --cli-auto-prompt
```

### Security Token Service (STS)

To verify your identity and view details of the current user or role, use:

```bash
aws sts get-caller-identity
```

Example output:

```json
{
  "UserId": "userid",
  "Account": "accountid",
  "Arn": "arn:aws:iam::12345:root"
}
```

For more details, refer to the [AWS CLI STS documentation](https://docs.aws.amazon.com/cli/latest/reference/sts/get-caller-identity.html).

### Getting Account Contact Information

Retrieve your AWS account contact details with the following command:

```bash
aws account get-contact-information
```

Example output:

```json
{
  "ContactInformation": {
    "AddressLine1": "XXXX",
    "City": "XXXX",
    "CompanyName": "XXXX",
    "CountryCode": "XX",
    "FullName": "XXXXX",
    "PhoneNumber": "XXXX",
    "PostalCode": "XXXX",
    "StateOrRegion": "XXXX"
  }
}
```

### **Installing the AWS CLI Locally**

You can install the AWS CLI on your local machine by following the [official installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

### **Resources**

For additional commands and features, check the [AWS CLI documentation](https://docs.aws.amazon.com/cli/latest/reference/).

### Configuring AWS CLI Credentials

To interact with AWS services using the CLI, you need to configure your credentials. Follow these steps:

Run the following command in your terminal:

```bash
aws configure
```

Provide the necessary information when prompted:

```plaintext
AWS Access Key ID [None]: AKIAEXAMPLE1234567890
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-east-1
Default output format [None]: json
```

- **Access Key ID**: Replace with your actual AWS Access Key ID.
- **Secret Access Key**: Replace with your actual AWS Secret Access Key.
- **Region**: Specify your default region (e.g., `us-east-1`, `eu-west-2`).
- **Output Format**: Set to `json`, `text`, or `table` (default is none).

You can confirm your credentials and view your identity using the `sts get-caller-identity` command:

```bash
aws sts get-caller-identity
```

Example Output:

```json
{
  "UserId": "123456789012",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/example-user"
}
```

- The credentials you provide will be stored in the `~/.aws/credentials` file.
- Avoid hardcoding credentials in your application; instead, use environment variables or IAM roles when possible.
- For more details, refer to the [AWS CLI Configuration Guide](https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-configure.html).
