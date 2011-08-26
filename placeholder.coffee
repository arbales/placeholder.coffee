#
# Placeholder.coffee
# Version 0.1
#
# A sane cross-browser placeholder library that ditches positioning quirks.
# Inspired by Twitter's login fields.
#
# Depends on Underscore and jQuery/Zepto.
#
# Copyright (c) 2011 Austin Bales (austinbales.com)
# Dual licensed under the MIT and GPL licenses.

root = exports ? this

#
# # Placeholderize
#
# Pass a selector, an Element, an array of Elements, or jQuery collection.

root.Placeholderize = (arg) ->
    if _(arg).isElement()
      transform(arg)
    else if _(arg).isArray()
      _(arg).each (el) ->
        transform(el)
    else
      $(arg).each (index, el) ->
        transform(el)

# Transforms an input elemt
transform = (element) ->
  el = $(element)

  # The element must have a placeholder property to continue.
  if (placeholder_text = el.prop('placeholder'))

    # Measure before manipulation.
    el_height = el.outerHeight(true)

    # Remove the property so it doesn't display.
    el.prop 'placeholder', ''

    # Wrap the input element in a div.
    el.wrap "<div class='holding'></div>"
    wrapper = el.parent().addClass(el.prop('type'))

    # Create the element we're gonna use. It's gonna be great.
    holder = ($ document.createElement('span'))
             .addClass('holder')
             .text(placeholder_text)

    # Maybe there's already stuff in there?
    if el.val() isnt ""
      holder.hide()

    # Add the holder to the wrapper and conduct measurements and sizing.
    wrapper.append holder
    offset = Math.ceil ((el_height - holder.outerHeight()) / 5)
    holder.css({top: "#{offset}px", left: "#{offset * 3}px", position: 'absolute'})

    delegateEvents()
    detectAutocompletedValues() # Remove Placeholders for autocompleted values.


delegateEvents = _.once ->

  ($ '.holding .holder').live 'click', (event) ->
    ($ event.currentTarget).siblings('input').focus()

  ($ '.holding input').live 'focus', (event) ->
    ($ event.currentTarget).parent().addClass('focus')

  ($ '.holding input').live 'change keyup blur', (event) ->
    toggleHolder(event.currentTarget)

  ($ '.holding input').live 'blur', (event) ->
    el = $ event.currentTarget
    el.parent().removeClass('focus')

# Chrome has a delay in autocompleting values, and doesn't seem
# to fire a change event, so this will clear the values after
# autocomplete happens. You'll notice this delay on Twitter, too.
detectAutocompletedValues = _.once ->
  setTimeout ->
    $('.holding input').each (index, raw_el) ->
      toggleHolder(raw_el)
  , 300

toggleHolder = (raw_el) ->
  el = $(raw_el)
  if el.val() isnt ""
    el.next('span.holder').fadeOut(100)
  else
    el.next('span.holder').fadeIn(100)