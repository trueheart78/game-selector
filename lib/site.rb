class Site
  class << self
    def select(site = nil)
      return batman if site.to_s == 'batman'
      default
    end

    private

    def default
      'http://blog.trueheart78.com/games/'
    end

    def batman
      'https://doggettck.github.io'
    end
  end
end
