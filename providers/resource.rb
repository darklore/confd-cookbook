action :create do
  template "#{node['confd']['resource_dir']}/#{new_resource.name}" do
    source 'resource.erb'
    cookbook 'confd'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables(
      :name => new_resource.name,
      :src => new_resource.src,
      :dest => new_resource.dest,
      :keys => new_resource.keys,

      :prefix => new_resource.prefix,
      :owner => new_resource.owner,
      :group => new_resource.group,
      :mode => new_resource.mode,
      :reload_cmd => new_resource.reload_cmd,
      :check_cmd => new_resource.check_cmd
    )
  end
end
