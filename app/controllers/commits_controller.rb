class CommitsController < ApplicationController
  before_action :commit_params

  def commit
    commit = @commit.get_commit
    render json: CommitSerializer.new(commit).as_json
  end

  private

  def commit_params
    owner = params[:owner]
    repository = params[:repository]
    oid = params[:oid]
    @commit = CommitService.new(owner, repository, oid)
  end
end
