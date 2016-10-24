require "qmessage/version"
require 'json'
module QMsg

  QQMessage = Struct.new(:time, :u_name, :u_code, :message)

  class QQMessage
    def to_json(num)
      self.to_h.to_json(num)
    end
  end

  class << self
    def run(str)
      @messages = []
      qq_message = nil
      m_str = ''
      str.split("\n").each do |m|
        if m == "\r"
          qq_message.message = m_str
          @messages.push(qq_message)
          m_str = ''
        end
        if m[/([0-9]{3}\-[0-9]{,2}\-[0-9]{,2}) ([0-9]{,2}):([0-9]{,2}):([0-9]{,2}) ([A-Z][A-Z]) (.*)\(([0-9]*)\)/]
          data = Time.gm(*$1.split('-'), time12for24($2.to_i, $5), $3, $4)
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

    private
    def time12for24(time, type)
      if type == 'PM' || type == 'pm'
        return 0 if time == 12
        time + 12
      else
        time
      end
    end
  end

end

