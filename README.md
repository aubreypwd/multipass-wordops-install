1. Create a VM

```bash
multipass launch --name wordops --mem 8G --disk 20G --cpus 10
```

1. Open a shell in the new VM

```bash
multipass shell wordops
```

3. Run my install script for installing WordOps

```bash
wget -qO - https://raw.githubusercontent.com/aubreypwd/multipass-wordops-install/main/install.sh | sudo bash
```
