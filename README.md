# Tender API

We use this client in our ZipZoomAuto app.

It's in its infancy, but we'll add it to as we go.

# Example Usage

    Tender.configure do |t|
      t.auth_token = "my secret key"
    end

    discussion_attributes = {
      :body         => "Just wanted to say, your app is amazing.",      
      :title        => "Nice!",
      :author_name  => "Happy User",
      :author_email => "happy@user.com",
      :extras => {
        :company_phone  => "33369"
      }
    }

    discussion = Tender::Discussion.create(some_discussion_id, discussion_attributes)
    discussion.queue(some_queue_id)
