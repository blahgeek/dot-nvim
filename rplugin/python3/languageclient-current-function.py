#! /usr/bin/env python
# -*- coding: utf-8 -*-

import neovim
import json


@neovim.plugin
class LanguageClientCurrentFunction:

    CALLBACK_NAME = '_LanguageClient_CurrentFunction_callback'

    def __init__(self, vim):
        self.vim = vim

    @neovim.function(CALLBACK_NAME)
    def handleDocumentSymbol(self, result):
        if not result:
            return

        win = self.vim.current.window
        buf = win.buffer
        line, _ = win.cursor

        try:
            items = [(x['name'],
                      x['location']['range']['start']['line'] + 1,
                      x['location']['range']['end']['line'] + 1)
                     for x in result[0]['result']
                     # class, method, construction, interface, func, struct
                     if x.get('kind') in (5, 6, 9, 11, 12, 23, )
                     and x['location']['uri'] == 'file://' + buf.name]
        except:
            items = []
        items = sorted([x for x in items
                        if x[1] <= line <= x[2]],
                       key=lambda x: x[2] - x[1])
        buf.vars['languageclient_current_function'] = \
            '' if not items else items[0][0]
