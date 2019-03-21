class Rack::Attack
	# 1.2.3.4からのアクセスを拒否する
	# Rack::Attack.blocklist('block 1.2.3.4') do |req|
	# 	'1.2.3.4' == req.ip
	# end
	# BadUAが含まれたUserAgentからのログイン画面アクセスを拒否する
	# Rack::Attack.blocklist('block bad UA logins') do |req|
	# 	req.path == '/login' && req.post? && req.user_agent == 'BadUA'
	# end

	Rack::Attack.blocklist('自分以外は認証画面拒否') do |req|
		req.path == '/signup' || req.path == '/users/sign_up' || req.path.start_with?("/users/password")
	end
	# ホワイトリスト設定
	Rack::Attack.safelist('ローカルホストと自分を許可') do |req|
   '127.0.0.1' == req.ip || '::1' == req.ip || ENV["ip_address"] == req.ip
    end

  # 同一IPアドレスからのリクエストを60回/分に制限
	Rack::Attack.throttle('req/ip', limit: 300, period: 5.minutes) do |req|
	  req.ip
	end

	# アタックや過度なクローリングの対策になる https://blog.nakamu.life/posts/rails-dos-rack-attack/

end