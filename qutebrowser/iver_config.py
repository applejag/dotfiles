import os

with open(os.path.dirname(__file__)+'/base_config.py') as f:
    exec(f.read())

# home page

config.set('url.default_page', 'https://cure.dgc.local/')
config.set('url.start_pages', 'https://iverab.sharepoint.com/')

# search engines

config.set('url.searchengines', {
    #"DEFAULT": "http://localhost:8090/yacysearch.html?query={}+%2Flanguage%2Fen",
    #"DEFAULT": "https://duckduckgo.com/?q={}",
    "DEFAULT": "https://search.brave.com/search?q={}",
    "b": "https://search.brave.com/search?q={}",
    "x": "https://searx.prvcy.eu/search?q={}&categories=general&language=en-US",
    "c": "https://cure.dgc.local/#/nav/requests/?q={}",
    "cr": "https://cure.dgc.local/#/{}",
    "ddg": "https://duckduckgo.com/?q={}",
    "g": "https://google.com/search?q={}",
    "gl": "https://gitlab.dgc.local/search?utf8=%E2%9C%93&search={}&search_code=true",
    "spr": "https://techtfs01.develop.local/DefaultCollection/_git/Iver.Spark/pullrequest/{}?_a=overview",
    "s": "https://spark.iver.com/tickets/detail/{}",
    "ss": "https://spark.atlas.dgc.local/tickets/detail/{}",
    "y": "https://www.youtube.com/results?search_query={}",
    "yacy": "http://localhost:8090/yacysearch.html?query={}+%2Flanguage%2Fen",
    "def": "https://www.merriam-webster.com/dictionary/{}",
    "go": "https://pkg.go.dev/search?q={}",
})
