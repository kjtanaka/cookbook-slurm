slurm Cookbook
==============
This cookbook Installs [slurm](https://computing.llnl.gov/linux/slurm/).

Requirements
------------
#### Cookbooks
- yum-epel
- build-essential
- selinux
- munge, git: https://github.com/kjtanaka/cookbook-munge.git

Attributes
----------
#### slurm::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['slurm']['control_machine']</tt></td>
    <td>Text</td>
    <td>Control Node</td>
    <td><tt>linux0</tt></td>
  </tr>
  <tr>
    <td><tt>['slurm']['procs']</tt></td>
    <td>Integer</td>
    <td>Number of processor</td>
    <td><tt>1</tt></td>
  </tr>
  <tr>
    <td><tt>['slurm']['node_name']</tt></td>
    <td>Text</td>
    <td>Name of nodes</td>
    <td><tt>linux[1-32]</tt></td>
  </tr>
  <tr>
    <td><tt>['slurm']['state_save_location']</tt></td>
    <td>Text</td>
    <td>Directory to save location</td>
    <td><tt>/var/lib/slurm/tmp</tt></td>
  </tr>
</table>

Usage
-----
#### slurm::default
For example, if you have machines, `node0`(controller node), `node1`(compute node), `node2`(compute node) and `node3`(compute node), the json file will be like this.

```json
{
  "name":"node0",
  "run_list": [
    "recipe[slurm]"
  ],
  "slurm": {
    "control_machine": "node0",
    "node_name": "node[1-3]"
  }
}
```

License and Authors
-------------------
- Author:: Koji Tanaka (<kj.tanaka@gmail.com>)

```text
Copyright 2014, FutureGrid, Indiana Univercity

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```