# encoding: utf-8

module Github

  # Since blobs can be any arbitrary binary data, the input and responses for
  # the blob api takes an encoding parameter that can be either utf-8 or base64.
  # If your data cannot be losslessly sent as a UTF-8 string, you can base64 encode it.
  class GitData::Blobs < API

    VALID_BLOB_PARAM_NAMES = %w[ content encoding ].freeze

    # Creates new GitData::Blobs API
    def initialize(options = {})
      super(options)
    end

    # Get a blob
    #
    # = Examples
    #  github = Github.new
    #  github.git_data.blobs.get 'user-name', 'repo-name', 'sha'
    #
    def get(*args)
      arguments(args, :required => [:user, :repo, :sha])

      get_request("/repos/#{user}/#{repo}/git/blobs/#{sha}", arguments.params)
    end
    alias :find :get

    # Create a blob
    #
    # = Inputs
    # * <tt>:content</tt> - String of content
    # * <tt>:encoding</tt> - String containing encoding<tt>utf-8</tt> or <tt>base64</tt>
    # = Examples
    #  github = Github.new
    #  github.git_data.blobs.create 'user-name', 'repo-name',
    #    "content" => "Content of the blob",
    #    "encoding" => "utf-8"
    #
    def create(*args)
      arguments(args, :required => [:user, :repo]) do
        sift VALID_BLOB_PARAM_NAMES
        assert_required VALID_BLOB_PARAM_NAMES
      end

      post_request("/repos/#{user}/#{repo}/git/blobs", arguments.params)
    end

  end # GitData::Blobs
end # Github
