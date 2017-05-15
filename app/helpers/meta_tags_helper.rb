
module MetaTagsHelper

	def og_html(url, type, title, image, description)
		og = <<-EOF
			<meta property='fb:app_id' content='#{ENV['fb_app_id']}' />
			<meta property='og:url' content='#{url}' />
			<meta property='og:type' content='#{type}' />
			<meta property='og:title' content='#{title}' />
			<meta property='og:description' content='#{description}' />
			<meta property='og:image' content='#{image}' />
		EOF
		og.html_safe
	end

	def fb_meta_tags(item)
		affiliate_url = "https://www.amazon.de/dp/#{item[:id]}/?tag=#{ENV['amzn_partner_id']}"
		og_html affiliate_url, 'article', item[:title], item[:images][0]['url'], item[:summary]
	end

end
