# frozen_string_literal: true
# This migration comes from spree (originally 20170319191942)

class RemoveOrderIdFromInventoryUnits < ActiveRecord::Migration[5.0]
  def up
    remove_column :spree_inventory_units, :order_id
  end

  def down
    add_reference :spree_inventory_units, :order, index: true
  end
end
