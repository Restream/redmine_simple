#{
#    more: false,
#    results: [
#        { id: 1, text: "Vasya Pupkin" },
#        { id: 2, text: "Barak Obama" },
#        { text: "Group:", children: [
#            { id: 3, text: "Developers" },
#            { id: 4, text: "Testers" }
#        ] },
#        { text: "Non member:", children: [
#            { id: 5, text: "Iron Men" },
#            { id: 6, text: "Pieter Pen" }
#        ] }
#    ]
#}
json.more false
json.results do |json|

  assignees = []

  assignees << @me unless @me.nil?

  assignees += @users.map { |u| { :id => u.id, :text => u.name } }

  if @groups.any?
    assignees << {
        :text => l(:label_group),
        :children => @groups.map do |assignee|
          { :id => assignee.id, :text => assignee.name }
        end
    }
  end

  if @non_members.any?
    assignees << {
        :text => l(:label_role_non_member),
        :children => @non_members.map do |assignee|
          { :id => assignee.id, :text => assignee.name, :non_member => true }
        end
    }
  end

  json.array! assignees do |json, assignee|
    json.id assignee[:id] if assignee.has_key? :id
    json.text assignee[:text]
    json.children assignee[:children] if assignee.has_key? :children
  end

end
