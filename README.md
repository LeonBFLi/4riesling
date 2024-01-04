Access the page via: http://3.106.218.235:8084/
Current Deployment Workflow for this Repository:

1. A developer commits code changes to this GitHub repository.
2. GitHub Webhook triggers an event.
3. EC2 Jenkins server clones the repository and transfers all files to the EC2 production server.
4. An Ansible playbook is executed to build an Nginx image with the updated code.   (jenkins:/etc/ansible/build_n_deploy_container.yml)
5. Ansible playbook will implment rolling update strategy to deploy the code.

Container info:
- The 4 containers are : nginx-lb, nginx-web1, nginx-web2, nginx-web3, where nginx-web3 appears only when the other 2 web containers are being re-built
- The nginx-lb is a mannually configured loadbalancer server, which takes care of all the inbound traffic.
- The config file 'prod:/opt/disk1/leon/nginx/nginx.conf' is mounted with 'nginx-lb:/etc/nginx/nginx.conf', so when changes are made into it, the actual config file inside the contianer is also updated/
- 'prod:/opt/disk1/leon/nginx/ip_address_updator.sh' is a Shell scripts which are execucted multiple times when the playbook is being called. The purpose for that is to provde correct nginx.conf settings and restart nginx.

Some quick notes from Leon:
- The podman Ansible module seems to be troublesome, and it could introduce priviledge issues from time to time, so plain shell commands are used in the Ansible playbook
- The podman brige network seems uncapable of handing hostname resolution, so the 'ip_address_updator'script is introduced to handle that.
  
Leon
