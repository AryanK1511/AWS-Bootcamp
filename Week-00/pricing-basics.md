# AWS Pricing Basics

## AWS Bill Walkthrough

- **Billing and Cost Management -> Billing and Payments -> Bills**:

  - You can view the **estimated total** for your current charges here. This is a useful section for getting an overview of your AWS usage costs during a specific billing cycle.
  - The breakdown shows costs by service, so you can easily identify which services are driving your charges.
  - You can also view detailed invoices, which include information about the specific charges for each service, as well as any taxes and adjustments.

- **Billing and Cost Management -> Cost and Usage Analytics -> Free Tier**:

  - In this section, you can see your usage for services that are part of the **AWS Free Tier**. AWS provides free usage for certain services up to specific limits, and this section allows you to track whether you're within those limits or have exceeded them.
  - You'll find details about each Free Tier service, including how much of the free usage has been consumed and what is remaining for the current billing period.

- **Billing and Cost Management -> Preferences and Settings -> Billing Preferences**:

  - This area allows you to **configure your invoice delivery preferences**. For example, you can choose whether to receive your invoices by email or to have them available for download in your AWS Management Console.
  - You can also set up **AWS Free Tier alerts** to notify you when you're nearing the limits of the Free Tier, helping you avoid unexpected charges.
  - Additionally, you can configure **CloudWatch billing alerts**. These alerts let you monitor your usage in real-time and receive notifications if your costs or usage exceed specific thresholds.

## Billing Alert

- **CloudWatch -> Alarms -> In Alarm -> Create Alarm**:

  - To set up **billing alarms**, you go to the **CloudWatch console**, select "Alarms," and click on "Create Alarm." This will allow you to define when you'd like to be notified about your billing activities.
  - You choose the **Billing** metric and then select **Total Estimated Charges**. This will trigger an alarm when your estimated charges for the month exceed the threshold you’ve set.
  - Billing alarms are particularly useful for staying on top of costs and preventing unexpected high charges by setting alerts at various cost levels.

- **Creating a Budget**:

  - A **budget** is different from a billing alarm, as it allows you to track your usage and cost across a specific time period (e.g., monthly, quarterly) rather than just monitoring a single metric at a specific moment.
  - **Billing and Cost Management -> Budgets and Planning -> Budgets**: In this section, you can create budgets for both **costs** (tracking your overall expenditure) and **usage** (monitoring your resource consumption).
  - Once a budget is set, you can define thresholds, and AWS will send you **alerts** when your actual usage or costs exceed the budget limits. This is a proactive way to manage your AWS costs and prevent over-spending.

## Cost Explorer

- **Billing and Cost Management -> Cost Explorer**:

  - **Cost Explorer** is a powerful tool that allows you to **visualize and analyze your AWS spending** over time. It can break down your costs by services, linked accounts, or even by specific usage types (e.g., EC2 usage, storage costs).
  - You can apply various **filters** and **groupings** to customize your view of AWS costs, allowing you to see detailed reports, such as costs per service or costs for a specific time range.
  - Cost Explorer also provides **forecasting tools**, which predict your future costs based on historical data. This can help you plan for future budgets and adjust your usage as needed to optimize costs.
  - Using Cost Explorer effectively allows you to identify trends, anomalies, and potential cost-saving opportunities, making it an essential tool for managing your AWS pricing strategy.

## Calculate AWS Estimated Cost for Service

- **AWS Pricing Calculator**: The AWS Pricing Calculator allows you to create an estimate of your AWS costs based on the services you plan to use. You can input details like:

  - The number and type of instances or resources you expect to use (e.g., EC2, S3 storage, RDS).
  - The expected duration of usage (on-demand, reserved, or spot instances).
  - Additional costs related to data transfer, API requests, etc.

- **Billing and Cost Management Console**: For services you are already using, you can view **estimated charges** within the **Billing and Payments** section. This will provide a detailed breakdown of your service costs for the current billing period, including both usage-based and fixed charges.

- **AWS Cost Explorer**: Once you've enabled Cost Explorer, you can view historical usage data, filter by specific services, and project future costs based on current usage patterns. This is especially helpful for understanding how your costs may change if you scale up or down specific services.

## Check AWS Credits (If You Have Any Voucher)

- **Billing and Cost Management -> Billing and Payments -> Credits**:
  - In this section, you can check if you have any **AWS Credits** or **vouchers** applied to your account. AWS credits can be used to offset the cost of AWS services, and they may come from promotional offers, educational programs, or other events.
  - This section will display the amount of available credits and the expiration dates. If you're part of a specific program or have received credits through promotions, you can track how much of those credits have been used and how much is still available.

## Cost Allocation Tags

- **Cost Allocation Tags** allow you to track your AWS costs by specific resource categories, such as department, project, or environment. These tags can be applied to various AWS resources like EC2 instances, S3 buckets, or RDS databases.
  - **Billing and Cost Management -> Cost Allocation Tags**: This section lets you view and manage your tags. You can activate specific tags to be included in your cost and usage reports.
  - Once activated, the tags will appear in the **Cost Explorer** reports, allowing you to filter and group costs based on these tags. This feature is particularly useful for organizations that want to allocate costs to different teams, departments, or projects for better cost tracking and accountability.

## Free Forever vs Free for 12 Months

AWS offers two types of **free services**:

1. **Free Forever**:

   - These services are available at no cost to users, with no expiration date. Examples include certain AWS services like AWS Lambda, Amazon DynamoDB, and Amazon S3 (with limitations such as a small amount of free storage per month).
   - Some AWS services always remain free up to a certain threshold. Once this limit is exceeded, you will start being charged.

2. **Free for 12 Months**:
   - These services are available free of charge for the first 12 months after you sign up for AWS. This includes popular services such as **EC2**, **RDS**, **S3**, and **Elastic Load Balancing**. The Free Tier for these services has limits (e.g., 750 hours of EC2 micro instances per month).
   - After the 12-month period ends, any usage beyond the Free Tier limits will incur charges based on standard AWS pricing.
