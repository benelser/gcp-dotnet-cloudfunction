<#
Things to note
- Dependent on 3.1.402 SDK
- Api's need to be enabled before deployment:
    - Cloud Build API
- Disabled project service account and created purpose built SA.
    - This SA get called out on the function deployment
        - This SA determines what permissions the function iteself has during runtime execution
- User/Tool that is deploying function needs to have the SA user for said function
#>

# Deploy function w/ Least priv purpose built SA
gcloud functions deploy first-gcp-func `
--runtime dotnet3 `
--trigger-http `
--entry-point first_gcp_func.Function `
--service-account "svc-first-gcp-func@product1-prod-b3c0.iam.gserviceaccount.com" `
--quiet

# Grant access to function "INVOKERS" 
gcloud functions add-iam-policy-binding first-gcp-func `
  --member=serviceAccount:elserdotnet@product1-prod-b3c0.iam.gserviceaccount.com `
  --role=roles/cloudfunctions.invoker