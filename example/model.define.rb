# data = {
#   'name' => 'ProductTesting', 'theme' => 'journal',
#   'resources' => [{ 'name' => 'product',
#                     'fields' => [{ 'name' => 'name', 'type' => 'string' },
#                                  { 'name' => 'sku',  'type' => 'string' }]
#   }]
# }
#
# load(file) =>
#
# class Product
#   include Mongoid::Document
#   include Mongoid::Timestamps
#
#   ## schema
#
#   field :name, type: String
#   field :sku, type: String
#
#   attr_accessible :name, :sku
# end

FileBuilder.define do |data|
  partial :field do |field|
    attr_name = ":#{field['name'].underscore}"
    ln "field #{attr_name}, type: #{field['type'].capitalize}"
  end

  data['resources'].each do |resource|
    file "#{resource['name'].underscore}.rb" do
      block "class #{resource['name'].capitalize}", 'end' do
        ln 'include Mongoid::Document'
        ln 'include Mongoid::Timestamps'
        ln
        ln '## schema'
        ln
        partial :field, resource['fields']
        ln
        accessibles = resource['fields'].map { |f| ":#{f['name'].underscore}" }
        ln "attr_accessible #{accessibles.join(', ')}"
      end
    end
  end
end
