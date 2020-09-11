
config.load_autoconfig()

# home page

config.set('url.default_page', 'https://cure.dgc.local/')
config.set('url.start_pages', 'https://cure.dgc.local/')

# search engines

config.set('url.searchengines', {
    "DEFAULT": "https://google.com/search?q={}",
    "c": "https://cure.dgc.local/#/nav/requests/?q={}",
    "cr": "https://cure.dgc.local/#/{}",
    "ddg": "https://duckduckgo.com/?q={}", 
    "g": "https://google.com/search?q={}",
    "gl": "https://gitlab.dgc.local/search?utf8=%E2%9C%93&search={}&search_code=true",
    "spr": "https://techtfs01.develop.local/DefaultCollection/_git/Iver.Spark/pullrequest/{}?_a=overview",
    "st": "https://spark.iver.com/tickets/detail/{}",
    "y": "https://www.youtube.com/results?search_query={}",
})

# themes

config.set('colors.completion.category.bg', 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #3f4c6b, stop:1 #525252)')
config.set('colors.completion.even.bg', 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #333, stop:1 #444)')
config.set('colors.completion.odd.bg', '#484849')
config.set('font.default_family', 'Fira Code')
config.set('font.default_size', '9pt')
config.set('font.hints', 'default_size default_family')
config.set('colors.hints.bg', 'qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 rgba(58, 123, 213, 0.9), stop:1 rgba(58, 96, 115, 0.9))')
config.set('colors.hints.fg', 'white')
config.set('colors.hints.match.fg', '#e3be23')
config.set('colors.webpage.bg', 'black')
config.set('colors.webpage.darkmode.algorithm', 'lightness-cielab')
config.set('colors.webpage.darkmode.contrast', 0.0)
config.set('colors.webpage.darkmode.enabled', True)
config.set('colors.webpage.darkmode.grayscale.all', False)
config.set('colors.webpage.darkmode.grayscale.images', 0.0)
config.set('colors.webpage.darkmode.policy.images', 'never')
config.set('colors.webpage.darkmode.policy.page', 'smart')
config.set('colors.webpage.darkmode.threshold.background', 70)
config.set('colors.webpage.darkmode.prefers_color_scheme_dark', True)

# hints

default_selectors = config.get('hints.selectors')
config.set(
    'hints.selectors',
    {
        **default_selectors,
        'all': default_selectors['all'] + [

            # spark
            '[role="treeitem"]',
            '[role="tab"]',
            '.expand-container-btn',
            '.open-drawer-btn',

            # azure devops
            '.vc-sparse-files-tree',
            '.v-scroll-auto',

            # swagger
            '.download-contents',
        ],
        'scrollable': [
            'body',
            '.user-card-container',
            '.tab-content-wrapper',
        ]
    }
)

config.bind(';c', 'hint scrollable')
