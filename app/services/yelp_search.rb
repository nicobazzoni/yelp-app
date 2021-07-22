class YelpSearch
    attr_reader :response, :businesses

    def initialize(location)
      url = "https://api.yelp.com/v3/businesses/search"
      params = {
        term: "museum",
        location: location,
        limit: 50
      }
  
      response = HTTP.auth("Bearer #{ENV["YELP_API_KEY"]}").get(url, params: params)
      @response = response.parse
      @businesses = @response["businesses"]
    end
  
    def to_museums
      museum_ids = self.businesses.map do |business|
        Museum.find_or_create_by(yelp_id: business["id"]) do |museum|
          museum.name = business["name"]
          museum.url = business["url"]
          museum.lat = business["coordinates"]["latitude"]
          museum.long = business["coordinates"]["longitude"]
          museum.image_url = business["image_url"]
          museum.address = business["location"]["display_address"].join(", ")
          museum.zip = business["location"]["zip"].to_i
          museum.kind_of_museum = business["categories"].map{|hash| hash["title"]}.join(", ")
        end.id
      end
      Museum.where(id: museum_ids)
    end
  
end