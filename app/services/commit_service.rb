require 'uri'
require 'net/http'
require 'json'

class CommitService
  def initialize(owner, repository, oid)
    @owner = owner
    @repository = repository
    @oid = oid
    @base_url = "https://api.github.com/repos/#{@owner}/#{@repository}/commits/#{@oid}"
  end

  def get_commit
    commit_details = make_github_api_request(@base_url, false)
    JSON.parse(commit_details)
  end

  private

  def make_github_api_request(uri, diff)
    url = URI(uri)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['Accept'] = 'application/vnd.github.diff' if diff == true

    response = https.request(request)
    response.read_body
  end
end
