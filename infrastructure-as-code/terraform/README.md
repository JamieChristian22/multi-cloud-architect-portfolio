# 🧱 Terraform – Multi-Cloud Infrastructure as Code
**AWS | Azure | Google Cloud Platform**

This folder contains **Terraform-based Infrastructure as Code (IaC)** that models the core infrastructure used in the multi-cloud architecture case study.

The purpose of this code is to demonstrate:
- Realistic cloud resource modeling  
- Modular infrastructure thinking  
- Cross-cloud consistency  
- Professional naming conventions  
- Enterprise-style organization  

This is written as portfolio-grade code, structured the way Terraform would be used in real consulting or enterprise environments.

---

## 📌 Objective

Provision infrastructure across three cloud providers using Terraform to support:

- Secure network foundations  
- Storage and data platforms  
- Analytics and ML services  
- Scalable cloud resources  
- Reproducible deployments  
- Environment consistency  

This aligns directly with the architecture documented in `/case-study`.

---

## 📂 Folder Contents

| File | Description |
|------|-------------|
| `providers.tf` | Configures AWS, Azure, and GCP Terraform providers |
| `variables.tf` | Centralized variables for regions, project names, and configuration |
| `aws-network-and-storage.tf` | VPC, subnets, and storage components for AWS |
| `aws-analytics-stack.tf` | Analytics services for AWS (e.g., S3, Athena, Glue, etc.) |
| `azure-network-and-storage.tf` | Azure VNet, storage, and foundational resources |
| `azure-analytics-stack.tf` | Azure analytics components (e.g., Synapse, Data Factory) |
| `gcp-network-and-storage.tf` | VPC, storage, and network services in GCP |
| `gcp-analytics-and-ml.tf` | BigQuery, analytics, and ML services for GCP |

This structure mirrors how **real infrastructure teams separate responsibilities** across layers and platforms.

---

## 🧠 Design Principles Demonstrated

This Terraform structure reflects professional IaC practices:

- Separation of concerns (networking vs analytics)  
- Multi-provider architecture  
- Environment-agnostic configuration  
- Reusability and scalability  
- Clear naming conventions  
- Documentation-first infrastructure  

---

## 🛠️ How This Would Be Used (Real-World Workflow)

In a real environment, this Terraform code would be deployed via:

- CI/CD pipelines (GitHub Actions, GitLab CI, etc.)
- Environment-specific variables (dev/stage/prod)
- Terraform state stored securely (e.g., S3 backend, Azure Storage, GCS)
- Change reviews via pull requests
- Infrastructure drift detection

This portfolio demonstrates architectural understanding of those workflows even if not executed live.

---

## 🔐 Security Considerations

Modeled to support:
- Least privilege access  
- Network isolation  
- Environment separation  
- Secure provider authentication  
- Controlled infrastructure changes  

---

## 📎 Relationship to Architecture

These Terraform files implement the architecture documented in:

📁 `/case-study`  
📄 Architecture diagram:  
`case-study/images/case-study_architecture-diagrams_aws-azure-gcp.png`

This reinforces that this is not random code — it’s **traceable to architectural intent**.

---

## 👨‍💻 Author

**Jamie Christian**  
Multi-Cloud | Data | Architecture  

🔗 LinkedIn: https://www.linkedin.com/in/jamiechristian2  
🔗 GitHub: https://github.com/JamieChristian22  

---





