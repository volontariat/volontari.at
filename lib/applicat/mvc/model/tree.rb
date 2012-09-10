module Applicat
  module Mvc
    module Model
      module Tree
        def self.included(base)
          base.class_eval do
            has_ancestry :cache_depth => true, :orphan_strategy => :rootify

            acts_as_list

            default_scope :order => 'position'
            
            def add_child(element,position=nil)
              #need to add errors to @element.errors and return something
              temp = element.children
              element.ancestry = self.child_ancestry
              element.position = position || siblings.to_i + 1
              element.save
              return element.update_children(temp)
            end
            
            # Accepts the typical array of ids from a scriptaculous sortable. It is called on the instance being moved
            def sort(array_of_ids)
              if array_of_ids.first == id.to_s
                move_to_left_of siblings.find(array_of_ids.second)
              else
                move_to_right_of siblings.find(array_of_ids[array_of_ids.index(id.to_s) - 1])
              end
            end
            
            def move_to_child_of(reference_instance)
              transaction do
                remove_from_list
                self.update_attributes!(:parent => reference_instance)
                add_to_list_bottom
                save!
              end
            end
            
            def move_to_left_of(reference_instance)
              transaction do
                remove_from_list
                reference_instance.reload # Things have possibly changed in this list
                self.update_attributes!(:parent_id => reference_instance.parent_id)
                reference_item_position = reference_instance.position
                increment_positions_on_lower_items(reference_item_position)
                self.update_attribute(:position, reference_item_position)
              end
            end
            
            def move_to_right_of(reference_instance)
              transaction do
                remove_from_list
                reference_instance.reload # Things have possibly changed in this list
                self.update_attributes!(:parent_id => reference_instance.parent_id)
                if reference_instance.lower_item
                  lower_item_position = reference_instance.lower_item.position
                  increment_positions_on_lower_items(lower_item_position)
                  self.update_attribute(:position, lower_item_position)
                else
                  add_to_list_bottom
                  save!
                end
              end   
            end
            
            protected
            
            def update_children(children)
              children.each do |child|
                temp = child.children
                child.ancestry = self.child_ancestry
                child.save!
                return child.update_children(temp)
              end
            end
          end
        end
      end
    end
  end
end