#!/usr/bin/env python
# -*- encoding: utf8 -*-

from os import path


CXX_SUFFIXS = ('.cpp', '.hpp', '.cc', '.cxx')


def FlagsForFile(filename, **kwargs):
    client_data = kwargs.get('client_data', {})
    if any(map(lambda x: filename.endswith(x), CXX_SUFFIXS)):
        flags = ['-x', 'c++']
        flags += client_data.get('g:common_cxx_flags', [])
    else:
        flags = ['-x', 'c']
        flags += client_data.get('g:common_c_flags', [])

    return {
        'flags': flags
    }
