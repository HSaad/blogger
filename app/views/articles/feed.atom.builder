atom_feed :language => 'en-US' do |feed|
  feed.title "Articles"
  feed.updated Time.now

  @articles.each do |item|
    next if item.created_at.blank?

    feed.entry( item ) do |entry|
      entry.url article_url(item)
      entry.title item.title
      entry.content item.body, :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(item.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 
    end
  end
end