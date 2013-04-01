json.array! @assignees do |json, assignee|
  if assignee.is_a?(Hash)
    json.label assignee[:label]
    json.value assignee[:value]
  elsif assignee.is_a?(Group)
    json.label "#{l(:label_group)}: #{assignee.name}"
    json.value assignee.id
  else
    json.label assignee.name
    json.value assignee.id
  end
end
