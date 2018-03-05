class Site
  class << self
    def select(site = nil)
      return batman if site.to_s == 'batman'
      return characters if site.to_s == 'characters'
      default
    end

    private

    def default
      'https://blog.trueheart78.com/games/'
    end

    def characters
      'https://blog.trueheart78.com/character-names/'
    end

    def batman
      'http://www.bonuserupt.us'
    end
  end
end
