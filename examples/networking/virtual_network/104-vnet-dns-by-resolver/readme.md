# VNET with Centraliced DNS Architecture

This example shows how to deploy a VNET with a centralized DNS architecture. The DNS architecture is based on the following article: https://learn.microsoft.com/en-us/azure/dns/private-resolver-architecture

This example require a 2-step deployment:

### Step1 deploy:
  - The Hub VNET
  - The DNS Resolver
  - The Inbound DNS Resolver endpoint  
  
### Step2 deploy:
  - The Spoke VNET
  - Hub and Spoke VNET peering
  - The custom DNS server from the DNS Inbound Resolver endpoint output in step1
