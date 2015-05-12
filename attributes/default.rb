default['slurm']['version'] = '14.11.6'
default['slurm']['download_url'] = "http://www.schedmd.com/download/latest/slurm-#{node['slurm']['version']}.tar.bz2"
default['slurm']['control_machine'] = "linux0"
default['slurm']['procs'] = "1"
default['slurm']['node_name'] = "linux[1-32]"
default['slurm']['state_save_location'] = "/var/lib/slurm/tmp"
default['slurm']['log_dir'] = "/var/log/slurm"
