class Site
  class << self
    def select(site = nil)
      return batman if site.to_s == 'batman'
      return characters if site.to_s == 'characters'
      default
    end

    private

    def default
      'http://blog.trueheart78.com/games/'
    end

    def characters
      'http://blog.trueheart78.com/character-names/'
    end

    def batman
      'https://doggettck.github.io'
    end
  end
end
