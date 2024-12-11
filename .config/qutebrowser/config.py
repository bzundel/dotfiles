config.load_autoconfig(False)

c.tabs.position = "left"

c.url.searchengines = {
    "DEFAULT":  "https://www.google.com/search?q={}",
    "!yt":      "https://www.youtube.com/results?search_query={}",
    "!p":       "https://www.perplexity.ai/search?focus=internet&q={}",
}
