config.load_autoconfig()

# home page

config.set('url.default_page', 'https://www.dagensnamn.nu/')
config.set('url.start_pages', 'https://www.dagensnamn.nu/')

# search engines

config.set('url.searchengines', {
    "DEFAULT": "https://google.com/search?q={}",
    "ddg": "https://duckduckgo.com/?q={}",
    "g": "https://google.com/search?q={}",
    "y": "https://www.youtube.com/results?search_query={}",
})

# themes

config.set('colors.completion.category.bg', 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #3f4c6b, stop:1 #525252)')
config.set('colors.completion.even.bg', 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #333, stop:1 #444)')
config.set('colors.completion.odd.bg', '#484849')
config.set('fonts.default_family', 'Fira Code')
config.set('fonts.default_size', '9pt')
config.set('fonts.hints', 'default_size default_family')
config.set('colors.hints.bg', 'qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 rgba(58, 123, 213, 0.9), stop:1 rgba(58, 96, 115, 0.9))')
config.set('colors.hints.fg', 'white')
config.set('colors.hints.match.fg', '#e3be23')
config.set('colors.webpage.bg', 'black')
config.set('colors.webpage.darkmode.algorithm', 'lightness-cielab')
config.set('colors.webpage.darkmode.contrast', 0.0)
config.set('colors.webpage.darkmode.enabled', True)
config.set('colors.webpage.darkmode.grayscale.all', False)
config.set('colors.webpage.darkmode.grayscale.images', 0.0)
config.set('colors.webpage.darkmode.policy.images', 'smart')
config.set('colors.webpage.darkmode.policy.page', 'smart')
config.set('colors.webpage.darkmode.threshold.background', 70)
config.set('colors.webpage.prefers_color_scheme_dark', True)

# hints

default_selectors = config.get('hints.selectors')
config.set(
    'hints.selectors',
    {
        **default_selectors,
        'all': default_selectors['all'] + [
            # class-based buttons
            '.button',
            '.btn',

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
            '.dx-scrollable-container',
        ]
    }
)

# keybindings

config.bind(';c', 'hint scrollable')
config.bind('xx', 'config-cycle statusbar.show always never ;; config-cycle tabs.show always switching')
config.bind('xt', 'config-cycle tabs.show always switching')
config.bind('xb', 'config-cycle statusbar.show always never')
