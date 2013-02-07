require 'net/ntp'
require 'net/ntp/next/version'


module Net
    module NTP
        def self.get(host='pool.ntp.org', port='ntp', timeout=TIMEOUT)
            sock = UDPSocket.new
            sock.connect(host, port)

            client_time_send      = Time.new.to_i
            client_localtime      = client_time_send
            client_adj_localtime  = client_localtime + NTP_ADJ
            client_frac_localtime = frac2bin(client_adj_localtime)

            ntp_msg = (['00011011']+Array.new(12, 0)+[client_localtime, client_frac_localtime.to_s]).pack('B8 C3 N10 B32')

            startTime = Time.new.to_f

            sock.print ntp_msg
            sock.flush

            data = nil
            Timeout::timeout(timeout) do |t|
                data = sock.recvfrom(960)[0]
            end

            endTime = Time.new.to_f

            Response.new(data, startTime, endTime)
        end

        class Response
            def initialize(raw_data, startTime=0, endTime=0)
                @raw_data             = raw_data
                @client_time_receive  = Time.new.to_i
                @packet_data_by_field = nil
                @startTime = startTime
                @endTime = endTime
            end

            def latency
                @endTime-@startTime
            end

            def timeDifference
                receive_timestamp-@startTime
            end

            def realDifference
                timeDifference-(latency/2)
            end
        end
    end
end
