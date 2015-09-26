module Shingoncoder
  class Job
    class << self
      # @param [Hash] options
      # @option [String] :input the url to the file
      def create(options = {})
        id = Backend::Job.create(options)
        # TODO in the future the backend could be via a HTTP API
        Response.new('id' => id, 'code' => 201)
      end

      def cancel
        fail NotImplementedError
      end

      # Each output should have current_event
      # job itself should have 'progress'
      def progress(id)
        job = Shingoncoder::Backend::JobRegistry::Job.find(id)
        Response.new('body' => id, 'code' => 200)
      end

      # should have ["job"]["input_media_file"]["url"]
      def details
        job = Shingoncoder::Backend::JobRegistry::Job.find(id)
        Response.new('body' => { 'job' => { 'input_media_file' => { 'url' => job.input.fetch('input') } } }, 'code' => 200)
      end
    end
  end
end
