#{
#    more: false,
#    results: [
#        { id: 1, text: "Vasya Pupkin" },
#        { id: 2, text: "Barak Obama" },
#        { text: "Non member:", children: [
#            { id: 5, text: "Iron Men" },
#            { id: 6, text: "Pieter Pen" }
#        ] }
#    ]
#}
json.more false
json.results do |json|

  watchers = @members.map { |u| { :id => u.id, :text => u.name } }

  if @non_members.any?
    watchers << {
        :text => l(:label_role_non_member),
        :children => @non_members.map do |watcher|
          { :id => watcher.id, :text => watcher.name }
        end
    }
  end

  json.array! watchers do |json, watcher|
    json.id watcher[:id] if watcher.has_key? :id
    json.text watcher[:text]
    json.children watcher[:children] if watcher.has_key? :children
  end
end
