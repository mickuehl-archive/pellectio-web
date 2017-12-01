
module MetaTagsHelper

	def og_html(url, type, title, description, image)
		og = <<-EOF
			<meta property='fb:app_id' content='#{Rails.application.secrets.fb_app_id}' />
			<meta property='og:url' content='#{url}' />
			<meta property='og:type' content='#{type}' />
			<meta property='og:title' content='#{title}' />
			<meta property='og:description' content='#{description}' />
			<meta property='og:image' content='#{image['url']}' />
			<meta property='og:image:width' content='#{image['width']}' />
			<meta property='og:image:height' content='#{image['height']}' />
		EOF
		og.html_safe
	end

	# FIXME
	#<meta property='og:image:width' content='#{image['width']}' />
	#<meta property='og:image:height' content='#{image['height']}' />

	def fb_meta_tags(item)
		#affiliate_url = "https://www.amazon.de/dp/#{item[:id]}/?tag=#{ENV['amzn_partner_id']}"
		url = "#{Rails.application.secrets.base_url}/a/#{item['region']}/#{item['asin']}"
		og_html url, 'book', item['title'], item['summary'], item['image']
	end

end
