require 'spec_helper'


describe Net::NTP do

    describe 'get' do
        it 'should return Response' do
            result = Net::NTP.get('pool.ntp.org', 'ntp', 10)
            result.should be_kind_of(Net::NTP::Response)
        end
    end

    describe Net::NTP::Response do
        let(:startTime) { 1362766284.080817  }
        let(:realTime)  { 1362766283.018052  }
        let(:endTime)   { 1362766284.3670762 }
        let(:response)  { Net::NTP::Response.new("\x1C\x03\0\xE9\0\0\0;\0\0\n\xDB\x80 \xCE7\xD4\xE4\xA5\xD2\x1D\xFF\xF6\xDDQ:)\xCC\xDD\0\0\0\xD4\xE4\xA8K\x04\x9F\rw\xD4\xE4\xA8K\x04\xA2\xBC\v", startTime, endTime) }
        describe '#latency' do
            it 'should return latency' do
                response.latency.should eq(endTime-startTime)
            end
        end

        describe '#timeDifference' do
            it 'should return differnece between times' do
                response.timeDifference.should eq(realTime-startTime)
            end
        end

        describe '#realDifference' do
            it 'should return time difference without latency' do
                response.realDifference.should eq(realTime-(endTime-startTime)/2-startTime)
            end
        end
    end

end

