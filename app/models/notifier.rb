class Notifier < ActionMailer::Base
    require "tzinfo"
    require "icalendar"
    require "icalendar/tzinfo"

    private
    def create_cal
        estart = DateTime.new(2008, 12, 30, 8, 0, 0)
        eend = DateTime.new(2008, 12, 30, 11, 0, 0)
        tstring = "America/Chicago"
        
        tz = TZInfo::Timezone.get(tstring)
        cal = Icalendar::Calendar.new
        timezone = tz.ical_timezone(estart)

        cal.add(timezone)

        cal.event do
            dtstart       estart
            dtend        eend
            summary     "Meeting with the man."
            description "Have a long lunch meeting and decide nothing..."
            transparency "transparent"
            organizer     "MAILTO:netflix@dague.net"
            klass       "PUBLIC"
        end
        return cal
    end
    
    public
    def invitation(recipient)
        recipients      "sean@dague.net"
        # recipient.email_address_with_name
        subject         "Invitation"
        from            "netflix@dague.net"
        content_type    "multipart/mixed"
        
        part "text/plain" do |p|
            p.body = "This is an ical test"
        end
        
        part "text/calendar" do |p|
            cal = create_cal
            cal.ip_method = "REQUEST" # so it triggers this as an invite
            p.body = cal.to_ical
            # p.transfer_encoding = "base64"
        end
        
#         part :content_type => "text/html",
#         :body => render_message("signup-as-html", :account => recipient)
        
#       part "text/plain" do |p|
#         p.body = render_message("signup-as-plain", :account => recipient)
#         p.transfer_encoding = "base64"
#       end
    end

end
