config.load_autoconfig(False)

c.tabs.position = "left"

c.colors.tabs.bar.bg = "#000000"

c.url.start_pages = [ "https://www.google.com/" ]
c.url.searchengines = {
    "DEFAULT":  "https://www.google.com/search?q={}",
    "!yt":      "https://www.youtube.com/results?search_query={}",
    "!p":       "https://www.perplexity.ai/search?focus=internet&q={}",
}
