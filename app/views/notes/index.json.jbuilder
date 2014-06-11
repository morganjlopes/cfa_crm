json.array!(@notes) do |note|
  json.extract! note, :id, :body, :reminder_ds, :reminder_sent_dts, :user_id, :attachment, :noteable_id, :noteable_type
  json.url note_url(note, format: :json)
end
