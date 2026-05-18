# Using Ansible API

## Introduction
Ansible provides several ways to programmatically interact with its automation engine through APIs. This presentation covers the main approaches to using Ansible's API capabilities.

## 1. Ansible Python API (ansible-runner)
The `ansible-runner` library provides a Python interface to run Ansible playbooks programmatically, offering the most flexible and powerful way to integrate Ansible into your applications.

### Key Features
- Run playbooks directly from Python code
- Capture playbook output and results
- Manage inventory programmatically
- Handle playbook execution and results
- Support for private data directories
- Event-driven execution monitoring
- Async execution capabilities

### Basic Example Usage
```python
import ansible_runner

# Run a playbook
def run_playbook(playbook_path, inventory_path, extra_vars=None):
    r = ansible_runner.run(
        playbook=playbook_path,
        inventory=inventory_path,
        extravars=extra_vars
    )
    return r.status, r.rc, r.events
```

### Advanced Examples

#### 1. Async Playbook Execution
```python
import ansible_runner
import time

def run_async_playbook(playbook_path, inventory_path):
    # Start the playbook execution
    r = ansible_runner.run_async(
        playbook=playbook_path,
        inventory=inventory_path
    )
    
    # Get the job ID
    job_id = r[0]
    
    # Monitor the job status
    while True:
        status = ansible_runner.get_status(job_id)
        if status in ['successful', 'failed', 'error']:
            break
        time.sleep(5)
    
    return status
```

#### 2. Using Private Data Directory
```python
import ansible_runner
import os

def run_with_private_data(playbook_path, inventory_path, private_data_dir):
    # Create private data directory structure
    os.makedirs(private_data_dir, exist_ok=True)
    os.makedirs(os.path.join(private_data_dir, 'project'), exist_ok=True)
    
    # Copy playbook and inventory to private data directory
    # (Implementation depends on your needs)
    
    r = ansible_runner.run(
        playbook=playbook_path,
        inventory=inventory_path,
        private_data_dir=private_data_dir,
        project_dir=os.path.join(private_data_dir, 'project')
    )
    return r.status, r.rc, r.events
```

#### 3. Event-Driven Execution
```python
import ansible_runner
import json

def run_with_event_handler(playbook_path, inventory_path):
    def event_handler(event):
        if event['event'] == 'runner_on_ok':
            print(f"Task completed: {event['event_data']['task']}")
        elif event['event'] == 'runner_on_failed':
            print(f"Task failed: {event['event_data']['task']}")
            print(f"Error: {event['event_data']['res']['msg']}")
    
    r = ansible_runner.run(
        playbook=playbook_path,
        inventory=inventory_path,
        event_handler=event_handler
    )
    return r.status, r.rc, r.events
```

### Practical Solutions

#### 1. Error Handling and Retries
```python
import ansible_runner
import time
from typing import Optional, Tuple

def run_with_retry(
    playbook_path: str,
    inventory_path: str,
    max_retries: int = 3,
    delay: int = 5
) -> Tuple[bool, Optional[dict]]:
    for attempt in range(max_retries):
        try:
            r = ansible_runner.run(
                playbook=playbook_path,
                inventory=inventory_path
            )
            
            if r.status == 'successful':
                return True, r.events
            
            print(f"Attempt {attempt + 1} failed. Retrying in {delay} seconds...")
            time.sleep(delay)
            
        except Exception as e:
            print(f"Error during attempt {attempt + 1}: {str(e)}")
            if attempt < max_retries - 1:
                time.sleep(delay)
    
    return False, None
```

#### 2. Dynamic Inventory Generation
```python
import ansible_runner
import json
import yaml

def run_with_dynamic_inventory(playbook_path: str, hosts: list):
    # Generate dynamic inventory
    inventory = {
        'all': {
            'hosts': {
                host: {} for host in hosts
            }
        }
    }
    
    # Save inventory to temporary file
    inventory_path = 'temp_inventory.yml'
    with open(inventory_path, 'w') as f:
        yaml.dump(inventory, f)
    
    try:
        r = ansible_runner.run(
            playbook=playbook_path,
            inventory=inventory_path
        )
        return r.status, r.rc, r.events
    finally:
        # Clean up temporary inventory file
        os.remove(inventory_path)
```

### Practice Tasks for Ansible Runner

1. **Basic Playbook Execution**
   - Create a simple playbook that installs nginx on a target host
   - Write a Python script using ansible-runner to execute this playbook
   - Add error handling and logging to the script

2. **Async Execution**
   - Modify the nginx installation script to use async execution
   - Implement a progress bar to show the execution status
   - Add timeout handling for long-running tasks

3. **Event-Driven Monitoring**
   - Create a playbook with multiple tasks (e.g., installing packages, configuring services)
   - Implement an event handler that:
     - Logs successful tasks to a file
     - Sends notifications for failed tasks
     - Generates a summary report after completion

4. **Dynamic Inventory**
   - Write a script that:
     - Reads host information from a CSV file
     - Generates a dynamic inventory
     - Executes a playbook against the generated inventory
   - Add support for different host groups based on CSV data

5. **Advanced Error Handling**
   - Implement a retry mechanism for failed playbook executions
   - Add different retry strategies for different types of failures
   - Create a detailed error report with stack traces

### Solutions for Ansible Runner Practice Tasks

#### 1. Basic Playbook Execution Solution

First, create the nginx installation playbook:

```yaml
# install_nginx.yml
---
- name: Install and configure nginx
  hosts: all
  become: true
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start nginx service
      service:
        name: nginx
        state: started
        enabled: yes
```

Then, create the Python script to execute it:

```python
import ansible_runner
import logging
import os
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('ansible_execution.log'),
        logging.StreamHandler()
    ]
)

def run_nginx_installation(inventory_path):
    try:
        # Get the playbook path
        playbook_path = os.path.join(os.path.dirname(__file__), 'install_nginx.yml')
        
        # Run the playbook
        r = ansible_runner.run(
            playbook=playbook_path,
            inventory=inventory_path,
            verbosity=2
        )
        
        # Log the results
        if r.status == 'successful':
            logging.info("Nginx installation completed successfully")
            return True, r.events
        else:
            logging.error(f"Nginx installation failed with status: {r.status}")
            return False, r.events
            
    except Exception as e:
        logging.error(f"Error during playbook execution: {str(e)}")
        return False, None

if __name__ == "__main__":
    inventory_path = "hosts.yml"  # Your inventory file
    success, events = run_nginx_installation(inventory_path)
    if success:
        print("Nginx installation completed successfully")
    else:
        print("Nginx installation failed")
```

#### 2. Async Execution Solution

```python
import ansible_runner
import time
from tqdm import tqdm
import logging
from datetime import datetime, timedelta

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class AsyncPlaybookRunner:
    def __init__(self, timeout_minutes=30):
        self.timeout = timedelta(minutes=timeout_minutes)
        
    def run_with_progress(self, playbook_path, inventory_path):
        start_time = datetime.now()
        
        # Start async execution
        r = ansible_runner.run_async(
            playbook=playbook_path,
            inventory=inventory_path
        )
        
        job_id = r[0]
        
        # Create progress bar
        with tqdm(total=100, desc="Playbook Progress") as pbar:
            while True:
                # Check timeout
                if datetime.now() - start_time > self.timeout:
                    logger.error("Playbook execution timed out")
                    return False, "Timeout"
                
                # Get status
                status = ansible_runner.get_status(job_id)
                
                if status == 'successful':
                    pbar.update(100 - pbar.n)
                    return True, "Success"
                elif status in ['failed', 'error']:
                    return False, status
                
                # Update progress (simplified)
                pbar.update(1)
                time.sleep(1)
                
        return False, "Unknown status"

def main():
    runner = AsyncPlaybookRunner(timeout_minutes=30)
    success, status = runner.run_with_progress(
        playbook_path="install_nginx.yml",
        inventory_path="hosts.yml"
    )
    
    if success:
        logger.info("Playbook executed successfully")
    else:
        logger.error(f"Playbook execution failed: {status}")

if __name__ == "__main__":
    main()
```

#### 3. Event-Driven Monitoring Solution

```python
import ansible_runner
import json
import logging
from datetime import datetime
import smtplib
from email.mime.text import MIMEText

class EventHandler:
    def __init__(self, log_file="ansible_events.log", email_config=None):
        self.log_file = log_file
        self.email_config = email_config
        self.successful_tasks = []
        self.failed_tasks = []
        
    def log_event(self, event):
        timestamp = datetime.now().isoformat()
        with open(self.log_file, 'a') as f:
            f.write(f"{timestamp} - {json.dumps(event)}\n")
            
    def send_notification(self, subject, body):
        if not self.email_config:
            return
            
        msg = MIMEText(body)
        msg['Subject'] = subject
        msg['From'] = self.email_config['from']
        msg['To'] = self.email_config['to']
        
        try:
            with smtplib.SMTP(self.email_config['smtp_server']) as server:
                server.starttls()
                server.login(self.email_config['username'], self.email_config['password'])
                server.send_message(msg)
        except Exception as e:
            logging.error(f"Failed to send email: {str(e)}")
            
    def handle_event(self, event):
        self.log_event(event)
        
        if event['event'] == 'runner_on_ok':
            self.successful_tasks.append(event['event_data']['task'])
        elif event['event'] == 'runner_on_failed':
            self.failed_tasks.append(event['event_data']['task'])
            self.send_notification(
                "Ansible Task Failed",
                f"Task failed: {event['event_data']['task']}\nError: {event['event_data']['res']['msg']}"
            )
            
    def generate_report(self):
        report = {
            'timestamp': datetime.now().isoformat(),
            'successful_tasks': self.successful_tasks,
            'failed_tasks': self.failed_tasks,
            'total_tasks': len(self.successful_tasks) + len(self.failed_tasks),
            'success_rate': len(self.successful_tasks) / (len(self.successful_tasks) + len(self.failed_tasks)) if self.successful_tasks or self.failed_tasks else 0
        }
        
        with open('execution_report.json', 'w') as f:
            json.dump(report, f, indent=2)
            
        return report
            
def run_with_monitoring(playbook_path, inventory_path, email_config=None):
    handler = EventHandler(email_config=email_config)
    
    r = ansible_runner.run(
        playbook=playbook_path,
        inventory=inventory_path,
        event_handler=handler.handle_event
    )
    
    report = handler.generate_report()
    return r.status, r.rc, report

if __name__ == "__main__":
    email_config = {
        'smtp_server': 'smtp.example.com',
        'username': 'your_username',
        'password': 'your_password',
        'from': 'ansible@example.com',
        'to': 'admin@example.com'
    }
    
    status, rc, report = run_with_monitoring(
        playbook_path="install_nginx.yml",
        inventory_path="hosts.yml",
        email_config=email_config
    )
    
    print(f"Execution completed with status: {status}")
    print(f"Success rate: {report['success_rate']*100:.2f}%")
```

#### 4. Dynamic Inventory Solution

```python
import ansible_runner
import csv
import yaml
import os
import tempfile
from typing import Dict, List

class DynamicInventory:
    def __init__(self, csv_file: str):
        self.csv_file = csv_file
        self.inventory: Dict = {
            'all': {
                'hosts': {},
                'children': {}
            }
        }
        
    def read_csv(self) -> List[Dict]:
        hosts = []
        with open(self.csv_file, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                hosts.append(row)
        return hosts
        
    def generate_inventory(self) -> Dict:
        hosts = self.read_csv()
        
        for host in hosts:
            # Add host to all.hosts
            self.inventory['all']['hosts'][host['hostname']] = {
                'ansible_host': host['ip'],
                'ansible_user': host['user'],
                'ansible_ssh_private_key_file': host['ssh_key']
            }
            
            # Add host to appropriate group
            group = host.get('group', 'ungrouped')
            if group not in self.inventory['all']['children']:
                self.inventory['all']['children'][group] = {
                    'hosts': {}
                }
            self.inventory['all']['children'][group]['hosts'][host['hostname']] = {}
            
        return self.inventory
        
    def save_inventory(self, path: str):
        with open(path, 'w') as f:
            yaml.dump(self.inventory, f)
            
def run_with_dynamic_inventory(playbook_path: str, csv_file: str):
    # Create temporary directory for inventory
    with tempfile.TemporaryDirectory() as temp_dir:
        inventory_path = os.path.join(temp_dir, 'inventory.yml')
        
        # Generate and save inventory
        inventory = DynamicInventory(csv_file)
        inventory_data = inventory.generate_inventory()
        inventory.save_inventory(inventory_path)
        
        # Run playbook
        r = ansible_runner.run(
            playbook=playbook_path,
            inventory=inventory_path
        )
        
        return r.status, r.rc, r.events

if __name__ == "__main__":
    # Example CSV file structure:
    # hostname,ip,user,ssh_key,group
    # web1,192.168.1.10,admin,/path/to/key,webservers
    # db1,192.168.1.11,admin,/path/to/key,databases
    
    status, rc, events = run_with_dynamic_inventory(
        playbook_path="install_nginx.yml",
        csv_file="hosts.csv"
    )
    
    print(f"Playbook execution completed with status: {status}")
```

#### 5. Advanced Error Handling Solution

```python
import ansible_runner
import time
import logging
import json
from typing import Optional, Tuple, Dict
from enum import Enum
import traceback

class ErrorType(Enum):
    CONNECTION = "connection"
    PERMISSION = "permission"
    PACKAGE = "package"
    SERVICE = "service"
    UNKNOWN = "unknown"

class RetryStrategy:
    def __init__(self, max_retries: int = 3, delay: int = 5):
        self.max_retries = max_retries
        self.delay = delay
        
    def should_retry(self, error_type: ErrorType) -> bool:
        if error_type == ErrorType.CONNECTION:
            return True
        elif error_type == ErrorType.PERMISSION:
            return False  # Don't retry permission issues
        elif error_type == ErrorType.PACKAGE:
            return True
        elif error_type == ErrorType.SERVICE:
            return True
        return False
        
    def get_delay(self, error_type: ErrorType) -> int:
        if error_type == ErrorType.CONNECTION:
            return self.delay * 2  # Longer delay for connection issues
        return self.delay

class ErrorHandler:
    def __init__(self):
        self.error_log = []
        
    def classify_error(self, error_msg: str) -> ErrorType:
        error_msg = error_msg.lower()
        if "connection refused" in error_msg or "timeout" in error_msg:
            return ErrorType.CONNECTION
        elif "permission denied" in error_msg:
            return ErrorType.PERMISSION
        elif "package" in error_msg or "apt" in error_msg:
            return ErrorType.PACKAGE
        elif "service" in error_msg or "systemd" in error_msg:
            return ErrorType.SERVICE
        return ErrorType.UNKNOWN
        
    def log_error(self, error: Exception, attempt: int):
        error_type = self.classify_error(str(error))
        error_entry = {
            'timestamp': time.time(),
            'attempt': attempt,
            'error_type': error_type.value,
            'error_message': str(error),
            'stack_trace': traceback.format_exc()
        }
        self.error_log.append(error_entry)
        
    def generate_error_report(self) -> Dict:
        return {
            'total_errors': len(self.error_log),
            'errors_by_type': self._count_errors_by_type(),
            'error_details': self.error_log
        }
        
    def _count_errors_by_type(self) -> Dict[str, int]:
        counts = {}
        for error in self.error_log:
            error_type = error['error_type']
            counts[error_type] = counts.get(error_type, 0) + 1
        return counts

def run_with_advanced_error_handling(
    playbook_path: str,
    inventory_path: str,
    max_retries: int = 3,
    delay: int = 5
) -> Tuple[bool, Optional[Dict]]:
    retry_strategy = RetryStrategy(max_retries, delay)
    error_handler = ErrorHandler()
    
    for attempt in range(max_retries):
        try:
            r = ansible_runner.run(
                playbook=playbook_path,
                inventory=inventory_path
            )
            
            if r.status == 'successful':
                return True, r.events
                
            # Handle playbook failure
            error_type = error_handler.classify_error(str(r.events))
            if not retry_strategy.should_retry(error_type):
                error_handler.log_error(Exception(str(r.events)), attempt)
                return False, error_handler.generate_error_report()
                
            print(f"Attempt {attempt + 1} failed. Retrying in {retry_strategy.get_delay(error_type)} seconds...")
            time.sleep(retry_strategy.get_delay(error_type))
            
        except Exception as e:
            error_handler.log_error(e, attempt)
            if not retry_strategy.should_retry(error_handler.classify_error(str(e))):
                return False, error_handler.generate_error_report()
                
            print(f"Error during attempt {attempt + 1}: {str(e)}")
            if attempt < max_retries - 1:
                time.sleep(retry_strategy.get_delay(error_handler.classify_error(str(e))))
    
    return False, error_handler.generate_error_report()

if __name__ == "__main__":
    success, result = run_with_advanced_error_handling(
        playbook_path="install_nginx.yml",
        inventory_path="hosts.yml"
    )
    
    if success:
        print("Playbook executed successfully")
    else:
        print("Playbook execution failed")
        print("Error Report:")
        print(json.dumps(result, indent=2))
```

## 2. Ansible CLI as API
Ansible's command-line interface can be wrapped to create a simple API-like interface.

### Key Features
- Simple to implement
- No additional dependencies
- Direct access to all Ansible features
- Easy integration with existing scripts

### Example Usage
```python
import subprocess

def run_ansible_command(playbook_path, inventory_path, extra_vars=None):
    cmd = ['ansible-playbook', playbook_path, '-i', inventory_path]
    if extra_vars:
        cmd.extend(['-e', json.dumps(extra_vars)])
    
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.returncode, result.stdout, result.stderr
```

### Solutions for CLI API Practice Tasks

#### 1. Basic CLI Integration Solution

```python
import subprocess
import json
import yaml
from typing import Dict, Optional, Tuple
import logging

class AnsiblePlaybookRunner:
    def __init__(self, ansible_path: str = "ansible-playbook"):
        self.ansible_path = ansible_path
        self.logger = logging.getLogger(__name__)
        
    def run(
        self,
        playbook_path: str,
        inventory_path: str,
        extra_vars: Optional[Dict] = None,
        check_mode: bool = False,
        diff_mode: bool = False,
        output_format: str = "json"
    ) -> Tuple[int, str, str]:
        """
        Run an Ansible playbook with various options
        """
        cmd = [self.ansible_path, playbook_path, "-i", inventory_path]
        
        if check_mode:
            cmd.append("--check")
        if diff_mode:
            cmd.append("--diff")
            
        if extra_vars:
            cmd.extend(["-e", json.dumps(extra_vars)])
            
        if output_format == "json":
            cmd.append("--output", "json")
            
        try:
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                check=False
            )
            
            self.logger.info(f"Playbook execution completed with return code: {result.returncode}")
            return result.returncode, result.stdout, result.stderr
            
        except subprocess.CalledProcessError as e:
            self.logger.error(f"Error running playbook: {str(e)}")
            return e.returncode, e.stdout, e.stderr
            
    def validate_playbook(self, playbook_path: str) -> bool:
        """
        Validate playbook syntax
        """
        cmd = [self.ansible_path, "--syntax-check", playbook_path]
        try:
            result = subprocess.run(cmd, capture_output=True, text=True)
            return result.returncode == 0
        except subprocess.CalledProcessError:
            return False
            
    def get_playbook_vars(self, playbook_path: str) -> Dict:
        """
        Extract variables from playbook
        """
        cmd = [self.ansible_path, "--list-vars", playbook_path]
        try:
            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode == 0:
                return yaml.safe_load(result.stdout)
            return {}
        except Exception as e:
            self.logger.error(f"Error getting playbook variables: {str(e)}")
            return {}

def main():
    runner = AnsiblePlaybookRunner()
    
    # Example usage
    playbook_path = "install_nginx.yml"
    inventory_path = "hosts.yml"
    
    # Validate playbook
    if not runner.validate_playbook(playbook_path):
        print("Playbook validation failed")
        return
        
    # Get variables
    vars = runner.get_playbook_vars(playbook_path)
    print(f"Playbook variables: {vars}")
    
    # Run playbook
    rc, stdout, stderr = runner.run(
        playbook_path=playbook_path,
        inventory_path=inventory_path,
        check_mode=True,
        diff_mode=True
    )
    
    if rc == 0:
        print("Playbook executed successfully")
    else:
        print(f"Playbook execution failed: {stderr}")
```

#### 2. Command Execution Solution

```python
import subprocess
import json
from typing import Dict, List, Optional
import logging
from dataclasses import dataclass
from datetime import datetime

@dataclass
class CommandResult:
    host: str
    success: bool
    output: str
    error: Optional[str]
    execution_time: float

class AnsibleAdHocRunner:
    def __init__(self, ansible_path: str = "ansible"):
        self.ansible_path = ansible_path
        self.logger = logging.getLogger(__name__)
        
    def run_command(
        self,
        hosts: List[str],
        command: str,
        become: bool = False,
        module: str = "shell",
        output_format: str = "json"
    ) -> List[CommandResult]:
        """
        Run an ad-hoc command on multiple hosts
        """
        results = []
        
        for host in hosts:
            start_time = datetime.now()
            
            cmd = [
                self.ansible_path,
                host,
                "-m", module,
                "-a", command
            ]
            
            if become:
                cmd.append("-b")
                
            if output_format == "json":
                cmd.append("--output", "json")
                
            try:
                result = subprocess.run(
                    cmd,
                    capture_output=True,
                    text=True,
                    check=False
                )
                
                execution_time = (datetime.now() - start_time).total_seconds()
                
                if result.returncode == 0:
                    results.append(CommandResult(
                        host=host,
                        success=True,
                        output=result.stdout,
                        error=None,
                        execution_time=execution_time
                    ))
                else:
                    results.append(CommandResult(
                        host=host,
                        success=False,
                        output="",
                        error=result.stderr,
                        execution_time=execution_time
                    ))
                    
            except subprocess.CalledProcessError as e:
                results.append(CommandResult(
                    host=host,
                    success=False,
                    output="",
                    error=str(e),
                    execution_time=(datetime.now() - start_time).total_seconds()
                ))
                
        return results
        
    def format_results(self, results: List[CommandResult]) -> str:
        """
        Format command results for display
        """
        output = []
        for result in results:
            output.append(f"\nHost: {result.host}")
            output.append(f"Success: {result.success}")
            output.append(f"Execution Time: {result.execution_time:.2f}s")
            if result.success:
                output.append("Output:")
                output.append(result.output)
            else:
                output.append("Error:")
                output.append(result.error)
        return "\n".join(output)

def main():
    runner = AnsibleAdHocRunner()
    
    # Example usage
    hosts = ["web1", "web2", "db1"]
    command = "df -h"
    
    results = runner.run_command(
        hosts=hosts,
        command=command,
        become=True
    )
    
    print(runner.format_results(results))
```

#### 3. Inventory Management Solution

```python
import yaml
import json
from typing import Dict, List, Optional
import os
import logging
from dataclasses import dataclass

@dataclass
class Host:
    name: str
    ip: str
    groups: List[str]
    vars: Dict

class InventoryManager:
    def __init__(self, inventory_path: str):
        self.inventory_path = inventory_path
        self.logger = logging.getLogger(__name__)
        self.inventory = self._load_inventory()
        
    def _load_inventory(self) -> Dict:
        """
        Load inventory from file
        """
        try:
            with open(self.inventory_path, 'r') as f:
                return yaml.safe_load(f)
        except Exception as e:
            self.logger.error(f"Error loading inventory: {str(e)}")
            return {'all': {'hosts': {}, 'children': {}}}
            
    def _save_inventory(self):
        """
        Save inventory to file
        """
        try:
            with open(self.inventory_path, 'w') as f:
                yaml.dump(self.inventory, f)
        except Exception as e:
            self.logger.error(f"Error saving inventory: {str(e)}")
            
    def add_host(self, host: Host):
        """
        Add a new host to inventory
        """
        # Add to all.hosts
        self.inventory['all']['hosts'][host.name] = {
            'ansible_host': host.ip,
            **host.vars
        }
        
        # Add to groups
        for group in host.groups:
            if group not in self.inventory['all']['children']:
                self.inventory['all']['children'][group] = {'hosts': {}}
            self.inventory['all']['children'][group]['hosts'][host.name] = {}
            
        self._save_inventory()
        
    def remove_host(self, hostname: str):
        """
        Remove a host from inventory
        """
        # Remove from all.hosts
        if hostname in self.inventory['all']['hosts']:
            del self.inventory['all']['hosts'][hostname]
            
        # Remove from groups
        for group in self.inventory['all']['children']:
            if hostname in self.inventory['all']['children'][group]['hosts']:
                del self.inventory['all']['children'][group]['hosts'][hostname]
                
        self._save_inventory()
        
    def add_group(self, groupname: str, parent: Optional[str] = None):
        """
        Add a new group to inventory
        """
        if parent:
            if parent not in self.inventory['all']['children']:
                self.inventory['all']['children'][parent] = {'children': {}}
            self.inventory['all']['children'][parent]['children'][groupname] = {'hosts': {}}
        else:
            self.inventory['all']['children'][groupname] = {'hosts': {}}
            
        self._save_inventory()
        
    def validate_inventory(self) -> bool:
        """
        Validate inventory structure
        """
        try:
            # Check required sections
            if 'all' not in self.inventory:
                return False
            if 'hosts' not in self.inventory['all']:
                return False
            if 'children' not in self.inventory['all']:
                return False
                
            # Validate hosts
            for hostname, host_vars in self.inventory['all']['hosts'].items():
                if not isinstance(host_vars, dict):
                    return False
                    
            # Validate groups
            for groupname, group_data in self.inventory['all']['children'].items():
                if not isinstance(group_data, dict):
                    return False
                if 'hosts' not in group_data:
                    return False
                    
            return True
            
        except Exception as e:
            self.logger.error(f"Error validating inventory: {str(e)}")
            return False

def main():
    # Example usage
    inventory_path = "hosts.yml"
    manager = InventoryManager(inventory_path)
    
    # Add a new host
    new_host = Host(
        name="web3",
        ip="192.168.1.13",
        groups=["webservers", "production"],
        vars={
            "ansible_user": "admin",
            "ansible_ssh_private_key_file": "/path/to/key"
        }
    )
    manager.add_host(new_host)
    
    # Add a new group
    manager.add_group("staging")
    
    # Validate inventory
    if manager.validate_inventory():
        print("Inventory is valid")
    else:
        print("Inventory validation failed")
```

#### 4. Variable Management Solution

```python
import yaml
import json
from typing import Dict, Any, Optional
import logging
from pathlib import Path
import sqlite3
from dataclasses import dataclass

@dataclass
class Variable:
    name: str
    value: Any
    source: str
    priority: int

class VariableManager:
    def __init__(self, db_path: str = "ansible_vars.db"):
        self.db_path = db_path
        self.logger = logging.getLogger(__name__)
        self._init_db()
        
    def _init_db(self):
        """
        Initialize SQLite database
        """
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS variables (
                name TEXT PRIMARY KEY,
                value TEXT,
                source TEXT,
                priority INTEGER
            )
        ''')
        
        conn.commit()
        conn.close()
        
    def add_variable(self, variable: Variable):
        """
        Add a variable to the database
        """
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        try:
            cursor.execute('''
                INSERT OR REPLACE INTO variables (name, value, source, priority)
                VALUES (?, ?, ?, ?)
            ''', (
                variable.name,
                json.dumps(variable.value),
                variable.source,
                variable.priority
            ))
            conn.commit()
        except Exception as e:
            self.logger.error(f"Error adding variable: {str(e)}")
        finally:
            conn.close()
            
    def get_variable(self, name: str) -> Optional[Variable]:
        """
        Get a variable from the database
        """
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        try:
            cursor.execute('''
                SELECT value, source, priority
                FROM variables
                WHERE name = ?
            ''', (name,))
            
            result = cursor.fetchone()
            if result:
                return Variable(
                    name=name,
                    value=json.loads(result[0]),
                    source=result[1],
                    priority=result[2]
                )
            return None
            
        except Exception as e:
            self.logger.error(f"Error getting variable: {str(e)}")
            return None
        finally:
            conn.close()
            
    def load_from_file(self, file_path: str, source: str, priority: int):
        """
        Load variables from a file
        """
        try:
            with open(file_path, 'r') as f:
                if file_path.endswith('.yml') or file_path.endswith('.yaml'):
                    vars_dict = yaml.safe_load(f)
                else:
                    vars_dict = json.load(f)
                    
            for name, value in vars_dict.items():
                self.add_variable(Variable(
                    name=name,
                    value=value,
                    source=source,
                    priority=priority
                ))
                
        except Exception as e:
            self.logger.error(f"Error loading variables from file: {str(e)}")
            
    def generate_vars_file(self, output_path: str):
        """
        Generate a variables file with merged values
        """
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        try:
            cursor.execute('''
                SELECT name, value
                FROM variables
                ORDER BY priority DESC
            ''')
            
            vars_dict = {}
            for name, value in cursor.fetchall():
                vars_dict[name] = json.loads(value)
                
            with open(output_path, 'w') as f:
                yaml.dump(vars_dict, f)
                
        except Exception as e:
            self.logger.error(f"Error generating vars file: {str(e)}")
        finally:
            conn.close()
            
    def validate_variable(self, name: str, value: Any) -> bool:
        """
        Validate a variable value
        """
        # Add your validation rules here
        if isinstance(value, str):
            return len(value) > 0
        elif isinstance(value, (int, float)):
            return True
        elif isinstance(value, dict):
            return all(isinstance(k, str) for k in value.keys())
        elif isinstance(value, list):
            return all(isinstance(x, (str, int, float)) for x in value)
        return False

def main():
    manager = VariableManager()
    
    # Load variables from files
    manager.load_from_file("group_vars/all.yml", "group_vars", 1)
    manager.load_from_file("host_vars/web1.yml", "host_vars", 2)
    
    # Add a variable
    manager.add_variable(Variable(
        name="app_version",
        value="1.0.0",
        source="manual",
        priority=3
    ))
    
    # Get a variable
    var = manager.get_variable("app_version")
    if var:
        print(f"Variable value: {var.value}")
        
    # Generate vars file
    manager.generate_vars_file("merged_vars.yml")
```

#### 5. Output Processing Solution

```python
import json
import yaml
from typing import Dict, List, Optional
import logging
from dataclasses import dataclass
from datetime import datetime
import re

@dataclass
class TaskResult:
    task_name: str
    host: str
    status: str
    duration: float
    error: Optional[str]
    changed: bool

class OutputProcessor:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def parse_playbook_output(self, output: str) -> List[TaskResult]:
        """
        Parse ansible-playbook output
        """
        results = []
        current_task = None
        
        for line in output.split('\n'):
            # Task start
            if line.startswith('TASK ['):
                task_match = re.match(r'TASK \[(.*?)\]', line)
                if task_match:
                    current_task = task_match.group(1)
                    
            # Task result
            elif line.startswith('ok:') or line.startswith('fatal:'):
                host_match = re.match(r'(ok|fatal): \[(.*?)\]', line)
                if host_match and current_task:
                    status = host_match.group(1)
                    host = host_match.group(2)
                    
                    # Extract duration
                    duration_match = re.search(r'in (\d+\.\d+)s', line)
                    duration = float(duration_match.group(1)) if duration_match else 0.0
                    
                    # Extract error if any
                    error = None
                    if status == 'fatal':
                        error_match = re.search(r'msg: (.*?)$', line)
                        if error_match:
                            error = error_match.group(1)
                            
                    # Determine if task changed anything
                    changed = 'changed=' in line and 'changed=1' in line
                    
                    results.append(TaskResult(
                        task_name=current_task,
                        host=host,
                        status=status,
                        duration=duration,
                        error=error,
                        changed=changed
                    ))
                    
        return results
        
    def generate_report(self, results: List[TaskResult], format: str = "json") -> str:
        """
        Generate a report from task results
        """
        report = {
            'timestamp': datetime.now().isoformat(),
            'total_tasks': len(results),
            'successful_tasks': len([r for r in results if r.status == 'ok']),
            'failed_tasks': len([r for r in results if r.status == 'fatal']),
            'changed_tasks': len([r for r in results if r.changed]),
            'total_duration': sum(r.duration for r in results),
            'tasks': [
                {
                    'name': r.task_name,
                    'host': r.host,
                    'status': r.status,
                    'duration': r.duration,
                    'error': r.error,
                    'changed': r.changed
                }
                for r in results
            ]
        }
        
        if format == "json":
            return json.dumps(report, indent=2)
        else:
            return yaml.dump(report)
            
    def analyze_performance(self, results: List[TaskResult]) -> Dict:
        """
        Analyze task performance
        """
        analysis = {
            'slowest_tasks': [],
            'most_failed_tasks': {},
            'host_performance': {}
        }
        
        # Sort tasks by duration
        sorted_tasks = sorted(results, key=lambda x: x.duration, reverse=True)
        analysis['slowest_tasks'] = [
            {
                'task_name': r.task_name,
                'host': r.host,
                'duration': r.duration
            }
            for r in sorted_tasks[:5]
        ]
        
        # Count task failures
        for r in results:
            if r.status == 'fatal':
                if r.task_name not in analysis['most_failed_tasks']:
                    analysis['most_failed_tasks'][r.task_name] = 0
                analysis['most_failed_tasks'][r.task_name] += 1
                
        # Calculate host performance
        for r in results:
            if r.host not in analysis['host_performance']:
                analysis['host_performance'][r.host] = {
                    'total_tasks': 0,
                    'successful_tasks': 0,
                    'failed_tasks': 0,
                    'total_duration': 0.0
                }
                
            host_stats = analysis['host_performance'][r.host]
            host_stats['total_tasks'] += 1
            if r.status == 'ok':
                host_stats['successful_tasks'] += 1
            elif r.status == 'fatal':
                host_stats['failed_tasks'] += 1
            host_stats['total_duration'] += r.duration
            
        return analysis

def main():
    processor = OutputProcessor()
    
    # Example usage
    with open('ansible_output.txt', 'r') as f:
        output = f.read()
        
    results = processor.parse_playbook_output(output)
    
    # Generate report
    report = processor.generate_report(results, format="json")
    print("Execution Report:")
    print(report)
    
    # Analyze performance
    analysis = processor.analyze_performance(results)
    print("\nPerformance Analysis:")
    print(json.dumps(analysis, indent=2))
```

## 3. Ansible Tower/AWX REST API
The most comprehensive way to interact with Ansible programmatically is through the Ansible Tower/AWX REST API.

### Key Features
- Full REST API interface
- Authentication and authorization
- Job scheduling and monitoring
- Inventory management
- Project and template management
- User and team management

### Example Usage
```python
import requests
import json

# Tower API endpoint
TOWER_URL = "https://your-tower-instance/api/v2"
TOKEN = "your-auth-token"

# Headers for authentication
headers = {
    'Authorization': f'Bearer {TOKEN}',
    'Content-Type': 'application/json'
}

# Launch a job template
def launch_job_template(template_id, extra_vars=None):
    url = f"{TOWER_URL}/job_templates/{template_id}/launch/"
    data = {
        "extra_vars": extra_vars or {}
    }
    response = requests.post(url, headers=headers, json=data)
    return response.json()
```

### Practice Tasks for Tower/AWX API

1. **Authentication and Authorization**
   - Implement a secure token management system
   - Create a connection manager class
   - Add support for different authentication methods

2. **Job Template Management**
   - Write a script to:
     - Create and manage job templates
     - Schedule jobs
     - Monitor job execution status

3. **Inventory Management**
   - Create a system to:
     - Manage Tower inventories programmatically
     - Sync inventory with external sources
     - Handle inventory group hierarchies

4. **Project Management**
   - Implement functionality to:
     - Create and update projects
     - Sync with version control systems
     - Manage project permissions

5. **Reporting System**
   - Build a reporting tool that:
     - Collects job execution data
     - Generates performance metrics
     - Creates visual reports

## Best Practices

1. **Error Handling**
   - Always implement proper error handling
   - Check return codes and status messages
   - Log errors appropriately

2. **Security**
   - Use secure authentication methods
   - Never store credentials in code
   - Implement proper access controls

3. **Performance**
   - Use async operations when possible
   - Implement proper timeout handling
   - Cache results when appropriate

4. **Maintenance**
   - Keep dependencies updated
   - Document API usage
   - Implement version control

### Practice Tasks for Best Practices

#### 1. Error Handling Implementation Solution

```python
import logging
import sys
from typing import Optional, Dict, Any
from datetime import datetime
import json
from pathlib import Path

class ErrorHandler:
    def __init__(self, log_dir: str = "logs"):
        self.log_dir = Path(log_dir)
        self.log_dir.mkdir(exist_ok=True)
        
        # Configure logging
        self.logger = logging.getLogger("ansible_api")
        self.logger.setLevel(logging.DEBUG)
        
        # File handler
        log_file = self.log_dir / f"ansible_api_{datetime.now().strftime('%Y%m%d')}.log"
        file_handler = logging.FileHandler(log_file)
        file_handler.setLevel(logging.DEBUG)
        
        # Console handler
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(logging.INFO)
        
        # Formatter
        formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
        file_handler.setFormatter(formatter)
        console_handler.setFormatter(formatter)
        
        self.logger.addHandler(file_handler)
        self.logger.addHandler(console_handler)
        
    def handle_error(self, error: Exception, context: Optional[Dict] = None) -> Dict[str, Any]:
        """
        Handle and log an error
        """
        error_info = {
            'timestamp': datetime.now().isoformat(),
            'error_type': type(error).__name__,
            'error_message': str(error),
            'context': context or {},
            'stack_trace': self._get_stack_trace(error)
        }
        
        # Log error
        self.logger.error(
            f"Error: {error_info['error_message']}",
            extra=error_info
        )
        
        # Save error details
        self._save_error_details(error_info)
        
        return error_info
        
    def _get_stack_trace(self, error: Exception) -> str:
        """
        Get formatted stack trace
        """
        import traceback
        return traceback.format_exc()
        
    def _save_error_details(self, error_info: Dict[str, Any]):
        """
        Save error details to file
        """
        error_file = self.log_dir / f"errors_{datetime.now().strftime('%Y%m%d')}.json"
        
        try:
            if error_file.exists():
                with open(error_file, 'r') as f:
                    errors = json.load(f)
            else:
                errors = []
                
            errors.append(error_info)
            
            with open(error_file, 'w') as f:
                json.dump(errors, f, indent=2)
                
        except Exception as e:
            self.logger.error(f"Error saving error details: {str(e)}")
            
    def recover_from_error(self, error_info: Dict[str, Any]) -> bool:
        """
        Attempt to recover from an error
        """
        try:
            # Implement recovery logic based on error type
            if error_info['error_type'] == 'ConnectionError':
                return self._recover_connection()
            elif error_info['error_type'] == 'TimeoutError':
                return self._recover_timeout()
            else:
                return False
                
        except Exception as e:
            self.logger.error(f"Error during recovery: {str(e)}")
            return False
            
    def _recover_connection(self) -> bool:
        """
        Recover from connection error
        """
        # Implement connection recovery logic
        return True
        
    def _recover_timeout(self) -> bool:
        """
        Recover from timeout error
        """
        # Implement timeout recovery logic
        return True

def main():
    # Example usage
    handler = ErrorHandler()
    
    try:
        # Simulate an error
        raise ConnectionError("Failed to connect to Ansible Tower")
    except Exception as e:
        error_info = handler.handle_error(e, {'operation': 'connect_to_tower'})
        
        if handler.recover_from_error(error_info):
            print("Successfully recovered from error")
        else:
            print("Failed to recover from error")
```

#### 2. Security Implementation Solution

```python
import os
import json
import logging
from typing import Dict, Optional
from datetime import datetime, timedelta
import jwt
from cryptography.fernet import Fernet
from pathlib import Path

class CredentialManager:
    def __init__(self, secret_key: Optional[str] = None):
        self.secret_key = secret_key or Fernet.generate_key()
        self.cipher_suite = Fernet(self.secret_key)
        self.logger = logging.getLogger(__name__)
        
    def encrypt_credentials(self, credentials: Dict) -> str:
        """
        Encrypt credentials
        """
        try:
            json_data = json.dumps(credentials)
            encrypted_data = self.cipher_suite.encrypt(json_data.encode())
            return encrypted_data.decode()
        except Exception as e:
            self.logger.error(f"Error encrypting credentials: {str(e)}")
            raise
            
    def decrypt_credentials(self, encrypted_data: str) -> Dict:
        """
        Decrypt credentials
        """
        try:
            decrypted_data = self.cipher_suite.decrypt(encrypted_data.encode())
            return json.loads(decrypted_data.decode())
        except Exception as e:
            self.logger.error(f"Error decrypting credentials: {str(e)}")
            raise

class TokenManager:
    def __init__(self, secret_key: str):
        self.secret_key = secret_key
        self.logger = logging.getLogger(__name__)
        
    def generate_token(self, user_id: str, roles: list) -> str:
        """
        Generate JWT token
        """
        try:
            payload = {
                'user_id': user_id,
                'roles': roles,
                'exp': datetime.utcnow() + timedelta(hours=24)
            }
            return jwt.encode(payload, self.secret_key, algorithm='HS256')
        except Exception as e:
            self.logger.error(f"Error generating token: {str(e)}")
            raise
            
    def validate_token(self, token: str) -> Optional[Dict]:
        """
        Validate JWT token
        """
        try:
            return jwt.decode(token, self.secret_key, algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            self.logger.warning("Token has expired")
            return None
        except jwt.InvalidTokenError:
            self.logger.warning("Invalid token")
            return None
        except Exception as e:
            self.logger.error(f"Error validating token: {str(e)}")
            return None

class AccessControl:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.roles = {}
        self.permissions = {}
        
    def add_role(self, role: str, permissions: list):
        """
        Add a role with permissions
        """
        self.roles[role] = permissions
        
    def check_permission(self, role: str, permission: str) -> bool:
        """
        Check if role has permission
        """
        return permission in self.roles.get(role, [])
        
    def audit_log(self, user_id: str, action: str, resource: str, status: str):
        """
        Log access attempts
        """
        log_entry = {
            'timestamp': datetime.now().isoformat(),
            'user_id': user_id,
            'action': action,
            'resource': resource,
            'status': status
        }
        
        self.logger.info(f"Access attempt: {json.dumps(log_entry)}")
        
        # Save to audit log file
        audit_file = Path("logs/audit.log")
        audit_file.parent.mkdir(exist_ok=True)
        
        with open(audit_file, 'a') as f:
            f.write(json.dumps(log_entry) + '\n')

def main():
    # Example usage
    
    # Initialize managers
    credential_manager = CredentialManager()
    token_manager = TokenManager("your-secret-key")
    access_control = AccessControl()
    
    # Set up roles and permissions
    access_control.add_role("admin", ["read", "write", "execute"])
    access_control.add_role("user", ["read"])
    
    # Encrypt credentials
    credentials = {
        "username": "admin",
        "password": "secret-password"
    }
    encrypted = credential_manager.encrypt_credentials(credentials)
    
    # Generate token
    token = token_manager.generate_token("user1", ["user"])
    
    # Validate token
    payload = token_manager.validate_token(token)
    if payload:
        user_id = payload['user_id']
        roles = payload['roles']
        
        # Check permissions
        if access_control.check_permission(roles[0], "read"):
            access_control.audit_log(user_id, "read", "inventory", "success")
            print("Access granted")
        else:
            access_control.audit_log(user_id, "read", "inventory", "denied")
            print("Access denied")
```

#### 3. Performance Optimization Solution

```python
import time
import logging
from typing import Dict, Any, Optional
from functools import wraps
import threading
from concurrent.futures import ThreadPoolExecutor
import redis
import json

class PerformanceMonitor:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.metrics = {}
        self.lock = threading.Lock()
        
    def measure_time(self, func):
        """
        Decorator to measure function execution time
        """
        @wraps(func)
        def wrapper(*args, **kwargs):
            start_time = time.time()
            result = func(*args, **kwargs)
            end_time = time.time()
            
            duration = end_time - start_time
            self.record_metric(func.__name__, duration)
            
            return result
        return wrapper
        
    def record_metric(self, name: str, value: float):
        """
        Record a performance metric
        """
        with self.lock:
            if name not in self.metrics:
                self.metrics[name] = []
            self.metrics[name].append(value)
            
    def get_statistics(self) -> Dict[str, Dict[str, float]]:
        """
        Calculate statistics for all metrics
        """
        stats = {}
        with self.lock:
            for name, values in self.metrics.items():
                if values:
                    stats[name] = {
                        'min': min(values),
                        'max': max(values),
                        'avg': sum(values) / len(values),
                        'count': len(values)
                    }
        return stats

class CacheManager:
    def __init__(self, redis_url: str = "redis://localhost:6379/0"):
        self.redis = redis.from_url(redis_url)
        self.logger = logging.getLogger(__name__)
        
    def get(self, key: str) -> Optional[Any]:
        """
        Get value from cache
        """
        try:
            data = self.redis.get(key)
            return json.loads(data) if data else None
        except Exception as e:
            self.logger.error(f"Error getting from cache: {str(e)}")
            return None
            
    def set(self, key: str, value: Any, expire: int = 3600):
        """
        Set value in cache
        """
        try:
            self.redis.setex(
                key,
                expire,
                json.dumps(value)
            )
        except Exception as e:
            self.logger.error(f"Error setting cache: {str(e)}")
            
    def delete(self, key: str):
        """
        Delete value from cache
        """
        try:
            self.redis.delete(key)
        except Exception as e:
            self.logger.error(f"Error deleting from cache: {str(e)}")

class AsyncExecutor:
    def __init__(self, max_workers: int = 4):
        self.executor = ThreadPoolExecutor(max_workers=max_workers)
        self.logger = logging.getLogger(__name__)
        
    def execute(self, func, *args, **kwargs):
        """
        Execute function asynchronously
        """
        try:
            future = self.executor.submit(func, *args, **kwargs)
            return future
        except Exception as e:
            self.logger.error(f"Error executing async task: {str(e)}")
            raise
            
    def shutdown(self):
        """
        Shutdown the executor
        """
        self.executor.shutdown()

def main():
    # Example usage
    
    # Initialize managers
    monitor = PerformanceMonitor()
    cache = CacheManager()
    executor = AsyncExecutor()
    
    @monitor.measure_time
    def expensive_operation():
        time.sleep(2)  # Simulate expensive operation
        return "result"
        
    # Use cache
    def get_data(key: str):
        # Try cache first
        cached_data = cache.get(key)
        if cached_data:
            return cached_data
            
        # If not in cache, perform expensive operation
        result = expensive_operation()
        cache.set(key, result)
        return result
        
    # Execute async
    future = executor.execute(get_data, "my_key")
    result = future.result()
    
    # Get performance statistics
    stats = monitor.get_statistics()
    print("Performance Statistics:")
    print(json.dumps(stats, indent=2))
    
    # Cleanup
    executor.shutdown()
```

#### 4. Maintenance Tools Solution

```python
import pkg_resources
import logging
from typing import Dict, List, Optional
import subprocess
import json
from pathlib import Path
import git
from datetime import datetime

class DependencyManager:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def get_installed_packages(self) -> Dict[str, str]:
        """
        Get installed package versions
        """
        return {pkg.key: pkg.version for pkg in pkg_resources.working_set}
        
    def check_updates(self) -> List[Dict[str, str]]:
        """
        Check for package updates
        """
        updates = []
        for pkg in pkg_resources.working_set:
            try:
                latest = pkg_resources.get_distribution(pkg.key).version
                if latest != pkg.version:
                    updates.append({
                        'package': pkg.key,
                        'current': pkg.version,
                        'latest': latest
                    })
            except Exception as e:
                self.logger.error(f"Error checking updates for {pkg.key}: {str(e)}")
        return updates
        
    def update_package(self, package: str) -> bool:
        """
        Update a package
        """
        try:
            subprocess.run(
                [sys.executable, "-m", "pip", "install", "--upgrade", package],
                check=True
            )
            return True
        except subprocess.CalledProcessError as e:
            self.logger.error(f"Error updating package {package}: {str(e)}")
            return False

class VersionControl:
    def __init__(self, repo_path: str):
        self.repo_path = Path(repo_path)
        self.logger = logging.getLogger(__name__)
        
    def init_repo(self) -> bool:
        """
        Initialize git repository
        """
        try:
            if not self.repo_path.exists():
                self.repo_path.mkdir(parents=True)
                
            repo = git.Repo.init(self.repo_path)
            return True
        except Exception as e:
            self.logger.error(f"Error initializing repository: {str(e)}")
            return False
            
    def add_file(self, file_path: str, message: str) -> bool:
        """
        Add and commit a file
        """
        try:
            repo = git.Repo(self.repo_path)
            repo.index.add([file_path])
            repo.index.commit(message)
            return True
        except Exception as e:
            self.logger.error(f"Error adding file: {str(e)}")
            return False
            
    def create_branch(self, branch_name: str) -> bool:
        """
        Create a new branch
        """
        try:
            repo = git.Repo(self.repo_path)
            repo.create_head(branch_name)
            return True
        except Exception as e:
            self.logger.error(f"Error creating branch: {str(e)}")
            return False

class DocumentationGenerator:
    def __init__(self, output_dir: str):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        self.logger = logging.getLogger(__name__)
        
    def generate_api_docs(self, api_info: Dict):
        """
        Generate API documentation
        """
        try:
            # Generate HTML documentation
            html_content = f"""
            <html>
            <head>
                <title>API Documentation</title>
                <style>
                    body {{ font-family: Arial, sans-serif; margin: 20px; }}
                    .endpoint {{ margin: 20px; padding: 20px; border: 1px solid #ccc; }}
                    .method {{ font-weight: bold; color: #0066cc; }}
                </style>
            </head>
            <body>
                <h1>API Documentation</h1>
                <p>Generated on: {datetime.now().isoformat()}</p>
                {self._generate_endpoint_docs(api_info)}
            </body>
            </html>
            """
            
            with open(self.output_dir / "api_docs.html", 'w') as f:
                f.write(html_content)
                
        except Exception as e:
            self.logger.error(f"Error generating API docs: {str(e)}")
            
    def _generate_endpoint_docs(self, api_info: Dict) -> str:
        """
        Generate endpoint documentation
        """
        docs = []
        for endpoint, info in api_info.items():
            docs.append(f"""
            <div class="endpoint">
                <h2>{endpoint}</h2>
                <p class="method">{info['method']}</p>
                <p>{info['description']}</p>
                <h3>Parameters:</h3>
                <ul>
                    {self._generate_parameter_docs(info.get('parameters', []))}
                </ul>
                <h3>Response:</h3>
                <pre>{json.dumps(info.get('response', {}), indent=2)}</pre>
            </div>
            """)
        return "\n".join(docs)
        
    def _generate_parameter_docs(self, parameters: List[Dict]) -> str:
        """
        Generate parameter documentation
        """
        return "\n".join(
            f"<li>{param['name']}: {param['type']} - {param['description']}"
            for param in parameters
        )

def main():
    # Example usage
    
    # Initialize managers
    dep_manager = DependencyManager()
    vc = VersionControl("ansible_api")
    doc_gen = DocumentationGenerator("docs")
    
    # Check for updates
    updates = dep_manager.check_updates()
    if updates:
        print("Available updates:")
        print(json.dumps(updates, indent=2))
        
        # Update packages
        for update in updates:
            if dep_manager.update_package(update['package']):
                print(f"Updated {update['package']}")
                
    # Version control operations
    if vc.init_repo():
        vc.add_file("main.py", "Initial commit")
        vc.create_branch("feature/new-feature")
        
    # Generate documentation
    api_info = {
        "/api/v1/jobs": {
            "method": "GET",
            "description": "List all jobs",
            "parameters": [
                {
                    "name": "status",
                    "type": "string",
                    "description": "Filter by status"
                }
            ],
            "response": {
                "jobs": [
                    {
                        "id": 1,
                        "status": "successful"
                    }
                ]
            }
        }
    }
    
    doc_gen.generate_api_docs(api_info)
```

### Solutions for Common Use Cases Practice Tasks

#### 1. CI/CD Integration Solution

```python
import subprocess
import logging
from typing import Dict, Optional
import json
from pathlib import Path
import time

class CICDPipeline:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def run_tests(self) -> bool:
        """
        Run automated tests
        """
        try:
            # Run pytest
            result = subprocess.run(
                ["pytest", "-v"],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info("Tests passed successfully")
                return True
            else:
                self.logger.error(f"Tests failed: {result.stderr}")
                return False
                
        except Exception as e:
            self.logger.error(f"Error running tests: {str(e)}")
            return False
            
    def deploy(self, environment: str) -> bool:
        """
        Deploy to specified environment
        """
        try:
            # Run Ansible playbook
            result = subprocess.run(
                [
                    "ansible-playbook",
                    f"deploy_{environment}.yml",
                    "-i", f"inventory_{environment}"
                ],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info(f"Deployment to {environment} successful")
                return True
            else:
                self.logger.error(f"Deployment failed: {result.stderr}")
                return False
                
        except Exception as e:
            self.logger.error(f"Error during deployment: {str(e)}")
            return False
            
    def rollback(self, environment: str) -> bool:
        """
        Rollback deployment
        """
        try:
            # Run rollback playbook
            result = subprocess.run(
                [
                    "ansible-playbook",
                    f"rollback_{environment}.yml",
                    "-i", f"inventory_{environment}"
                ],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info(f"Rollback successful")
                return True
            else:
                self.logger.error(f"Rollback failed: {result.stderr}")
                return False
                
        except Exception as e:
            self.logger.error(f"Error during rollback: {str(e)}")
            return False

class DeploymentManager:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.deployment_history = []
        
    def deploy_with_rollback(self, environment: str) -> bool:
        """
        Deploy with automatic rollback on failure
        """
        pipeline = CICDPipeline()
        
        # Run tests
        if not pipeline.run_tests():
            self.logger.error("Tests failed, aborting deployment")
            return False
            
        # Record deployment start
        deployment = {
            'environment': environment,
            'start_time': time.time(),
            'status': 'in_progress'
        }
        self.deployment_history.append(deployment)
        
        # Attempt deployment
        if pipeline.deploy(environment):
            deployment['status'] = 'successful'
            deployment['end_time'] = time.time()
            return True
        else:
            # Rollback on failure
            self.logger.info("Deployment failed, initiating rollback")
            if pipeline.rollback(environment):
                deployment['status'] = 'rolled_back'
                deployment['end_time'] = time.time()
                return False
            else:
                deployment['status'] = 'rollback_failed'
                deployment['end_time'] = time.time()
                return False
                
    def get_deployment_history(self) -> List[Dict]:
        """
        Get deployment history
        """
        return self.deployment_history

def main():
    # Example usage
    manager = DeploymentManager()
    
    # Deploy to staging
    success = manager.deploy_with_rollback("staging")
    if success:
        print("Deployment successful")
    else:
        print("Deployment failed")
        
    # Print deployment history
    print("\nDeployment History:")
    print(json.dumps(manager.get_deployment_history(), indent=2))
```

#### 2. Monitoring System Solution

```python
import psutil
import logging
from typing import Dict, List, Optional
import json
from datetime import datetime
import requests
from dataclasses import dataclass

@dataclass
class SystemMetric:
    name: str
    value: float
    unit: str
    timestamp: str

class SystemMonitor:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def collect_metrics(self) -> List[SystemMetric]:
        """
        Collect system metrics
        """
        metrics = []
        
        # CPU metrics
        cpu_percent = psutil.cpu_percent(interval=1)
        metrics.append(SystemMetric(
            name="cpu_usage",
            value=cpu_percent,
            unit="percent",
            timestamp=datetime.now().isoformat()
        ))
        
        # Memory metrics
        memory = psutil.virtual_memory()
        metrics.append(SystemMetric(
            name="memory_usage",
            value=memory.percent,
            unit="percent",
            timestamp=datetime.now().isoformat()
        ))
        
        # Disk metrics
        disk = psutil.disk_usage('/')
        metrics.append(SystemMetric(
            name="disk_usage",
            value=disk.percent,
            unit="percent",
            timestamp=datetime.now().isoformat()
        ))
        
        return metrics
        
    def check_thresholds(self, metrics: List[SystemMetric]) -> List[Dict]:
        """
        Check metrics against thresholds
        """
        alerts = []
        thresholds = {
            "cpu_usage": 80,
            "memory_usage": 85,
            "disk_usage": 90
        }
        
        for metric in metrics:
            if metric.name in thresholds:
                if metric.value > thresholds[metric.name]:
                    alerts.append({
                        'metric': metric.name,
                        'value': metric.value,
                        'threshold': thresholds[metric.name],
                        'timestamp': metric.timestamp
                    })
                    
        return alerts

class AlertManager:
    def __init__(self, webhook_url: Optional[str] = None):
        self.webhook_url = webhook_url
        self.logger = logging.getLogger(__name__)
        
    def send_alert(self, alert: Dict):
        """
        Send alert notification
        """
        if self.webhook_url:
            try:
                response = requests.post(
                    self.webhook_url,
                    json=alert
                )
                response.raise_for_status()
            except Exception as e:
                self.logger.error(f"Error sending alert: {str(e)}")
                
        # Log alert
        self.logger.warning(
            f"Alert: {alert['metric']} exceeded threshold "
            f"({alert['value']} > {alert['threshold']})"
        )

class DashboardGenerator:
    def __init__(self, output_dir: str):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        self.logger = logging.getLogger(__name__)
        
    def generate_dashboard(self, metrics: List[SystemMetric]):
        """
        Generate monitoring dashboard
        """
        try:
            # Create HTML dashboard
            html_content = f"""
            <html>
            <head>
                <title>System Monitoring Dashboard</title>
                <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                <style>
                    body {{ font-family: Arial, sans-serif; margin: 20px; }}
                    .metric {{ margin: 20px; padding: 20px; border: 1px solid #ccc; }}
                </style>
            </head>
            <body>
                <h1>System Monitoring Dashboard</h1>
                <p>Generated on: {datetime.now().isoformat()}</p>
                {self._generate_metric_charts(metrics)}
            </body>
            </html>
            """
            
            with open(self.output_dir / "dashboard.html", 'w') as f:
                f.write(html_content)
                
        except Exception as e:
            self.logger.error(f"Error generating dashboard: {str(e)}")
            
    def _generate_metric_charts(self, metrics: List[SystemMetric]) -> str:
        """
        Generate metric charts
        """
        charts = []
        for metric in metrics:
            charts.append(f"""
            <div class="metric">
                <h2>{metric.name}</h2>
                <div id="chart_{metric.name}"></div>
                <script>
                    var data = [{{
                        y: [{metric.value}],
                        type: 'bar'
                    }}];
                    var layout = {{
                        title: '{metric.name}',
                        yaxis: {{
                            title: '{metric.unit}'
                        }}
                    }};
                    Plotly.newPlot('chart_{metric.name}', data, layout);
                </script>
            </div>
            """)
        return "\n".join(charts)

def main():
    # Example usage
    
    # Initialize components
    monitor = SystemMonitor()
    alert_manager = AlertManager("https://your-webhook-url")
    dashboard = DashboardGenerator("dashboard")
    
    # Collect metrics
    metrics = monitor.collect_metrics()
    
    # Check for alerts
    alerts = monitor.check_thresholds(metrics)
    for alert in alerts:
        alert_manager.send_alert(alert)
        
    # Generate dashboard
    dashboard.generate_dashboard(metrics)
```

#### 3. Resource Management Solution

```python
import boto3
import logging
from typing import Dict, List, Optional
import json
from datetime import datetime
import time

class CloudResourceManager:
    def __init__(self, region: str = "us-west-2"):
        self.region = region
        self.logger = logging.getLogger(__name__)
        self.ec2 = boto3.client('ec2', region_name=region)
        
    def provision_instance(self, instance_config: Dict) -> Optional[str]:
        """
        Provision EC2 instance
        """
        try:
            response = self.ec2.run_instances(
                ImageId=instance_config['image_id'],
                InstanceType=instance_config['instance_type'],
                KeyName=instance_config['key_name'],
                MinCount=1,
                MaxCount=1,
                TagSpecifications=[
                    {
                        'ResourceType': 'instance',
                        'Tags': [
                            {'Key': 'Name', 'Value': instance_config['name']},
                            {'Key': 'Environment', 'Value': instance_config['environment']}
                        ]
                    }
                ]
            )
            
            instance_id = response['Instances'][0]['InstanceId']
            self.logger.info(f"Provisioned instance: {instance_id}")
            return instance_id
            
        except Exception as e:
            self.logger.error(f"Error provisioning instance: {str(e)}")
            return None
            
    def terminate_instance(self, instance_id: str) -> bool:
        """
        Terminate EC2 instance
        """
        try:
            self.ec2.terminate_instances(InstanceIds=[instance_id])
            self.logger.info(f"Terminated instance: {instance_id}")
            return True
        except Exception as e:
            self.logger.error(f"Error terminating instance: {str(e)}")
            return False
            
    def get_instance_status(self, instance_id: str) -> Optional[str]:
        """
        Get instance status
        """
        try:
            response = self.ec2.describe_instances(InstanceIds=[instance_id])
            return response['Reservations'][0]['Instances'][0]['State']['Name']
        except Exception as e:
            self.logger.error(f"Error getting instance status: {str(e)}")
            return None

class ConfigurationManager:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def apply_configuration(self, host: str, config: Dict) -> bool:
        """
        Apply configuration to host
        """
        try:
            # Run Ansible playbook
            result = subprocess.run(
                [
                    "ansible-playbook",
                    "configure.yml",
                    "-i", f"{host},",
                    "-e", json.dumps(config)
                ],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info(f"Configuration applied to {host}")
                return True
            else:
                self.logger.error(f"Configuration failed: {result.stderr}")
                return False
                
        except Exception as e:
            self.logger.error(f"Error applying configuration: {str(e)}")
            return False

class ScalingManager:
    def __init__(self, cloud_manager: CloudResourceManager, config_manager: ConfigurationManager):
        self.cloud_manager = cloud_manager
        self.config_manager = config_manager
        self.logger = logging.getLogger(__name__)
        
    def scale_up(self, count: int, instance_config: Dict) -> List[str]:
        """
        Scale up resources
        """
        instance_ids = []
        for _ in range(count):
            instance_id = self.cloud_manager.provision_instance(instance_config)
            if instance_id:
                instance_ids.append(instance_id)
                
                # Wait for instance to be running
                while self.cloud_manager.get_instance_status(instance_id) != 'running':
                    time.sleep(10)
                    
                # Apply configuration
                self.config_manager.apply_configuration(
                    instance_config['public_ip'],
                    instance_config['config']
                )
                
        return instance_ids
        
    def scale_down(self, instance_ids: List[str]) -> bool:
        """
        Scale down resources
        """
        success = True
        for instance_id in instance_ids:
            if not self.cloud_manager.terminate_instance(instance_id):
                success = False
        return success

def main():
    # Example usage
    
    # Initialize managers
    cloud_manager = CloudResourceManager()
    config_manager = ConfigurationManager()
    scaling_manager = ScalingManager(cloud_manager, config_manager)
    
    # Instance configuration
    instance_config = {
        'image_id': 'ami-0c55b159cbfafe1f0',
        'instance_type': 't2.micro',
        'key_name': 'my-key',
        'name': 'web-server',
        'environment': 'production',
        'config': {
            'nginx_port': 80,
            'app_version': '1.0.0'
        }
    }
    
    # Scale up
    instance_ids = scaling_manager.scale_up(2, instance_config)
    print(f"Scaled up instances: {instance_ids}")
    
    # Scale down
    if scaling_manager.scale_down(instance_ids):
        print("Successfully scaled down")
    else:
        print("Error scaling down")
```

## Conclusion

The Ansible API provides powerful ways to integrate Ansible automation into your applications and workflows. Choose the appropriate API based on your specific needs:

- Use ansible-runner for direct playbook execution and maximum flexibility
- Use CLI wrapping for simple integration
- Use Tower/AWX API for enterprise features and management

Remember to follow best practices and implement proper error handling and security measures in your implementations.
