# Example Terraform Project

This project compares the three cloud hyperscalers.

For comparison, the same configuration was used:

- a managed kubernetes cluster with 3 nodes (2vCPU and 8GB memory) that are allowed to crash (preemptible, spot instances)
- a managed postgres database with 2vCPU and 8GB memory

## Get a price breakdown

```bash
infracost breakdown --path .
```

```
┏━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project  ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ aws      ┃          $329 ┃           - ┃       $329 ┃
┃ azure    ┃          $918 ┃           - ┃       $918 ┃
┃ google   ┃          $410 ┃           - ┃       $410 ┃
┗━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛

```