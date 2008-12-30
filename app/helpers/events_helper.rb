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
            cal.event do
                dtstart e.start.to_datetime
                dtend  e.end.to_datetime
                summary e.name
                description e.description
                location e.location
                organizer     "MAILTO:sdague@gmail.com"
                klass       "PUBLIC"
            end
        end
        return cal
    end
    
end
