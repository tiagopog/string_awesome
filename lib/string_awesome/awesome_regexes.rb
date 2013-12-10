module StringAwesome
  module AwesomeRegexes
    SA_ACCENT_REGEX   = /[^\x00-\x7F]/n
    SA_URL_REGEX      = /\b(((ht|f)tp[s]?:\/\/)?([a-z0-9]+\.)?(?<!@)([a-z0-9\_\-]+)(\.[a-z]+)+([\?\/\:][a-z0-9_=%&@\?\.\/\-\:\#\(\)]+)?\/?)/i
    SA_PROTOCOL_REGEX = /(ht|f)tp[s]?/i
    SA_TWEET_REGEX    = /(((^[@#])|([^a-z0-9\W]|\s)([@|#]))([a-z0-9\_]+))/i
  end
end