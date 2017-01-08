json.extract! task, :id, :title, :completed, :deadline, :tags, :created_at, :updated_at
json.url task_url(task, format: :json)