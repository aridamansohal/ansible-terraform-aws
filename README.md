## Controller Prerequisites

Install Python dependencies

```bash
pip3 install boto3 botocore
```

Install Ansible collections

```bash
cd ansible
ansible-galaxy collection install -r requirements.yml
```

Verify

```bash
ansible-galaxy collection list
python3 -c "import boto3"
session-manager-plugin --version
```