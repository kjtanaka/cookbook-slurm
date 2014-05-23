#
# Cookbook Name:: slurm
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#secrets = Chef::EncryptedDataBagItem.load("slurm", "secrets")

slurm_control_machine = node['slurm']['control_machine']
slurm_procs = node['slurm']['procs']
slurm_node_name = node['slurm']['node_name']
slurm_state_save_location = node['slurm']['state_save_location']
slurm_log_dir = node['slurm']['log_dir']

# install necessary packages
packages = %w[
	rpm-build
	readline
	readline-devel
	openssl-devel
	munge-devel
	pam-devel
	perl-ExtUtils-MakeMaker
	perl-DBI
]

packages.each do |pkg|
	package pkg do
		action :install
	end
end

slurm_download_url = "http://www.schedmd.com/download/latest/slurm-14.03.3-2.tar.bz2"

remote_file "/tmp/slurm-14.03.3-2.tar.bz2" do
	source slurm_download_url
	mode "0644"
	checksum "760320e81511198a7b723a00c9b96948"
end

execute "rpmbuild_slurm" do
	user "root"
	cwd "/tmp"
	command "rpmbuild -ta slurm-14.03.3-2.tar.bz2"
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
end

service "slurm" do
	supports :restart => true
	action [:enable, :start]
end
