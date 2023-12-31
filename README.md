Current Deployment Workflow for this Repository:

1. A developer commits code changes to this GitHub repository.
2. GitHub Webhook triggers an event.
3. EC2 Jenkins server clones the repository and transfers all files to the EC2 production server.
4. An Ansible playbook is executed to build an Nginx image with the updated code.
5. Ansible removes the previous Nginx container and creates a new one.

Leon
