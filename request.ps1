 # Auth with google this is the token that will be used to invoke function so it needs to have permissions to do so
$env:GOOGLE_APPLICATION_CREDENTIALS="/Users/benelser/resource-crawler/key.json"

# Example Person POCO
$body = @{
    "FName" = "Ben"
    "LName" = "Elser"
}


$devurl = "http://127.0.0.1:8080"
$r = iwr -Uri $devurl -Method POST -Body ($body | ConvertTo-Json) 
try {
    [System.Text.Encoding]::ASCII.GetString($r.Content)  
}
catch {
    $r.Content
}

# Deployed needs auth headers / this method uses context aware token used with gcloud
$headers = @{
 "Authorization" = "bearer $(gcloud auth print-identity-token)"
}
$deployedurl = "https://us-central1-product1-prod-b3c0.cloudfunctions.net/first-gcp-func"
$r = iwr -Uri $deployedurl -Method POST -Body ($body | ConvertTo-Json) -Headers $headers
try {
    [System.Text.Encoding]::ASCII.GetString($r.Content)  
}
catch {
    $r.Content
}

