class ElevenNote
  include HTTParty
  include Singleton

  API_BASE = Rails.application.secrets.elevennote_api_base

  base_uri API_BASE

  # ElevenNote.find(note_id)
  def self.find(id, api_key)
    get "/notes/#{id}?api_key=#{api_key}"
  end

  # post = Post.first
  # ElevenNote.create_from(post)
  def self.create_from(post, api_key)
    content = post.link.presence || post.body
    post "/notes",
      body: {
        api_key: api_key,
        note: {
          title: post.title,
          body_html: content
        }
      }
  end
end
