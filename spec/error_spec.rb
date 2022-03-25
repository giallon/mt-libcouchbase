# frozen_string_literal: true, encoding: ASCII-8BIT

require 'mt-libcouchbase'


describe MTLibcouchbase::Error do
    it "define the error classes" do
        expect(MTLibcouchbase::Error::MapChanged.new.is_a? StandardError).to be(true)
    end

    it "should be able to look up errors" do
        expect(MTLibcouchbase::Error::Lookup[:empty_key]).to   be(MTLibcouchbase::Error::EmptyKey)
        expect(MTLibcouchbase::Error.lookup(:empty_key)).to    be(MTLibcouchbase::Error::EmptyKey)
        expect(MTLibcouchbase::Error.lookup(:whatwhat_key)).to be(MTLibcouchbase::Error::UnknownError)
        expect(MTLibcouchbase::Error.lookup(2)).to             be(MTLibcouchbase::Error::AuthError)
        expect(MTLibcouchbase::Error.lookup(-2)).to            be(MTLibcouchbase::Error::UnknownError)
    end

    it "should be able to catch generic errors" do
        begin
            raise ::MTLibcouchbase::Error::NoMemory, 'what what'
        rescue ::MTLibcouchbase::Error => e
            expect(e.message).to eq('what what')
        end
    end
end
