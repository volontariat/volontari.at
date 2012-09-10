module CommentsHelper
  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      next if comment.id.blank?
      
      content = render(partial: 'comments/resource', locals: { resource: comment }) 
      content += content_tag(:div, nested_comments(sub_comments), class: 'nested_comments')
      content
    end.join.html_safe
  end
end