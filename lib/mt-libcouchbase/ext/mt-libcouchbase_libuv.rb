
# This file contains all the structures required to configure mtlibcouchbase to use
# Libuv as the primary event loop

module MTLibcouchbase::Ext::MTLibuv
    extend FFI::Library
    if FFI::Platform.windows?
        ffi_lib ::File.expand_path("../../../../ext/libcouchbase_libuv.dll", __FILE__)
    else
        ffi_lib ::File.expand_path("../../../../ext/libcouchbase/build/lib/libcouchbase_libuv.#{FFI::Platform::LIBSUFFIX}", __FILE__)
    end

    # ref: http://docs.couchbase.com/sdk-api/couchbase-c-client-2.4.8/group__lcb-libuv.html
    class UVOptions < FFI::Struct
        layout :version,        :int,
               :loop,           :pointer,
               :start_stop_noop,:int
    end

    # pointer param returns IO opts structure
    attach_function :create_libuv_io_opts, :lcb_create_libuv_io_opts, [:int, :pointer, UVOptions.by_ref], ::MTLibcouchbase::Ext::ErrorT
end
