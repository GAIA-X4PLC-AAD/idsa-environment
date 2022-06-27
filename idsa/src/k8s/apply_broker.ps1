Set-Location $PSScriptRoot

kubectl apply -f storage-class/azure
kubectl apply -f broker