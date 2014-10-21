actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :src, :kind_of => String, :required => true
attribute :dest, :kind_of => String, :required => true
attribute :keys, :kind_of => Array, :required => true
