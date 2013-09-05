createUrlParser = (url) ->
  parser = document.createElement 'a'
  parser.href = url
  parser

$.responsiveImage = () ->
  [1600, 1200]

$.cloudinaryOptimize = (url, options) ->
  parser = createUrlParser(url)
  return parser if parser.hostname isnt 'res.cloudinary.com'

  [width_limit, height_limit] = $.responsiveImage()
  settings = 
    width: width_limit
    height: height_limit
    quality: 50
    blur: false
  $.extend settings, options

  path_elements = parser.pathname.split('/')

  #change image type to jpg
  image_link = path_elements[5].split('.')
  image_link[1] = 'jpg' if image_link[1] isnt 'jpg'
  path_elements[5] = image_link.join('.')

  #change size and quality
  image_settings = ['c_limit', 'w_' + settings.width, 'h_' + settings.height, 'q_' + settings.quality ]
  image_settings.push( 'e_blur') if settings.blur
  path_elements[4] = image_settings.join(',')

  #merge
  parser.pathname = path_elements.join('/')
  parser.href