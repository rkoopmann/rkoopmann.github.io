---
layout: post
title: resolve Function
category: sas
tags:
- function
- sas
link: http://kansascode.blogspot.com/2012/07/dynamic-macro-call-/blogusing-resolve.html
---

Stumbled across a [nice post](http://kansascode.blogspot.com/2012/07/dynamic-macro-call-using-resolve.html) on dynamic macro call using the `RESOLVE()` function.

<!--more-->

    data rowcounts ;
      length name $16
             rows   8 ;
      array aname(2, 2) $16 _temporary_
        (
            'sashelp.cars', 'Cars Rows'
          , 'sashelp.class', 'Class Rows'
        ) ;
      do _n_ = 1 to dim( aname ) ;
        name = aname(_n_, 2) ;
        rows = resolve( cats('%dsnobs( dsn =', aname(_n_, 1), ')' ) ) ;
        output ;
      end ;
    run ;
