# Courtesy of Markus, converted to coffeescript by Eduardo Garibay (me)
# http://stackoverflow.com/questions/171251/how-can-i-merge-properties-of-two-javascript-objects-dynamically
DrkStrife.utils.extend = (object, extension)->
  for o of extension
    try
      if extension[o].constructor is Object
        object[o] = DrkStrife.utils.extend(object[o], extension[o])
      else
        object[o] = extension[o]
    catch e
      # When is unable to detect property it will just extend object
      object[o] = extension[o]

  object
