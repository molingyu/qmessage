require "qmessage/version"

module QMsg

  class QQMessage

    attr_accessor :time
    attr_accessor :u_name
    attr_accessor :u_code
    attr_accessor :message

    def initialize(time, u_name, u_code, message)
      @time = time
      @u_name = u_name
      @u_code = u_code
      @message = message
    end

    def to_json
      "{\"time\":#{@time},\"u_name\":#{@u_name}\"u_code\":#{@u_code}\"message\":#{@message}}"
    end

  end

  class QQMessageList < Array
    alias :to_json :to_s
  end

  def self.run(str)
    @messages = QQMessageList.new
    qq_message = nil
    m_str = ''
    str.split("\n").each do |m|
      if m == "\r"
        qq_message.message = m_str
        @messages.push(qq_message)
        m_str = ''
      end
      if m[/([0-9]{3}\-[0-9]{,2}\-[0-9]{,2}) ([0-9]{,2}):([0-9]{,2}):([0-9]{,2}) ([A-Z][A-Z]) (.*)\(([0-9]*)\)/]
        data = Time.gm(*$1.split('-'), ($5 == 'PM' ? $2.to_i + 12 : $2), $3, $4)
        u_name = $6
        u_code = $7
        qq_message = QQMessage.new(data, u_name, u_code, '')
        next
      end
      m_str = m_str + m
    end
    return @messages if @messages.last == qq_message
    qq_message.message = m_str
    @messages.push(qq_message)
  end

end

