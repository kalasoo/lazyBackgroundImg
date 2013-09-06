createUrlParser = (url) ->
  parser = document.createElement 'a'
  parser.href = url
  parser

$.responsiveWindowImage = () ->
  width = $(window).width()
  height = $(window).height()
  console.log width, height
  mobile = [640, 960]
  tablet = [1024, 768]
  laptop = [1600, 1200]
  if width <= mobile[0] and height <= mobile[1]
    console.log('mobile')
    mobile
  else if width <= tablet[0] and height <= tablet[1]
    console.log('tablet')
    tablet
  else
    console.log('laptop')
    laptop

$.cloudinaryOptimize = (url, options) ->
  parser = createUrlParser(url)
  return parser if parser.hostname isnt 'res.cloudinary.com'

  [width_limit, height_limit] = $.responsiveWindowImage()
  settings = 
    progressive: true
    width: width_limit
    height: height_limit
    quality: 70
  $.extend settings, options

  path_elements = parser.pathname.split('/')

  #change image type to jpg
  image_link = path_elements[5].split('.')
  image_link[1] = 'jpg' if image_link[1] isnt 'jpg'
  path_elements[5] = image_link.join('.')

  #change size and quality
  image_settings = ['c_limit', 'w_' + settings.width, 'h_' + settings.height, 'q_' + settings.quality]
  image_settings.push('fl_progressive') if settings.progressive
  path_elements[4] = image_settings.join(',')

  #merge
  parser.pathname = path_elements.join('/')
  parser.href