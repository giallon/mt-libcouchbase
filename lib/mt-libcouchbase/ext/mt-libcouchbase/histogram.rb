module MTLibcouchbase::Ext
  # (Not documented)
  module HISTOGRAMWrappers
    # @return [nil]
    def destroy()
      MTLibcouchbase::Ext.histogram_destroy(self)
    end

    # @param [Integer] duration
    # @return [nil]
    def record(duration)
      MTLibcouchbase::Ext.histogram_record(self, duration)
    end

    # @param [FFI::Pointer(*Void)] cookie
    # @param [Proc(callback_histogram_callback)] cb
    # @return [nil]
    def read(cookie, cb)
      MTLibcouchbase::Ext.histogram_read(self, cookie, cb)
    end

    # @param [FFI::Pointer(*FILE)] stream
    # @return [nil]
    def print(stream)
      MTLibcouchbase::Ext.histogram_print(self, stream)
    end
  end

  class HISTOGRAM < FFI::Struct
    include HISTOGRAMWrappers
    layout :dummy, :char
  end

end
