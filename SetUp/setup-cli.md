# SetUp: AWS-cli

## To create an access key
 - 1. Sign into the AWS Management Console.
 - 2. For single-user or multiple-user accounts:
        - Single-user account –:: In the top right, choose your AWS user name to open the navigation menu. For example, choose webadmin .
        - Multiple-user account –:: Choose IAM from the list of services. From the IAM Dashboard, select Users, and choose the name of the user.
 - 3. Choose Security credentials.
 - 4. Under Access keys, choose Create access key.
 - 5. Choose Command Line Interface (CLI), then choose Next.
 - 6. Choose Create access key.
 - 7. Choose Download .csv file.
---

## Configure aws-cli

```bash
aws configure
# enter the credentials 
```
---

## Verify user identity

```bash
aws sts get-caller-identity
```

---


