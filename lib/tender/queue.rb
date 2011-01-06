module Tender
  class Queue
    def self.add(url_template, queue_id)
      headers = { 
        'X-Tender-Auth' => Tender.auth_token, 
        'Accept' => 'application/json'
      }  
      tmpl = Addressable::Template.new(url_template)
      resp = HTTParty.post(tmpl.expand('queue_id' => queue_id).to_s, :headers => headers, :body => "")
      raise TenderError, "Discussion was not added to queue. Response was: #{resp.body}" unless resp.code == 200
    end
  end
end
