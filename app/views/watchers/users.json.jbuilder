#{
#    more: false,
#    results: [
#        { id: 1, text: "Vasya Pupkin" },
#        { id: 2, text: "Barak Obama" },
#    ]
#}
json.more false
json.results do |json|
  json.array! @users do |json, user|
    json.id user.id
    json.text user.name
  end
end
