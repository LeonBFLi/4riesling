Access the page via: [http://3.106.218.235:8084/](http://3.106.218.235:8084/)
Current Deployment Workflow for this Repository:

1. Developers commit code changes to this GitHub repository.
2. A GitHub Webhook triggers an event.
3. The EC2 Jenkins server clones the repository and transfers all files to the EC2 production server~
4. An Ansible playbook is executed to build an Nginx image with the updated code (located at `jenkins:/etc/ansible/build_n_deploy_container.yml`).
5. The Ansible playbook implements a rolling update strategy to deploy the code.

Container info:
- There are currently four containers: nginx-lb, nginx-web1, nginx-web2, nginx-web3 (where nginx-web3 appears only when the other two web containers are being rebuilt).
- The nginx-lb is a manually configured load balancer server responsible for handling all inbound traffic.
- The configuration file `prod:/opt/disk1/leon/nginx/nginx.conf` is mounted with `nginx-lb:/etc/nginx/nginx.conf`. When changes are made to it, the actual configuration file inside the container is also updated.
- `prod:/opt/disk1/leon/nginx/ip_address_updator.sh` is a shell script executed multiple times when the playbook is called. Its purpose is to provide correct nginx.conf settings and restart nginx.

Some quick notes from Leon:
- The Podman Ansible module seems to be troublesome and could introduce privilege issues from time to time. As a workaround, plain shell commands are used in the Ansible playbook.
- The Podman bridge network seems incapable of handling hostname resolution, so the `ip_address_updator` script is introduced to address that issue.

Here is a quick diagram regarding what is happenning behind this repo:

<img width="539" alt="Updated project workflow" src="https://github.com/LeonBFLi/riesling_site/assets/88610487/60db3684-5b6c-4ff0-96bd-b6793ffa57e7">




