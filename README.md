slurm Cookbook
==============
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwich.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - slurm needs toaster to brown your bagel.

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
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
</table>

Usage
-----
#### slurm::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `slurm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[slurm]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
