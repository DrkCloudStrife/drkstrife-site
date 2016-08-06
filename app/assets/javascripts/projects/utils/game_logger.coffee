DrkStrife.utils.GameLog = (args, type='log')->
  return if window.debuggable isnt true or args is null
  args.join(' ') if Object.prototype.toString.call(args) is "[object Array]"

  console[type](args)
