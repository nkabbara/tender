module Tender
  class Discussion
    def self.create(cat_id, options = {})
      raise ::RuntimeError, ":body is a required option" if options[:body].blank?
      raise ::RuntimeError, "Currently only token authorization is supported. An auth token is required." if Tender.auth_token.blank?
      headers = { 
        'X-Tender-Auth' => Tender.auth_token, 
        'Accept' => 'application/json'
      }  
      url = 'https://api.tenderapp.com/zipzoomauto/'

      resp = HTTParty.post(url + "categories/#{cat_id}/discussions", 
        :headers => headers, 
        :body => {
          :title        => "",
          :skip_spam    => true,
          :public       => false,
          :body         => "",
          :author_email => "support@zipzoomauto.com",
          :author_name  => "Support API"
        }.merge(options),
        :format => :json
      )

      if resp.code == 201
        resps = class << resp; self; end
        resps.send(:define_method, :queue) do |id|
          Queue.add(resp['queue_href'], id)
        end
        resp
      else
        raise TenderError, "#{resp.flatten.join(" ")}"
      end
    end
  end
end
