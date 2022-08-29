module Piwik
  class Contents < ApiModule
    available_methods %W{
      getContentNames
      getContentPieces
    }
  end
end