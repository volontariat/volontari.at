# Renders an ItemContainer as a <div> element and its containing items as <a> elements.
# It only renders 'selected' elements.
#
# By default, the renderer sets the item's key as dom_id for the rendered <a> element unless the config option <tt>autogenerate_item_ids</tt> is set to false.
# The id can also be explicitely specified by setting the id in the html-options of the 'item' method in the config/navigation.rb file.
# The ItemContainer's dom_class and dom_id are applied to the surrounding <div> element.
#
class Vendors::SimpleNavigation::Renderer::BreadcrumbsWithoutMethodLinks < SimpleNavigation::Renderer::Breadcrumbs
  protected

  def a_tags(item_container, parent_list = [])
    item_container.items.inject([]) do |list, item|
      if item.method.blank? && item.selected?
        list << tag_for(item) unless parent_list.join('').match(item.url)

        if include_sub_navigation?(item)
          list.concat a_tags(item.sub_navigation, list.clone)
        end
      end
      
      list
    end
  end
end
