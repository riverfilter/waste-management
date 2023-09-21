# waste-management

### base image recipe for on-prem kubernetes nodes built on ubuntu server 2004. intended purpose is to build a ubuntu 2004 vm, run the cookbook and create snapshots to use as control plane or worker nodes. 

### only meant to be used as a lab or development environment

### Usage: cookbook not even tested as a script but probably would work, more so meant to be a list to follow. playbook doesn't really need to be ran but as deps or tasks are added they should be added to the playbook. everything from the cookbook script could be ported to the playbook