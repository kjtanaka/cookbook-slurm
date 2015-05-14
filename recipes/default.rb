#
# Cookbook Name:: slurm
# Recipe:: default
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright 2014, FutureGrid, Indiana Univercity
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "munge"
include_recipe "build-essential"
include_recipe "selinux::disabled"

slurm_control_machine = node['slurm']['control_machine']
slurm_procs = node['slurm']['procs']
slurm_node_name = node['slurm']['node_name']
slurm_state_save_location = node['slurm']['state_save_location']
slurm_log_dir = node['slurm']['log_dir']

# install necessary packages
packages = %w[ rpm-build readline readline-devel openssl-devel munge-devel
	pam-devel perl-ExtUtils-MakeMaker perl-DBI ]

packages.each do |pkg|
	package pkg do
		action :install
	end
end

remote_file "/tmp/slurm-#{node['slurm']['version']}.tar.bz2" do
	source node['slurm']['download_url']
	mode "0644"
end

execute "rpmbuild_slurm" do
	user "root"
	cwd "/tmp"
	command "rpmbuild -ta slurm-#{node['slurm']['version']}.tar.bz2"
	creates "/root/rpmbuild/RPMS/x86_64/"
end

execute "rpminstall_slurm" do
	user "root"
	command "rpm --install /root/rpmbuild/RPMS/x86_64/*.rpm"
	creates "/etc/slurm/"
end

directory slurm_state_save_location do
	owner "root"
	group "root"
	mode "0755"
	recursive true
	action :create
end

directory slurm_log_dir do
	owner "root"
	group "root"
	mode "0755"
	recursive true
	action :create
end

template "/etc/slurm/slurm.conf" do
	owner "root"
	group "root"
	variables(
		:slurm_control_machine => slurm_control_machine,
		:slurm_procs => slurm_procs,
		:slurm_node_name => slurm_node_name,
		:slurm_state_save_location => slurm_state_save_location,
		:slurm_log_dir => slurm_log_dir
	)
	notifies :restart, "service[slurm]", :immediately
  action :create_if_missing
end

service "slurm" do
	supports :restart => true
	action [:enable, :start]
end
