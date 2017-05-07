#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Adriano Barbosa'
SITENAME = u'Prof. Adriano Barbosa'
SITEURL = ''
EMAIL = 'adrianobarbosa@ufgd.edu.br'

PATH = 'content'

TIMEZONE = 'America/Campo_Grande'
DEFAULT_DATE = 'fs'

DEFAULT_LANG = u'en'

THEME = 'themes/strata'
THEME_STATIC_DIR = ''

STATIC_PATHS = ['images', 'papers', 'listas', 'aulas', 'arquivos']

SLUGIFY_SOURCE = 'basename'
ARTICLE_SAVE_AS = '{category}/{slug}.html'
ARTICLE_URL = '{category}/{slug}.html'

PLUGIN_PATHS = ['plugins']
PLUGINS = ['render_math']

AUTHOR_SAVE_AS = ''
TAG_SAVE_AS = ''
ARCHIVE_SAVE_AS = ''
DIRECT_TEMPLATES = ['index']

ARTICLES_ON_INDEX = 4

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Social widget
SOCIAL = (('feed', SITEURL + '/feeds/all.atom.xml'),
          ('github', 'http://github.com/barbosaaob'),
          ('email', 'mailto:' + EMAIL),)

DEFAULT_PAGINATION = False

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True
