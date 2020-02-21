#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Adriano Barbosa'
SITENAME = u'Prof. Adriano Barbosa'
SITEURL = ''
EMAIL = 'hi@adrianobarbosa.xyz'

PATH = 'content'

TIMEZONE = 'America/Campo_Grande'
DEFAULT_DATE = 'fs'

DEFAULT_LANG = u'en'

THEME = 'themes/strata'
THEME_STATIC_DIR = ''

STATIC_PATHS = ['images', 'papers', 'listas', 'aulas', 'arquivos', 'provas',
                'planos', 'static']

SLUGIFY_SOURCE = 'basename'
ARTICLE_SAVE_AS = '{category}/{slug}.html'
ARTICLE_URL = '{category}/{slug}.html'
TAGS_SAVE_AS = '{tag}/{slug}.html'

PLUGIN_PATHS = ['plugins']
PLUGINS = ['render_math']

AUTHOR_SAVE_AS = ''
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
SITEFACET = 'https://portal.ufgd.edu.br/faculdade/facet/index'
SITEUFGD = 'https://portal.ufgd.edu.br'
SITEUFAL = 'https://ufal.br'
SITEICMC = 'https://www.icmc.usp.br/'
SITEUSP = 'http://usp.br'
SITEIM = 'http://www.ufal.edu.br/unidadeacademica/im/pt-br'
SITETJ = 'http://www.tjal.jus.br/comunicacao2.php?pag=verNoticia&not=16361'
SITELED = '#'

DEFAULT_PAGINATION = False

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True
