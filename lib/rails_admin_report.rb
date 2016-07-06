require "rails_admin_report/engine"

module RailsAdminReport
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Report < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :root? do
          true
        end

        register_instance_option :breadcrumb_parent do
          nil
        end
        register_instance_option :route_fragment do
          'report'
        end
        register_instance_option :pjax? do
          false
        end
        register_instance_option :link_icon do
          'fa fa-pie-chart'
        end
        register_instance_option :controller do
          Proc.new do
            map_object_type = %Q{
              function() {
                emit(this.object_type, 1 );
              }
            }

            map_contract_type = %Q{
              function() {
                emit(this.contract_type, 1 );
              }
            }

            map_contract_model = %Q{
              function() {
                emit(this.contract_model, 1 );
              }
            }
            map_requesting = %Q{
              function() {
                emit(this.requesting, 1 );
              }
            }


            reduce = %Q{
              function(key, values) {
                var result =  0 ;
                values.forEach(function(value) {
                  result += value;
                });
                return result;
              }
            }

            object_type_map = Contract.map_reduce(map_object_type, reduce).out(replace: "object_type_db")
            @chart_object_type = Hash[object_type_map.map do |item|
              [item['_id'], item['value']]
            end]

            contracts_type_map = Contract.map_reduce(map_contract_type, reduce).out(replace: "contract_type_db")
            @chart_contract_type = Hash[contracts_type_map.map do |item|
              [item['_id'], item['value']]
            end]

            contracts_model_map = Contract.map_reduce(map_contract_model, reduce).out(replace: "contract_model_db")
            @chart_contract_model = Hash[contracts_model_map.map do |item|
              [item['_id'], item['value']]
            end]

            requesting_map = Contract.map_reduce(map_requesting, reduce).out(replace: "requesting_db")
            @chart_requesting = Hash[requesting_map.map do |item|
                                      [item['_id'], item['value']]
                                    end]

            contrato = Contract.all
            @total_contracts = contrato.count
            @total_accountability = Accountability.all.count
            @total_value = contrato.sum(:total_value)
            @total_budget = contrato.sum(:total_budget)
            @total_executed = contrato.sum(:total_executed)
            @total_vendors = Vendor.all.count

            render @action.template_name, status: 200

          end
        end
      end
    end
  end
end
