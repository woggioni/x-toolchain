project('libexecinfo', 'c',
        default_options : ['c_std=c99'])
execinfo = declare_dependency(
    link_with : library('execinfo',
                        ['stacktraverse.c', 'execinfo.c'],
                        include_directories : include_directories('.'),
                        install : true),
    include_directories : include_directories('.'))
install_headers(['execinfo.h', 'stacktraverse.h'])