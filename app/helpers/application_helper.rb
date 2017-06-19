
module ApplicationHelper

	include MetaTagsHelper

	def application_name
    ENV['app_name']
  end

  def application_description
    ENV['app_description']
  end

	def profile_image_tag(user, size, clazz='')
		image_tag('profile_red.png', alt: "user.name", size: size)
	end

	def image_span_tag(image, text, clazz='')
		image_tag(image) + "<span class='#{clazz}'>#{text}</span>".html_safe
	end

	def book_image_tag(image, title, clazz='')
		image_tag( image['url'], alt: title, size: "#{image['width']}x#{image['height']}", class: clazz)
	end

end
