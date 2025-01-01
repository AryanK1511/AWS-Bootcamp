# AWS Organizations & AWS IAM

**Cyber Security Goal in an Organization:** Identify and inform the business on any Technical Risk that the business may be expose to.

## Add MFA to root user

- Root user is the main account that you use to log in to your main account.
- This user is the most powerful user, having MFA for this is very important.
- Incase of compromise, this account is the same as domain admin.

## Create an Organizational Unit (OU)

AWS Organizations is a service that allows you to centrally manage and consolidate multiple AWS accounts within the AWS Cloud. For example, you could have a "Netflix" organization and an "Amazon" organization, and these two organizations would remain completely separate unless you explicitly connect them. AWS Organizations operates through a central management account, often referred to as the **Management Account**.

### Key Points and Best Practices

1. **Management Account Usage**:

   - The **Management Account** (also known as the **root account**) is the first AWS account created when setting up AWS Organizations.
   - It is highly recommended **not** to use the management account for running resources (e.g., EC2 instances, databases, or other workloads). Instead, its sole purpose should be to create and manage **Organizational Units (OUs)** and delegate administrative tasks.
     - Think of it as the master controller of your AWS ecosystem.
   - Delegate responsibilities to specific **AWS accounts** within OUs for better security and organization.

2. **Creating Organizational Units (OUs)**:

   - An **Organizational Unit (OU)** is a logical group of accounts within AWS Organizations.
   - For example, you might create OUs for specific departments (e.g., "Finance," "Marketing") or environments (e.g., "Development," "Production").
   - To create an OU:
     - Access the AWS Organizations console.
     - Navigate to the **root** of the organization.
     - Check the **root** box and click the **Create new Organizational Unit** button.

3. **Approach to Account Management**:

   - **Standby and Active Accounts**:
     - One strategy in large organizations is to categorize accounts into **Active Accounts** (used for running workloads) and **Standby Accounts** (ready for future use or disaster recovery).
     - Place these accounts in separate OUs, such as an "Active" OU and a "Standby" OU.
   - **Business Units (BUs)**:
     - Alternatively, you can organize accounts by business units (BUs). Each BU gets its own OU (e.g., "HR BU," "IT BU"). This allows for granular management of accounts and policies.

4. **Automation and Delegation**:

   - You can automate the creation and vending (provisioning) of AWS accounts for each department or project using tools like **AWS Control Tower** or custom scripts.
   - Assign a **Designated Owner** for each account to ensure accountability and proper governance.

5. **IAM Roles and Permissions**:

   - The **root user** (the email address and password used to create the management account) has the highest level of permissions and should only be used for initial setup or rare administrative tasks.
   - For day-to-day tasks, create an **Admin IAM user** or group with the necessary permissions to manage AWS resources securely.

6. **Account Pools Over Single Organizations**:
   - In large organizations, it’s better to create **account pools** instead of one massive organization for all Business Units (BUs). This provides flexibility and prevents management bottlenecks.

### Additional Notes

- **Why Not Use the Root User?**  
   Using the root user is risky because it has unrestricted permissions. Any compromise could expose the entire organization. Always secure the root user with multi-factor authentication (MFA) and use IAM roles for tasks.
- **Benefits of OUs**:
  - Apply **Service Control Policies (SCPs)** to manage permissions and ensure compliance. For example, you can restrict specific regions or services at the OU level.
  - Simplifies billing and auditing by consolidating accounts under OUs.

## AWS CloudTrail

AWS CloudTrail is a service that enables governance, compliance, operational auditing, and risk auditing of your AWS account. It tracks and records API calls and events across your AWS infrastructure and provides visibility into user and resource activity.

### Key Features

- **Monitor Data Security and Residency**:  
   CloudTrail records actions taken on your AWS resources, helping you ensure data security and meet compliance requirements.
- **Understand AWS Scoping Concepts**:
  - **Region**: A geographically isolated area (e.g., `us-east-1`) where AWS services are hosted.
  - **Availability Zone (AZ)**: A single data center or cluster of data centers within a region.
  - **Global Services**: Services like AWS CloudFront and IAM, which operate across multiple regions.
- **Audit Logs for Incident Response (IR) and Forensics**:  
   CloudTrail logs provide valuable data for investigating security incidents or anomalies.

### Steps to Create a CloudTrail

1. **Create a Trail**:

   - Go to the CloudTrail console and click **Create Trail**.
   - Enable the trail for **all accounts in your AWS Organization** to centralize logging.

2. **Create an S3 Bucket**:

   - Create a new S3 bucket to store the logs.
   - Name the bucket according to your organization's naming conventions.

3. **Configure a Customer-Managed AWS KMS Key**:

   - Use AWS Key Management Service (KMS) to encrypt your CloudTrail logs for added security.
     - **New Key**: Create a new customer-managed KMS key if none exists.
     - **Existing Key**: Use an existing key.
     - **KMS Alias**: Provide a recognizable alias to identify the key easily.
   - Note: The **KMS key** and **S3 bucket** must be in the same region to ensure proper encryption and decryption.

4. **Choose Log Events**:

   - **Event Types**:

     - **Management Events**: Record management operations (e.g., creating or modifying resources).
     - **Data Events**: Log resource-level operations (e.g., S3 object access or Lambda function invocation). These are optional and may incur additional charges.
     - **Insights Events**: Detect unusual activity, errors, or anomalous user behavior by measuring deviations from a seven-day baseline.
     - **Network Activity Events**: Capture resource operations performed within a Virtual Private Cloud (VPC) endpoint.

   - **Activity Types**:
     - **Read Events**: Log read-only operations like `GetObject` or `DescribeInstances`.
     - **Write Events**: Log write operations like `PutObject` or `StartInstances`.
     - Exclusions: Optionally exclude AWS KMS events or Amazon RDS Data API events.

5. **Advanced Event Selectors**:

   - Use advanced event selectors for fine-grained control, allowing you to specify resource types, event sources, and more.
   - Optionally switch to basic event selectors for simplicity.

6. **Insights and Baselines**:
   - Enable **Insights Events** to identify unusual API call rates or error rates compared to normal activity.
   - Monitor **Network Activity Events** for operations involving VPC endpoints.

### AWS Key Management Service (KMS)

AWS KMS is a managed service that enables you to create and control cryptographic keys to protect your data across AWS services. It integrates seamlessly with CloudTrail for encryption.

- **Customer-Managed Keys**:  
   You can create your own keys to maintain full control over permissions, rotation, and auditing.
- **Encryption and Decryption**:  
   Encrypt sensitive logs stored in S3 using KMS, ensuring compliance and security.
- **Centralized Key Management**:  
   Manage keys across AWS services and applications.
- **Alias Support**:  
   Assign aliases to keys for easy identification and usage.

#### Best Practices for KMS

- Ensure **least privilege access** to keys by carefully configuring IAM policies.
- Regularly rotate keys to enhance security.
- Use CloudTrail logs to audit the use of KMS keys.

## IAM (Identity and Access Management) Users and Roles

AWS IAM is a service that helps you securely control access to AWS resources. It allows you to create and manage users, groups, and roles with finely tuned permissions.

### Types of Users

1. **AWS IAM User**:

   - Users created in IAM with specific credentials (username and password) for accessing the AWS Management Console or programmatically via access keys.
   - Best for individual users requiring access to AWS services.

2. **System Users**:

   - These are service accounts used for applications or services to interact with AWS resources programmatically. They usually have access keys instead of console credentials.

3. **Federated Users**:
   - These users are authenticated via an external identity provider (IdP) like Active Directory, Okta, or Google. AWS supports federation using protocols like SAML 2.0 or OpenID Connect.

### Security Best Practices

- **Enable Multi-Factor Authentication (MFA)**:
  - Always enable MFA for all human users to add an extra layer of security. MFA requires both the password and a one-time token to log in.
- **Follow the Principle of Least Privilege**:

  - Grant users only the permissions they need to perform their tasks. Avoid over-permissioning.

- **Avoid Using the Root Account**:
  - The root account has unrestricted access and should only be used for initial setup or account-level activities (e.g., creating the first IAM user).
  - The root account operates globally and is not tied to any specific AWS region.

### Creating IAM Users

1. Create a user in the IAM console.
2. Decide the type of access:
   - **Console Access**: Assign a username and password.
   - **Programmatic Access**: Generate access keys for API/CLI usage.
3. Add users to groups to manage permissions collectively.
4. Optionally set **permission boundaries** to limit the maximum permissions a user or group can receive.
5. Configure MFA and access keys.
   - Even IAM users with high privileges should use MFA.

### IAM Roles and Policies

IAM roles are temporary identities with specific permissions. Roles can be assumed by trusted entities such as AWS services, users, or applications.

#### Types of IAM Policies

1. **AWS Managed Policies**:
   - Predefined policies created and maintained by AWS, suitable for common use cases (e.g., `AmazonS3FullAccess`).
2. **Customer Managed Policies**:
   - Custom policies you create to meet specific security and business requirements.

#### IAM Roles

Roles allow entities (like EC2 instances, Lambda functions, or other AWS accounts) to perform actions without needing long-term credentials.

- **Key Concepts for IAM Roles**:
  - Roles have **permissions policies** attached, defining what actions are allowed.
  - Roles are temporary and require **assumption** using the `AssumeRole` API.

### Creating IAM Roles

1. **Go to the IAM Roles Console**:
   AWS provides templates for common use cases.

2. **Select a Trusted Entity**:
   Choose who or what can assume the role:

   - **AWS Service**:
     - Allow AWS services like EC2 or Lambda to perform actions in your account.
     - Example: Grant an EC2 instance access to an S3 bucket.
   - **AWS Account**:
     - Allow trusted entities from another AWS account to assume the role.
     - Example: A third-party account managing your resources.
   - **Web Identity**:
     - Federated users from an external identity provider (e.g., Cognito, Google).
     - Example: A mobile app authenticated via Google can access specific AWS resources.
   - **SAML 2.0 Federation**:
     - Federated access using corporate directories like Active Directory.
   - **Custom Trust Policy**:
     - Write a custom policy to define specific trust relationships.

3. **Assign a Use Case**:

   - Select the service or specific use case, such as granting Lambda access to read from DynamoDB.

4. **Attach Policies**:
   - Attach the required permissions to the role.

## Enable AWS Organization SCP

**Service Control Policies (SCPs)** are a powerful feature in AWS Organizations that allow you to enforce guardrails and manage permissions across all accounts in an organization. They do not grant permissions but act as a filter to limit what permissions accounts can use.

### Day 0 Best Practices

On the first day of setting up your AWS Organization, consider implementing the following SCPs to secure your environment:

1. **Deny GuardDuty Changes:**

   - Prevent unauthorized modifications to Amazon GuardDuty configurations. Amazon GuardDuty is a fully managed threat detection service provided by AWS. It continuously monitors your AWS environment for malicious or unauthorized behavior, helping to protect your AWS accounts, workloads, and data stored in Amazon S3.

2. **Deny Security Service Changes:**

   - Restrict changes to AWS security services like AWS Config, AWS Security Hub, or Amazon Inspector.

3. **Prevent Leaving the Organization:**

   - Ensure accounts cannot leave the organization without explicit authorization.

4. **Require MFA for AWS EC2 API Calls:**

   - Enforce Multi-Factor Authentication (MFA) for specific sensitive actions, such as API calls to critical services.

5. **Restrict All Root Access:**

   - Block the use of the root user for operations wherever possible. The root account should only be used for specific tasks, such as account recovery.

6. **Restrict IAM Users:**

   - Limit IAM users' actions and encourage the use of IAM roles with temporary credentials.

7. **Restrict Root Permissions:**
   - Ensure that the root account cannot perform certain high-risk actions without organizational approval.

### Steps to Enable and Apply SCPs

1. **Enable SCPs for Your AWS Organization:**

   - Log in to the AWS Management Console using your management account.
   - Navigate to **AWS Organizations**.
   - Go to **Policies** > **Service Control Policies**.
   - Ensure SCPs are enabled for your organization.

2. **Create SCPs:**

   - Click **Create Policy**.
   - Provide a name and description for your policy.
   - Use JSON to define the policy. Here’s an example:

     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Sid": "DenyRootUser",
           "Effect": "Deny",
           "Action": "*",
           "Resource": "*",
           "Condition": {
             "BoolIfExists": {
               "aws:PrincipalIsAWSService": "false"
             },
             "StringEquals": {
               "aws:PrincipalAccount": "ROOT"
             }
           }
         }
       ]
     }
     ```

   - This SCP denies all actions from the root user.

3. **Attach SCPs to Organizational Units (OUs):**

   - Once the policy is created, attach it to the desired OU or account within the AWS Organization.

4. **Test SCPs:**
   - Test policies in a staging environment or a non-critical account to ensure they behave as expected.

### Key Points to Remember

- **SCPs Do Not Grant Permissions:** They only limit permissions that IAM policies or AWS managed policies would otherwise allow.
- **Hierarchy Matters:** SCPs applied at a higher level in the organization hierarchy affect all child OUs and accounts unless explicitly overridden.
- **Combining Policies:** Permissions are the intersection of SCPs, IAM policies, and resource-based policies.

### Example JSON Policies

Check out [this GitHub repository](https://github.com/hashishrajan/aws-scp-best-practice-policies/tree/main/AWS%20SCP%20Policies) for pre-written SCP JSON policies that cover common security practices. Examples include restricting root account usage, requiring MFA, and denying access to certain services.

### Advanced Tip: AWS CLI and Automation

You can also create and manage SCPs programmatically using the AWS CLI or SDK. For example:

```bash
aws organizations create-policy \
    --content file://deny-root.json \
    --name "DenyRootAccess" \
    --type SERVICE_CONTROL_POLICY
```

This allows you to automate SCP management in CI/CD pipelines.

## Top 5 Security Best Practices

1. Data Protection and Residency in accordance to the Security Policy.
2. Identity and Access management with Least Privilege.
3. Givernance and Compliance of AWS Services being used
   1. Global vs Regional Services
   2. Compliant Services
4. Shared Responsibility of Threat Detection
5. Incident Response Plans to include Cloud
