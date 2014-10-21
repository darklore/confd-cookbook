default['confd']['install_dir'] = '/usr/local/bin'
default['confd']['version'] = '0.6.3'

default['confd']['checksums'] = {
  '0.6.3_linux_amd64' => 'bac70a934f0b7586404a906b914e1c74a7596ede7e2e459019fad63aa2f78430'
}

default['confd']['config_dir'] = '/etc/confd'
default['confd']['resource_config_dir'] = '/etc/confd/conf.d'
default['confd']['template_dir'] = '/etc/confd/templates'

default['confd']['backend'] = 'etcd'
default['confd']['nodes'] = []
