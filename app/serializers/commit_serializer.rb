class CommitSerializer < ActiveModel::Serializer
  def initialize(commit)
    @commit = commit
  end

  def as_json(*)
    {
      message: @commit.dig('commit', 'message'),
      author: {
        "name": @commit.dig('commit', 'author', 'name'),
        "date": @commit.dig('commit', 'author', 'date'),
        "email": @commit.dig('commit', 'author', 'email')
      },
      committer: {
        "name": @commit.dig('commit', 'committer', 'name'),
        "date": @commit.dig('commit', 'committer', 'date'),
        "email": @commit.dig('commit', 'committer', 'email')
      },
      "parents": [
        {
          "oid": @commit.dig('parents')&.pluck('sha')
        }
      ]
    }
  end
end
