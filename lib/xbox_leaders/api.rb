require 'httparty'

class XboxLeaders::Api

  include HTTParty
  base_uri 'http://xbox.alvanista.com'

  attr_accessor :timeout
  
  def initialize(timeout = 6)
    @timeout = timeout
  end

  def fetch_achievements(gamertag, game_id)
    get('/achievements.php', gamertag: gamertag, gameid: game_id)
  end

  def fetch_friends(gamertag)
    get('/friends.php', gamertag: gamertag)
  end
  
  def fetch_games(gamertag)
    get('/games.php', gamertag: gamertag)
  end

  def fetch_profile(gamertag)
    get('/profile.php', gamertag: gamertag)
  end

  private

  def get(path, query={})
    response = self.class.get(path, timeout: timeout, query: query).to_hash

    if response['status'] == 'error'
      raise ArgumentError, "#{response['data']['code']}: #{response['data']['message']}"
    end

    response['data']
  end

end
