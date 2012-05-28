module ApplicationHelper
	def current_user  
		if session[:user_id]
			current_user ||= User.find(session[:user_id])
		else
			current_user = nil
			nil
		end
	end

	def tabify list
		r = '<ul class="nav nav-tabs">'
		active = true
		list.each_pair do |li, str|
			if content_for? li
				r << "
				"
				if active
					r << '<li class="active"><a data-toggle="tab" href="#'+li.to_s+'">'+str+'</a></li>'
					active = false
				else
					r << '<li><a data-toggle="tab" href="#'+li.to_s+'">'+str+'</a></li>'
				end
			end
		end
		r << '</ul>'
		r << "

		"
		r << '<div class="tab-content" style="border: thin inset black; margin-top: 0px; background-color: #fff; padding: 5px;">'
		list.each_pair do |li, str|
			if content_for? li
				if !active
					r << '<div class="tab-pane active" id="'+li.to_s+'">'
					active = true
				else
					r << '<div class="tab-pane" id="'+li.to_s+'">'
				end
				r << "
				"
				r << content_for(li)
				r << "
				"
				r << '</div>'
				r << "
				"
			end
		end
		r << '</div>'
		r.html_safe
	end

	def twitterized_type(type)
		case type
		when :alert
			"warning"
		when :error
			"error"
		when :notice
			"info"
		when :success
			"success"
		else
			type.to_s
		end
	end

	def time_delta time
		if time < Time.now
			distance_of_time_in_words_to_now(time) + " ago"
		else
			distance_of_time_in_words_to_now(time) + " from now"
		end
	end

	def can(right,securable=nil,user=nil)
		raise 'outside of securable resource' if (@chamber == nil && @ballot == nil && @proposal == nil && @board == nil && @securable == nil && securable == nil)
		raise 'no user supplied' if (user == nil && current_user == nil)
		
		x = (securable || @ballot || @proposal || @board || @securable || @chamber).can?(user || current_user, right)
		return '*' if !x && current_user.admin?
		x
	end

	def can? right
		can right
	end


	def truthy_thumb(value)
		if value=="*"
			i('star').html_safe
		elsif value
			i('thumbs-up').html_safe
		else
			i('thumbs-down').html_safe
		end
	end

	def a(condition)
		return '*' if current_user && current_user.admin? && !condition
		condition		 
	end

	def i(c)
		('<i class="icon-' + c + '"></i>').html_safe
	end

	def markdown(text)
		sanitize(BlueCloth::new(text).to_html)
	end

	def nested_comments comments, rev=true, depth=1
	comments.sort{|a,b| rev ? b.created_at <=> a.created_at : a.created_at <=> b.created_at}.map do |comment|
		if comment != nil
		render(:partial => 'comments/comment', :locals => {:item => comment, :parent => false, :depth => (depth > 4 ? comment.count_children-1 : nil)}) + (depth > 4 || comment.comments.length == 0 ? "" : content_tag(:div, nested_comments(comment.comments,false,depth+1), :class => 'nested_comment'))
		end
	end.join.html_safe if comments.is_a? Array
	
  end
end