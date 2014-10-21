action :create do
  template "#{node['confd']['resource_config_dir']}/#{new_resource.name}" do
    source 'config.erb'
    cookbook 'confd'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables(
      :name => new_resource.name,
      :src => new_resource.src,
      :dest => new_resource.dest,
      :keys => new_resource.keys
    )
  end
end
