
config.load_autoconfig()

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
