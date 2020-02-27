# require 'rest-client'
# require 'json'

# def search_businesses_from_yelp(times)
#   token = ENV['YELP_API_KEY']
#   yelp_ep = 'https://api.yelp.com/v3/businesses/search'
#   params = { 
#       latitude: 36.108722,
#       longitude: 140.103961, #筑波大学
#       radius: 8000,
#       limit: 50,
#       open_now: true,
#       price: 1
#   } 

#   response = RestClient.get yelp_ep, { :Authorization => "bearer #{token}", params: params }
#   response_json = JSON.parse(response)
#   response_json['businesses'].sample(times <= 10 ? times : 10) #最大10件
# end

# def get_random_meshi(num)
#   results = []
#   businesses = search_businesses_from_yelp(num)

#   businesses.each do |business|
#     results.push(
#       {
#         "thumbnailImageUrl": business['image_url'],
#         "imageBackgroundColor": "#FFFFFF",
#         "title": business['id'],
#         "text": "評価 #{business['rating']}",
#         "actions": [
#             {
#                 "type": "uri",
#                 "label": "詳細をみる",
#                 "uri": business['url']
#             }
#         ]
#       }
#     )  
#   end

#   {
#    "type": "template",
#    "altText": "ガチャ結果",
#    "template": {
#       "type": "carousel",
#       "columns": results,
#       "imageAspectRatio": "rectangle",
#       "imageSize": "cover"
#     }
#   } 
# end