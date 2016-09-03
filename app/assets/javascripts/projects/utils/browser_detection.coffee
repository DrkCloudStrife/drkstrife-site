DrkStrife.utils.browserDetection = ->
  userAgent = window.navigator.userAgent

  @mobileDetector = (userAgent)->
    switch true
      when /Android/i.test(userAgent)
        # get Android version
        'Android'
      when /iPhone|iPad|iPod/i.test(userAgent)
        # get iOS version
        'iOS'
      when /BlackBerry/i.test(userAgent)
        'BlackBerry'
      when /IEMobile|Windows Phone/i.test(userAgent)
        'Windows Phone'


  # check for mobile devices
  if /Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Windows Phone/i.test(userAgent)
    return @mobileDetector(userAgent)

  # check for browser type
  if /opera|chrome|safari|firefox|msie/i.test(userAgent)
    return 'Web Browser'
