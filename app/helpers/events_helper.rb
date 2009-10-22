module EventsHelper
    require "tzinfo"
    require "icalendar"
    require "icalendar/tzinfo"
    require "pp"
    
    def event_calendar(events, tzname)
        tz = TZInfo::Timezone.get(tzname)
        cal = Icalendar::Calendar.new
        if events.size > 0
            cal.add(tz.ical_timezone(events[0].start))
        else
            cal.add(tz.ical_timezone(DateTime.now))
        end
        
        events.each do |e|
            if e.list and e.name and e.description and e.location
                desc = e.description.gsub(/\n\n/,"\n")
                desc.gsub!(/\r/,"")
                # desc.gsub!("\r","")
                cal.event do
                    dtstart e.start.to_datetime
                    dtend  e.end.to_datetime
                    summary e.name
                    description desc
                    location "#{e.location.address.gsub(/\n/,",")}"
                    organizer     "MAILTO:#{e.list.from}"
                    klass       "PUBLIC"
                end
            end
        end
        return cal
    end
    
end

