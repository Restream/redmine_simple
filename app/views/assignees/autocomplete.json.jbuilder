#{
#    more: false,
#    results: [
#        { id: 1, text: "Vasya Pupkin" },
#        { id: 2, text: "Barak Obama" },
#        { text: "Group:", children: [
#            { id: 3, text: "Developers" },
#            { id: 4, text: "Testers" }
#        ] }
#    ]
#}
json.more false
json.results do |json|

  # return groups using hierarchy
  groups, assignees = @assignees.partition { |a| a.is_a? Group }

  assignees.map! do |assignee|
    if assignee.is_a?(Hash)
      { :id => assignee[:value], :text => assignee[:label] }
    else
      { :id => assignee.id, :text => assignee.name }
    end
  end

  if groups.any?
    assignees << {
        :text => l(:label_group),
        :children => groups.map do |assignee|
          { :id => assignee.id, :text => assignee.name }
        end
    }
  end

  json.array! assignees do |json, assignee|
    json.text assignee[:text]
    json.id assignee[:id] if assignee.has_key? :id
    json.children assignee[:children] if assignee.has_key? :children
  end

end
