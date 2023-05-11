setlocal isfname+=@-@
setlocal includeexpr=substitute(v:fname,'^@\/','src/','')
