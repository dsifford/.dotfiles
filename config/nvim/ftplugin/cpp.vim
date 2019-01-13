runtime ftplugin/c.vim

call timer_start(200, { tid -> execute('let b:ale_c_uncrustify_options = "-l CPP"', '') })
