# Ansible and Containers

## Introduction
This presentation covers how to use Ansible to manage and automate container environments, including Docker and Kubernetes. We'll explore various approaches and best practices for container management with Ansible.

## 1. Ansible with Docker

### Key Features
- Container lifecycle management
- Image building and management
- Container networking
- Volume management
- Container orchestration
- Health checks and monitoring

### Basic Example Usage
```yaml
# docker_basic.yml
---
- name: Manage Docker containers
  hosts: all
  become: true
  tasks:
    - name: Install Docker
      apt:
        name: docker.io
        state: present
        update_cache: yes

    - name: Start Docker service
      service:
        name: docker
        state: started
        enabled: yes

    - name: Pull nginx image
      docker_image:
        name: nginx
        source: pull
        force_source: yes

    - name: Run nginx container
      docker_container:
        name: web
        image: nginx
        state: started
        ports:
          - "80:80"
```

### Practice Tasks for Docker

1. **Container Lifecycle Management**
   - Create a playbook that:
     - Builds a custom Docker image
     - Runs multiple containers
     - Manages container networks
     - Handles container volumes

2. **Container Health Monitoring**
   - Implement a monitoring system that:
     - Checks container health
     - Monitors resource usage
     - Handles container restarts
     - Logs container events

3. **Container Networking**
   - Create a network management system that:
     - Sets up container networks
     - Configures network policies
     - Manages container communication
     - Handles network isolation

4. **Container Security**
   - Build a security management system that:
     - Implements container security policies
     - Manages container secrets
     - Handles container access control
     - Monitors security events

5. **Container Backup and Recovery**
   - Develop a backup system that:
     - Backs up container data
     - Manages container snapshots
     - Handles container migration
     - Implements recovery procedures

### Solutions for Docker Practice Tasks

#### 1. Container Lifecycle Management Solution

```yaml
# docker_lifecycle.yml
---
- name: Manage Docker containers lifecycle
  hosts: all
  become: true
  vars:
    app_name: myapp
    app_version: 1.0.0
    container_ports:
      - "8080:80"
      - "443:443"
    volumes:
      - "/data:/app/data"
      - "/config:/app/config"

  tasks:
    - name: Create Docker network
      docker_network:
        name: app_network
        state: present
        driver: bridge

    - name: Build custom Docker image
      docker_image:
        name: "{{ app_name }}:{{ app_version }}"
        source: build
        build:
          context: ./app
          dockerfile: Dockerfile
        force_source: yes

    - name: Create data directory
      file:
        path: /data
        state: directory
        mode: '0755'

    - name: Create config directory
      file:
        path: /config
        state: directory
        mode: '0755'

    - name: Run application container
      docker_container:
        name: "{{ app_name }}"
        image: "{{ app_name }}:{{ app_version }}"
        state: started
        ports: "{{ container_ports }}"
        volumes: "{{ volumes }}"
        networks:
          - name: app_network
        restart_policy: unless-stopped
        healthcheck:
          test: ["CMD", "curl", "-f", "http://localhost:80/health"]
          interval: 30s
          timeout: 10s
          retries: 3
```

#### 2. Container Health Monitoring Solution

```yaml
# docker_monitoring.yml
---
- name: Monitor Docker containers
  hosts: all
  become: true
  vars:
    monitoring_interval: 60
    alert_thresholds:
      cpu: 80
      memory: 85
      disk: 90

  tasks:
    - name: Install monitoring tools
      apt:
        name: 
          - prometheus
          - node-exporter
          - cadvisor
        state: present
        update_cache: yes

    - name: Configure Prometheus
      template:
        src: prometheus.yml.j2
        dest: /etc/prometheus/prometheus.yml
      notify: restart prometheus

    - name: Configure Node Exporter
      template:
        src: node-exporter.service.j2
        dest: /etc/systemd/system/node-exporter.service
      notify: restart node-exporter

    - name: Configure cAdvisor
      template:
        src: cadvisor.service.j2
        dest: /etc/systemd/system/cadvisor.service
      notify: restart cadvisor

    - name: Start monitoring services
      systemd:
        name: "{{ item }}"
        state: started
        enabled: yes
      loop:
        - prometheus
        - node-exporter
        - cadvisor

  handlers:
    - name: restart prometheus
      systemd:
        name: prometheus
        state: restarted

    - name: restart node-exporter
      systemd:
        name: node-exporter
        state: restarted

    - name: restart cadvisor
      systemd:
        name: cadvisor
        state: restarted
```

#### 3. Container Networking Solution

```yaml
# docker_networking.yml
---
- name: Manage Docker networking
  hosts: all
  become: true
  vars:
    networks:
      - name: frontend
        driver: bridge
        options:
          com.docker.network.bridge.name: frontend
      - name: backend
        driver: bridge
        options:
          com.docker.network.bridge.name: backend
      - name: database
        driver: bridge
        options:
          com.docker.network.bridge.name: database

  tasks:
    - name: Create Docker networks
      docker_network:
        name: "{{ item.name }}"
        driver: "{{ item.driver }}"
        options: "{{ item.options }}"
        state: present
      loop: "{{ networks }}"

    - name: Configure network policies
      template:
        src: network-policies.yml.j2
        dest: /etc/docker/network-policies.yml

    - name: Apply network policies
      docker_container:
        name: "{{ item.name }}"
        networks:
          - name: "{{ item.network }}"
        state: started
      loop:
        - name: web
          network: frontend
        - name: app
          network: backend
        - name: db
          network: database
```

#### 4. Container Security Solution

```yaml
# docker_security.yml
---
- name: Implement Docker security
  hosts: all
  become: true
  vars:
    security_policies:
      - name: no_root
        value: true
      - name: read_only
        value: true
      - name: no_new_privileges
        value: true
      - name: capabilities_drop:
        value: ["ALL"]

  tasks:
    - name: Configure Docker daemon security
      template:
        src: daemon.json.j2
        dest: /etc/docker/daemon.json
      notify: restart docker

    - name: Create secrets directory
      file:
        path: /etc/docker/secrets
        state: directory
        mode: '0700'

    - name: Manage Docker secrets
      docker_secret:
        name: "{{ item.name }}"
        data: "{{ item.data }}"
        state: present
      loop:
        - name: db_password
          data: "{{ vault_db_password }}"
        - name: api_key
          data: "{{ vault_api_key }}"

    - name: Apply security policies to containers
      docker_container:
        name: "{{ item.name }}"
        security_opts: "{{ security_policies }}"
        state: started
      loop:
        - name: web
        - name: app
        - name: db

  handlers:
    - name: restart docker
      systemd:
        name: docker
        state: restarted
```

#### 5. Container Backup and Recovery Solution

```yaml
# docker_backup.yml
---
- name: Manage Docker container backups
  hosts: all
  become: true
  vars:
    backup_dir: /backup/docker
    containers:
      - name: web
        volumes:
          - "/data/web:/app/data"
      - name: app
        volumes:
          - "/data/app:/app/data"
      - name: db
        volumes:
          - "/data/db:/var/lib/mysql"

  tasks:
    - name: Create backup directory
      file:
        path: "{{ backup_dir }}"
        state: directory
        mode: '0755'

    - name: Backup container data
      docker_container:
        name: "{{ item.name }}"
        state: started
      loop: "{{ containers }}"
      register: container_status

    - name: Create container snapshots
      command: >
        docker commit {{ item.item.name }} {{ item.item.name }}_snapshot
      loop: "{{ container_status.results }}"
      when: item.state.started

    - name: Backup container volumes
      archive:
        path: "{{ item.volumes | map('regex_replace', '^([^:]+):.*$', '\\1') | list }}"
        dest: "{{ backup_dir }}/{{ item.name }}_volumes.tar.gz"
        format: gz
      loop: "{{ containers }}"

    - name: Backup container configurations
      template:
        src: container-config.yml.j2
        dest: "{{ backup_dir }}/{{ item.name }}_config.yml"
      loop: "{{ containers }}"

    - name: Clean up old snapshots
      command: >
        docker rmi {{ item.item.name }}_snapshot
      loop: "{{ container_status.results }}"
      when: item.state.started
```

## 2. Ansible with Kubernetes

### Key Features
- Cluster management
- Resource deployment
- Service management
- Configuration management
- Secret management
- Scaling operations

### Basic Example Usage
```yaml
# kubernetes_basic.yml
---
- name: Deploy application to Kubernetes
  hosts: localhost
  gather_facts: false
  tasks:
    - name: Create namespace
      kubernetes.core.k8s:
        name: myapp
        api_version: v1
        kind: Namespace
        state: present

    - name: Deploy application
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: myapp
            namespace: myapp
          spec:
            replicas: 3
            selector:
              matchLabels:
                app: myapp
            template:
              metadata:
                labels:
                  app: myapp
              spec:
                containers:
                - name: myapp
                  image: myapp:1.0.0
                  ports:
                  - containerPort: 80
```

### Practice Tasks for Kubernetes

1. **Cluster Management**
   - Create a playbook that:
     - Sets up a Kubernetes cluster
     - Manages node roles
     - Handles cluster upgrades
     - Monitors cluster health

2. **Resource Deployment**
   - Implement a deployment system that:
     - Deploys applications
     - Manages resources
     - Handles rollbacks
     - Monitors deployments

3. **Service Management**
   - Build a service management system that:
     - Creates services
     - Manages load balancing
     - Handles service discovery
     - Monitors service health

4. **Configuration Management**
   - Develop a configuration system that:
     - Manages ConfigMaps
     - Handles secrets
     - Updates configurations
     - Monitors changes

5. **Scaling Operations**
   - Create a scaling system that:
     - Scales resources
     - Manages autoscaling
     - Handles resource limits
     - Monitors scaling events

### Solutions for Kubernetes Practice Tasks

#### 1. Cluster Management Solution

```yaml
# kubernetes_cluster.yml
---
- name: Manage Kubernetes cluster
  hosts: all
  become: true
  vars:
    kubernetes_version: "1.24.0"
    cluster_name: "my-cluster"
    master_nodes:
      - name: master1
        ip: "192.168.1.10"
      - name: master2
        ip: "192.168.1.11"
    worker_nodes:
      - name: worker1
        ip: "192.168.1.20"
      - name: worker2
        ip: "192.168.1.21"

  tasks:
    - name: Install required packages
      apt:
        name:
          - apt-transport-https
          - ca-certificates
          - curl
          - software-properties-common
        state: present
        update_cache: yes

    - name: Add Kubernetes GPG key
      apt_key:
        url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
        state: present

    - name: Add Kubernetes repository
      apt_repository:
        repo: "deb https://apt.kubernetes.io/ kubernetes-xenial main"
        state: present

    - name: Install Kubernetes packages
      apt:
        name:
          - kubelet
          - kubeadm
          - kubectl
        state: present
        version: "{{ kubernetes_version }}"

    - name: Initialize master node
      command: >
        kubeadm init --pod-network-cidr=10.244.0.0/16
      when: inventory_hostname in master_nodes | map(attribute='name') | list

    - name: Join worker nodes to cluster
      command: >
        kubeadm join {{ master_nodes[0].ip }}:6443 --token {{ token }} --discovery-token-ca-cert-hash {{ hash }}
      when: inventory_hostname in worker_nodes | map(attribute='name') | list

    - name: Configure kubectl for admin
      blockinfile:
        path: /root/.kube/config
        create: yes
        block: |
          apiVersion: v1
          kind: Config
          clusters:
          - cluster:
              server: https://{{ master_nodes[0].ip }}:6443
              certificate-authority-data: {{ ca_cert }}
            name: kubernetes
          contexts:
          - context:
              cluster: kubernetes
              user: kubernetes-admin
            name: kubernetes-admin@kubernetes
          current-context: kubernetes-admin@kubernetes
          preferences: {}
          users:
          - name: kubernetes-admin
            user:
              client-certificate-data: {{ client_cert }}
              client-key-data: {{ client_key }}
      when: inventory_hostname == master_nodes[0].name

    - name: Deploy network plugin
      kubernetes.core.k8s:
        state: present
        definition: "{{ lookup('file', 'flannel.yml') }}"
      when: inventory_hostname == master_nodes[0].name
```

#### 2. Resource Deployment Solution

```yaml
# kubernetes_deployment.yml
---
- name: Deploy application to Kubernetes
  hosts: localhost
  gather_facts: false
  vars:
    app_name: myapp
    app_version: 1.0.0
    namespace: production
    replicas: 3
    resources:
      requests:
        cpu: "100m"
        memory: "128Mi"
      limits:
        cpu: "500m"
        memory: "512Mi"

  tasks:
    - name: Create namespace
      kubernetes.core.k8s:
        name: "{{ namespace }}"
        api_version: v1
        kind: Namespace
        state: present

    - name: Deploy application
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: "{{ app_name }}"
            namespace: "{{ namespace }}"
          spec:
            replicas: "{{ replicas }}"
            selector:
              matchLabels:
                app: "{{ app_name }}"
            template:
              metadata:
                labels:
                  app: "{{ app_name }}"
              spec:
                containers:
                - name: "{{ app_name }}"
                  image: "{{ app_name }}:{{ app_version }}"
                  ports:
                  - containerPort: 80
                  resources: "{{ resources }}"
                  readinessProbe:
                    httpGet:
                      path: /health
                      port: 80
                    initialDelaySeconds: 5
                    periodSeconds: 10
                  livenessProbe:
                    httpGet:
                      path: /health
                      port: 80
                    initialDelaySeconds: 15
                    periodSeconds: 20

    - name: Create service
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: v1
          kind: Service
          metadata:
            name: "{{ app_name }}"
            namespace: "{{ namespace }}"
          spec:
            selector:
              app: "{{ app_name }}"
            ports:
            - port: 80
              targetPort: 80
            type: LoadBalancer

    - name: Monitor deployment
      kubernetes.core.k8s_info:
        kind: Deployment
        name: "{{ app_name }}"
        namespace: "{{ namespace }}"
      register: deployment_status
      until: deployment_status.resources[0].status.availableReplicas | int == replicas
      retries: 30
      delay: 10
```

#### 3. Service Management Solution

```yaml
# kubernetes_service.yml
---
- name: Manage Kubernetes services
  hosts: localhost
  gather_facts: false
  vars:
    services:
      - name: web
        port: 80
        target_port: 80
        type: LoadBalancer
      - name: api
        port: 8080
        target_port: 8080
        type: ClusterIP
      - name: db
        port: 3306
        target_port: 3306
        type: ClusterIP

  tasks:
    - name: Create services
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: v1
          kind: Service
          metadata:
            name: "{{ item.name }}"
            namespace: production
          spec:
            selector:
              app: "{{ item.name }}"
            ports:
            - port: "{{ item.port }}"
              targetPort: "{{ item.target_port }}"
            type: "{{ item.type }}"
      loop: "{{ services }}"

    - name: Configure service monitoring
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: monitoring.coreos.com/v1
          kind: ServiceMonitor
          metadata:
            name: "{{ item.name }}"
            namespace: monitoring
          spec:
            selector:
              matchLabels:
                app: "{{ item.name }}"
            endpoints:
            - port: http
              interval: 15s
      loop: "{{ services }}"

    - name: Configure load balancing
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: networking.k8s.io/v1
          kind: Ingress
          metadata:
            name: "{{ item.name }}"
            namespace: production
            annotations:
              kubernetes.io/ingress.class: nginx
              nginx.ingress.kubernetes.io/ssl-redirect: "true"
          spec:
            rules:
            - host: "{{ item.name }}.example.com"
              http:
                paths:
                - path: /
                  pathType: Prefix
                  backend:
                    service:
                      name: "{{ item.name }}"
                      port:
                        number: "{{ item.port }}"
      loop: "{{ services }}"
      when: item.type == "LoadBalancer"
```

#### 4. Configuration Management Solution

```yaml
# kubernetes_config.yml
---
- name: Manage Kubernetes configurations
  hosts: localhost
  gather_facts: false
  vars:
    configs:
      - name: app-config
        data:
          DATABASE_URL: "mysql://user:pass@db:3306/db"
          API_KEY: "{{ vault_api_key }}"
          LOG_LEVEL: "info"
      - name: db-config
        data:
          MYSQL_ROOT_PASSWORD: "{{ vault_db_password }}"
          MYSQL_DATABASE: "myapp"
          MYSQL_USER: "user"
          MYSQL_PASSWORD: "{{ vault_db_user_password }}"

  tasks:
    - name: Create ConfigMaps
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: "{{ item.name }}"
            namespace: production
          data: "{{ item.data }}"
      loop: "{{ configs }}"

    - name: Create secrets
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: v1
          kind: Secret
          metadata:
            name: "{{ item.name }}-secrets"
            namespace: production
          type: Opaque
          data: "{{ item.data | to_json | b64encode }}"
      loop: "{{ configs }}"

    - name: Update deployments with configs
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: "{{ item.name }}"
            namespace: production
          spec:
            template:
              spec:
                containers:
                - name: "{{ item.name }}"
                  envFrom:
                  - configMapRef:
                      name: "{{ item.name }}"
                  - secretRef:
                      name: "{{ item.name }}-secrets"
      loop: "{{ configs }}"
```

#### 5. Scaling Operations Solution

```yaml
# kubernetes_scaling.yml
---
- name: Manage Kubernetes scaling
  hosts: localhost
  gather_facts: false
  vars:
    applications:
      - name: web
        min_replicas: 2
        max_replicas: 10
        target_cpu: 80
      - name: api
        min_replicas: 3
        max_replicas: 15
        target_cpu: 70
      - name: worker
        min_replicas: 1
        max_replicas: 5
        target_cpu: 60

  tasks:
    - name: Configure Horizontal Pod Autoscaling
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: autoscaling/v2
          kind: HorizontalPodAutoscaler
          metadata:
            name: "{{ item.name }}"
            namespace: production
          spec:
            scaleTargetRef:
              apiVersion: apps/v1
              kind: Deployment
              name: "{{ item.name }}"
            minReplicas: "{{ item.min_replicas }}"
            maxReplicas: "{{ item.max_replicas }}"
            metrics:
            - type: Resource
              resource:
                name: cpu
                target:
                  type: Utilization
                  averageUtilization: "{{ item.target_cpu }}"
      loop: "{{ applications }}"

    - name: Configure resource limits
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: "{{ item.name }}"
            namespace: production
          spec:
            template:
              spec:
                containers:
                - name: "{{ item.name }}"
                  resources:
                    requests:
                      cpu: "100m"
                      memory: "128Mi"
                    limits:
                      cpu: "500m"
                      memory: "512Mi"
      loop: "{{ applications }}"

    - name: Configure node autoscaling
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: autoscaling/v1
          kind: ClusterAutoscaler
          metadata:
            name: default
          spec:
            scaleDown:
              enabled: true
              delayAfterAdd: 5m
              delayAfterDelete: 5m
              delayAfterFailure: 5m
              unneededTime: 5m
            scaleUp:
              enabled: true
              delayAfterFailure: 3m
              unneededTime: 3m
```

## Best Practices

1. **Container Management**
   - Use specific version tags for images
   - Implement health checks
   - Use resource limits
   - Implement proper logging

2. **Security**
   - Use non-root users
   - Implement security contexts
   - Use secrets for sensitive data
   - Regular security updates

3. **Performance**
   - Monitor resource usage
   - Implement proper scaling
   - Use caching effectively
   - Optimize image sizes

4. **Maintenance**
   - Regular updates
   - Backup procedures
   - Monitoring and alerting
   - Documentation

## Conclusion

Ansible provides powerful capabilities for managing both Docker and Kubernetes environments. By following best practices and implementing proper security measures, you can create robust and maintainable container infrastructures.

Remember to:
- Always use version control for your playbooks
- Implement proper error handling
- Follow security best practices
- Monitor and maintain your container environments
- Keep documentation up to date 


