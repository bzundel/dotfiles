config.load_autoconfig(False)

c.tabs.position = "left"

c.colors.tabs.bar.bg = "#000000"

c.url.start_pages = [ "https://duckduckgo.com/" ]
c.url.searchengines = {
    "DEFAULT":      "https://duckduckgo.com/?q={}",
    "!p":           "https://www.perplexity.ai/search?focus=internet&q={}",
    "!gentoopkg":   "https://packages.gentoo.org/packages/search?q={}"
}

config.bind("<Ctrl+m>", "hint links spawn mpv {hint-url}")
