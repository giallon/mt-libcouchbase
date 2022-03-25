# frozen_string_literal: true, encoding: ASCII-8BIT

require 'libuv'

module MTLibcouchbase
    require 'mt-libcouchbase/ext/mt-libcouchbase'
    require 'mt-libcouchbase/error'
    require 'mt-libcouchbase/callbacks'
    require 'mt-libcouchbase/connection'

    DefaultOpts = Struct.new(:host, :bucket, :username, :password)
    Defaults = DefaultOpts.new('127.0.0.1', 'default')

    class Results
        include Enumerable

        # streams results as they are returned from the database
        #
        # unlike other operations, such as each, the results are not stored
        # for later use and are discarded as soon as possible to save memory
        #
        # @yieldparam [Object] value the value of the current row
        def stream; end

        attr_reader :complete_result_set, :query_in_progress
        attr_reader :query_completed, :metadata
    end

    autoload :N1QL,          'mt-libcouchbase/n1ql'
    autoload :Bucket,        'mt-libcouchbase/bucket'
    autoload :QueryView,     'mt-libcouchbase/query_view'
    autoload :QueryN1QL,     'mt-libcouchbase/query_n1ql'
    autoload :QueryFullText, 'mt-libcouchbase/query_full_text'
    autoload :DesignDoc,     'mt-libcouchbase/design_docs'
    autoload :DesignDocs,    'mt-libcouchbase/design_docs'
    autoload :ResultsEM,     'mt-libcouchbase/results_fiber'
    autoload :ResultsLibuv,  'mt-libcouchbase/results_fiber'
    autoload :ResultsNative, 'mt-libcouchbase/results_native'
    autoload :SubdocRequest, 'mt-libcouchbase/subdoc_request'
end
