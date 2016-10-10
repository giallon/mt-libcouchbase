require 'libcouchbase/ext/libcouchbase'
require 'libuv'

# This file contains all the structures required to configure libcouchbase to use
# Libuv as the primary event loop

module Libcouchbase::Ext

    # ref: http://docs.couchbase.com/sdk-api/couchbase-c-client-2.4.8/group__lcb-libuv.html
    class UVOptions < FFI::Struct
        layout :version,        :int,
               :loop,           :pointer,
               :start_stop_noop,:int
    end

    #                                                                       pointer returns IO opts structure
    attach_function :create_libuv_io_opts, :lcb_create_libuv_io_opts, [:int, :pointer, UVOptions.by_ref], ErrorT
end
