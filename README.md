## Placeholder.coffee

A sane cross-browser placeholder library that ditches positioning quirks.
Inspired by and behaves like Twitter's login fields.

Depends on Underscore and jQuery/Zepto.

### Use it

    <input type='email' placeholder='E-Mail Address' name='email'>
    
    ...
    
    Placholderize('input[type=email'])
    
    ...
    
    <div class='holding email'>
      <input type='email' placeholder='' name='email'>
      <span class='holder'>E-Mail Address</span>
    </div>
    


### License
Copyright (c) 2011 Austin Bales (austinbales.com)
Dual licensed under the MIT and GPL licenses.
