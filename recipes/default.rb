#
# Cookbook Name:: slurm
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

secrets = Chef::EncryptedDataBagItem.load("slurm", "secrets")

munge_key = secrets['munge_key']

packages = %w{munge}

packages.each do |pkg|
	package pkg do
		action :install
	end
end

script "create_munge_key" do
	interpreter "bash"
	user "root"
	code <<-EOH
		echo #{munge_key} > /etc/munge/munge.key
		chmod 0400 /etc/munge/munge.key
	EOH
	creates "/etc/munge/munge.key"
end
