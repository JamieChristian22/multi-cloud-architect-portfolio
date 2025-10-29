# Network Segmentation Explained

- Hub VNet: shared services (Firewall, Bastion, Private DNS, Log Analytics)
- Spoke VNet (prod): web subnet, api subnet, data subnet
- NSGs restrict lateral traffic (web can talk to api; api can talk to data; web cannot talk to data directly)
- Private Endpoints used for data plane access (SQL, Storage)
- No public IPs on DB or Storage
