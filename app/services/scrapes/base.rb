class Scrapes::Base
  #gemfileに定義してもいいが他で利用されないなら余計なauto_loadを嫌って以下でrequireする
  require 'open-uri'

  def initialize(action_name,query_params)
    @url = set_url
    @action_name = action_name
    @query_params = query_params
    @uri = create_uri
  end

  private

  def set_url
    raise NotImplementedError 'Please override and use in a subclass'
  end

  def create_uri
    @url + @action_name + @query_params
  end

  def load_uri(uri)
    URI.parse(uri).open('User-Agent' => 'Mozilla/5.0').read
  end
end
