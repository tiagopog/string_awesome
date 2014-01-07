module StringAwesome
  module AwesomeRegexes
    SA_REGEXES = {
      accent:   /[^\x00-\x7F]/n,
      url:      /\b((((ht|f)tp[s]?:\/\/)|([a-z0-9]+\.))+(?<!@)([a-z0-9\_\-]+)(\.[a-z]+)+([\?\/\:][a-z0-9_=%&@\?\.\/\-\:\#\(\)]+)?\/?)/i,
      protocol: /(ht|f)tp[s]?/i,
      tweet:    /(((^[@#])|([^a-z0-9\W]|\s)([@|#]))([a-z0-9\_]+))/i
    }
  end
end