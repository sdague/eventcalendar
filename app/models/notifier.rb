module ActionMailer
    # we override this because rails wants to do multipart alternative emails, and we need multipart mixed to add in the ical bit
    class Base
        # Initialize the mailer via the given +method_name+. The body will be
        # rendered and a new TMail::Mail object created.
        def create!(method_name, *parameters) #:nodoc:
            initialize_defaults(method_name)
            __send__(method_name, *parameters)
            
            # If an explicit, textual body has not been set, we check assumptions.
            unless String === @body
                # First, we look to see if there are any likely templates that match,
                # which include the content-type in their file name (i.e.,
                # "the_template_file.text.html.erb", etc.). Only do this if parts
                # have not already been specified manually.
                if @parts.empty?
                    Dir.glob("#{template_path}/#{@template}.*").each do |path|
                        template = template_root["#{mailer_name}/#{File.basename(path)}"]
                        
                        # Skip unless template has a multipart format
                        next unless template && template.multipart?
                        
                        @parts << Part.new(
                                           :content_type => template.content_type,
                                           :disposition => "inline",
                                           :charset => charset,
                                           :body => render_message(template, @body)
                                           )
                    end
                    unless @parts.empty?
                        unless @content_type =~ /^multipart/
                            @content_type = "multipart/alternative"
                        end
                        @parts = sort_parts(@parts, @implicit_parts_order)
                    end
                end
                
                # Then, if there were such templates, we check to see if we ought to
                # also render a "normal" template (without the content type). If a
                # normal template exists (or if there were no implicit parts) we render
                # it.
                template_exists = @parts.empty?
                template_exists ||= template_root["#{mailer_name}/#{@template}"]
                @body = render_message(@template, @body) if template_exists
                
                # Finally, if there are other message parts and a textual body exists,
                # we shift it onto the front of the parts and set the body to nil (so
                # that create_mail doesn't try to render it in addition to the parts).
                if !@parts.empty? && String === @body
                    @parts.unshift Part.new(:charset => charset, :body => @body)
                    @body = nil
                end
            end
            
            # If this is a multipart e-mail add the mime_version if it is not
            # already set.
            @mime_version ||= "1.0" if !@parts.empty?
            
            # build the mail object itself
            @mail = create_mail
        end
    end
end

class Notifier < ActionMailer::Base
    require "tzinfo"
    require "icalendar"
    require "icalendar/tzinfo"

    include EventsHelper

    def invitation(event, boilerplate="")
        cal = event_calendar([event], "America/New_York")
        cal.ip_method = "REQUEST"
        
        recipients      event.list.address
        # recipient.email_address_with_name
        subject         "[ANNOUNCE] MHVLUG Meeting #{event.start.to_datetime.strftime("%A, %B %e -%l%P")} -#{event.end.to_datetime.strftime("%l%P")} : #{event.name}"
        from  event.list.from
        content_type    "multipart/mixed"
        body           :event => event, :cal => cal, :boilerplate => boilerplate
        implicit_parts_order  ["text/calendar", "text/plain"]
    end
end
