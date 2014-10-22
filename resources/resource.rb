actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :src, :kind_of => String, :required => true
attribute :dest, :kind_of => String, :required => true
attribute :keys, :kind_of => Array, :required => true

attribute :prefix, :kind_of => String
attribute :owner, :kind_of => String
attribute :group, :kind_of => String
attribute :mode, :kind_of => String

attribute :reload_cmd, :kind_of => String
attribute :check_cmd, :kind_of => String
