//
//  Datafiles.swift
//  bigfantv
//
//  Created by Ganesh on 10/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import Foundation
class LanguageData: Codable {
    let code: Int
    let status,default_lang : String
    var Languagelist: [Languagelist]
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case default_lang = "default_lang"
        case Languagelist = "lang_list"
    }
    
    init(code: Int, status: String, default_lang: String, Languagelist: [Languagelist]) {
        self.code = code
        self.status = status
        self.default_lang = default_lang
        self.Languagelist = Languagelist
    }
}

// MARK: - MeetingOrganizationList
class Languagelist: Codable {
    let code, language: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case language = "language"
    }
    
    init(code: String, language: String) {
        self.code = code
        self.language = language
    }
}


class FireBaseData: Codable {
    
    let country,default_station : String
    var Languagelist: [Languagearraylist]
    
    enum CodingKeys: String, CodingKey {
        
        case country = "country"
        case default_station = "default_station"
        case Languagelist = "Languagelist"
    }
    
    init( country: String, default_station: String, Languagelist: [Languagearraylist]) {
        self.country = country
        self.default_station = default_station
        self.Languagelist = Languagelist
    }
}

// MARK: - MeetingOrganizationList
class Languagearraylist: Codable {
    let code, language: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case language = "language"
    }
    
    init(code: String, language: String) {
        self.code = code
        self.language = language
    }
}




class ComedyMovieList: Codable {
 
    let isFollowed,status,result_type :Int?
    let category_id,msg,orderby,item_count,limit,menu_title:String?
    var subComedymovList:[SubComedymovieList]
    
     enum CodingKeys: String, CodingKey {
        
        case isFollowed = "isFollowed"
        case status = "status"
        case result_type = "result_type"
        case category_id = "category_id"
        case msg = "msg"
        case orderby = "orderby"
        case item_count = "item_count"
        case limit = "limit"
        case menu_title = "menu_title"
        case subComedymovList = "movieList"
     
    }
    
    init(isFollowed :Int?,status:Int?,result_type:Int? ,category_id:String? ,msg:String?,orderby:String? ,item_count:String?,limit:String?,menu_title:String? ,subComedymovList:[SubComedymovieList] ) {
        self.isFollowed = isFollowed
        self.status = status
        self.result_type = result_type
        self.category_id = category_id
        self.msg = msg
        self.orderby = orderby
        self.item_count = item_count
        self.limit = limit
        self.menu_title = menu_title
        self.subComedymovList = subComedymovList
        
    }
    
    
    
}
class SubComedymovieList: Codable {
   
    /*
                   "movie_stream_uniq_id": "92dc179577a750d7783cebfa0e1cf7c6",
                         "movie_id": "230603",
                         "content_publish_date": "",
                         "movie_stream_id": "445026",
                         "is_episode": 0,
                         "muvi_uniq_id": "becacd3179f0f034bdbfb8c456a0b5ee",
                         "content_type_id": "",
                         "ppv_plan_id": "0",
                         "permalink": "bean-thanksgiving-mr-bean-full-episodes",
                         "name": "Bean THANKSGIVING   Mr Bean Full Episodes",
                         "full_movie": "Nandish_comedy_1.mp4",
                         
                         "genre": [],
                         "release_date": "",
                         "content_types_id": "1",
                         "is_converted": "1",
                         "last_updated_date": "2020-04-17 04:42:35",
                         "content_language": "",
                         "censor_rating": "",
                         "is_downloadable": "0",
                         "custom1": "[\"English\"]",
                         "custom2": "https://www.youtube.com/watch?v=p3doE9b2ZVs&t=937s",
                         "custom3": "",
                         "custom4": "",
                         "custom5": "",
                         "custom6": "",
                         "custom7": "",
                         "custom8": "",
                         "custom9": "",
                         "custom10": "",
                         "movieid": "",
                         "geocategory_id": "",
                         "studio_id": "",
                         "category_id": "",
                         "country_code": "",
                         "ip": "",
                         "poster_url": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401983/thumb/c1_1587098555.jpg",
                         "is_favorite": 0,
                         "isFreeContent": 0,
                         "embeddedUrl": "https://bigfantv.com/embed/92dc179577a750d7783cebfa0e1cf7c6",
                         "posterForTv": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401984/original/c2.jpg",
                         "poster_url_for_tv": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401984/original/c2.jpg",
                         "viewStatus": {
                             "viewcount": "0",
                             "uniq_view_count": "0"
                         },
                         "custom_meta_data": {
                             "youtube_source": "https://www.youtube.com/watch?v=p3doE9b2ZVs&t=937s",
                             "language_type": "English",
                             "movie_name": "",
                             "original_artist": "https://www.youtube.com/watch?v=p3doE9b2ZVs&t=937s",
                             "cover_artist": "English"
                         },
                         "allposters": {
                             "original": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401983/original/c1_1587098555.jpg",
                             "standard": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401983/standard/c1_1587098555.jpg",
                             "thumb": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401983/thumb/c1_1587098555.jpg"
                         }
     */
       let movie_stream_uniq_id:String?
       let movie_id:String?
       let content_publish_date:String?
       let movie_stream_id:String?
       let is_episode:Int?
       let muvi_uniq_id:String?
       let content_type_id:String?
       let ppv_plan_id:String?
       let permalink:String?
       let name:String?
       let full_movie:String?
       let story:String?
       let release_date:String?
       let content_types_id:String?
       let is_converted:String?
       let last_updated_date:String?
        let content_language:String?
        let censor_rating:String?
        let is_downloadable:String?
        let movieid:String?
        let geocategory_id:String?
        let studio_id:String?
        let category_id:String?
        let poster_url:String?
        let is_favorite:Int?
        let isFreeContent:Int?
        let embeddedUrl:String?
        let posterForTv:String?
        let poster_url_for_tv:String?
        let viewStatus:ComedyViewstatus?
        let Custommetadata:ComedyCustommetadata?
        let ComedyPoster:ComedyMovPosters?
//29
    // shippingRate = "0.00";
        //       taxRate = "0.00";
       enum CodingKeys: String, CodingKey {
           case movie_stream_uniq_id = "movie_stream_uniq_id"
           case movie_id = "movie_id"
           case content_publish_date = "content_publish_date"
           case movie_stream_id = "movie_stream_id"
           case is_episode = "is_episode"
           case muvi_uniq_id = "CategoryId"
        
           case content_type_id = "content_type_id"
           case ppv_plan_id = "ppv_plan_id"
           case permalink = "permalink"
           case name = "name"
           case full_movie = "full_movie"
           case story = "story"
           case release_date = "release_date"
           case content_types_id = "content_types_id"
       
           case is_converted = "is_converted"
           case last_updated_date = "last_updated_date"
           case content_language = "content_language"
           case censor_rating = "censor_rating"
           case is_downloadable = "is_downloadable"
           case movieid = "movieid"
           case geocategory_id = "geocategory_id"
           case studio_id = "studio_id"
        
           case category_id = "category_id"
           case poster_url = "poster_url"
           case is_favorite = "is_favorite"
           case isFreeContent = "isFreeContent"
           case embeddedUrl = "embeddedUrl"
           case posterForTv = "posterForTv"
           case poster_url_for_tv = "poster_url_for_tv"
           case viewStatus = "viewStatus"
           case Custommetadata = "custom_meta_data"
           case ComedyPoster = "allposters"
           
        
       }
       init(movie_stream_uniq_id:String?,
            movie_id:String?,
            content_publish_date:String?,
            movie_stream_id:String?,
            is_episode:Int?,
            muvi_uniq_id:String?,
            content_type_id:String?,
            ppv_plan_id:String?,
            permalink:String?,
            name:String?,
            full_movie:String?,
            story:String?,
            release_date:String?,
            content_types_id:String?,
            is_converted:String?,
            last_updated_date:String?,
            content_language:String?,
            censor_rating:String?,
            is_downloadable:String?,
            movieid:String?,
            geocategory_id:String?,
            studio_id:String?,
            category_id:String?,
            poster_url:String?,
            is_favorite:Int?,
             isFreeContent:Int?,
             embeddedUrl:String?,
             posterForTv:String?,
             poster_url_for_tv:String?,
             viewStatus:ComedyViewstatus?,
             Custommetadata:ComedyCustommetadata?,
             ComedyPoster:ComedyMovPosters?
       )
       {
           
           self.movie_stream_uniq_id = movie_stream_uniq_id
           self.movie_id = movie_id
           self.content_publish_date = content_publish_date
           self.movie_stream_id = movie_stream_id
           self.is_episode = is_episode
           self.muvi_uniq_id = muvi_uniq_id
           self.content_type_id = content_type_id
           self.ppv_plan_id = ppv_plan_id
           self.permalink = permalink
           self.name = name
           self.full_movie = full_movie
           self.story = story
           self.release_date = release_date
           self.content_types_id = content_types_id
           self.is_converted = is_converted
           self.last_updated_date = last_updated_date
           self.content_language = content_language
           self.censor_rating = censor_rating
           self.is_downloadable = is_downloadable
           self.movieid = movieid
           self.geocategory_id = geocategory_id
           self.studio_id = studio_id
           self.category_id = category_id
           self.poster_url = poster_url
           self.is_favorite = is_favorite
           self.isFreeContent = isFreeContent
           self.embeddedUrl = embeddedUrl
           self.posterForTv = posterForTv
           self.poster_url_for_tv = poster_url_for_tv
           self.viewStatus = viewStatus
           self.Custommetadata = Custommetadata
           self.ComedyPoster = ComedyPoster
       }
}
class ComedyViewstatus: Codable {
    let viewcount, uniq_view_count: String?
   
    enum CodingKeys: String, CodingKey {
        case viewcount = "viewcount"
        case uniq_view_count = "uniq_view_count"
    }
    
    init(viewcount: String?, uniq_view_count: String?) {
        self.viewcount = viewcount
        self.uniq_view_count = uniq_view_count
    }
}
 
class ComedyCustommetadata: Codable {
    let youtube_source, language_type,movie_name, original_artist,cover_artist : String?
   
    enum CodingKeys: String, CodingKey {
        case youtube_source = "youtube_source"
        case language_type = "language_type"
        case movie_name = "movie_name"
        case original_artist = "original_artist"
        case cover_artist = "cover_artist"
         
    }
    
    init(youtube_source: String?, language_type: String?,movie_name: String?, original_artist: String?,cover_artist: String? ) {
        self.youtube_source = youtube_source
        self.language_type = language_type
        self.movie_name = movie_name
        self.original_artist = original_artist
        self.cover_artist = cover_artist
       
    }
}
 
class ComedyMovPosters: Codable {
    let original, standard,thumb: String?
   
    enum CodingKeys: String, CodingKey {
        case original = "original"
        case standard = "standard"
        case thumb = "thumb"
    }
    
    init(original: String?, standard: String?, thumb: String?) {
        self.original = original
        self.standard = standard
        self.thumb = thumb
    }
}



class LiveTVList: Codable {
 
    let isFollowed,status,result_type :Int?
    let category_id,msg,orderby,item_count,limit,menu_title:String?
    var subComedymovList:[SubComedymovieList]
    
     enum CodingKeys: String, CodingKey {
        
        case isFollowed = "isFollowed"
        case status = "status"
        case result_type = "result_type"
        case category_id = "category_id"
        case msg = "msg"
        case orderby = "orderby"
        case item_count = "item_count"
        case limit = "limit"
        case menu_title = "menu_title"
        case subComedymovList = "movieList"
     
    }
    
    init(isFollowed :Int?,status:Int?,result_type:Int? ,category_id:String? ,msg:String?,orderby:String? ,item_count:String?,limit:String?,menu_title:String? ,subComedymovList:[SubComedymovieList] ) {
        self.isFollowed = isFollowed
        self.status = status
        self.result_type = result_type
        self.category_id = category_id
        self.msg = msg
        self.orderby = orderby
        self.item_count = item_count
        self.limit = limit
        self.menu_title = menu_title
        self.subComedymovList = subComedymovList
        
    }
    
    
    
}
class SubLiveTVList: Codable {
   
    /*
                   "movie_stream_uniq_id": "92dc179577a750d7783cebfa0e1cf7c6",
                         "movie_id": "230603",
                         "content_publish_date": "",
                         "movie_stream_id": "445026",
                         "is_episode": 0,
                         "muvi_uniq_id": "becacd3179f0f034bdbfb8c456a0b5ee",
                         "content_type_id": "",
                         "ppv_plan_id": "0",
                         "permalink": "bean-thanksgiving-mr-bean-full-episodes",
                         "name": "Bean THANKSGIVING   Mr Bean Full Episodes",
                         "full_movie": "Nandish_comedy_1.mp4",
                         
                         "genre": [],
                         "release_date": "",
                         "content_types_id": "1",
                         "is_converted": "1",
                         "last_updated_date": "2020-04-17 04:42:35",
                         "content_language": "",
                         "censor_rating": "",
                         "is_downloadable": "0",
                         "custom1": "[\"English\"]",
                         "custom2": "https://www.youtube.com/watch?v=p3doE9b2ZVs&t=937s",
                         "custom3": "",
                         "custom4": "",
                         "custom5": "",
                         "custom6": "",
                         "custom7": "",
                         "custom8": "",
                         "custom9": "",
                         "custom10": "",
                         "movieid": "",
                         "geocategory_id": "",
                         "studio_id": "",
                         "category_id": "",
                         "country_code": "",
                         "ip": "",
                         "poster_url": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401983/thumb/c1_1587098555.jpg",
                         "is_favorite": 0,
                         "isFreeContent": 0,
                         "embeddedUrl": "https://bigfantv.com/embed/92dc179577a750d7783cebfa0e1cf7c6",
                         "posterForTv": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401984/original/c2.jpg",
                         "poster_url_for_tv": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401984/original/c2.jpg",
                         "viewStatus": {
                             "viewcount": "0",
                             "uniq_view_count": "0"
                         },
                         "custom_meta_data": {
                             "youtube_source": "https://www.youtube.com/watch?v=p3doE9b2ZVs&t=937s",
                             "language_type": "English",
                             "movie_name": "",
                             "original_artist": "https://www.youtube.com/watch?v=p3doE9b2ZVs&t=937s",
                             "cover_artist": "English"
                         },
                         "allposters": {
                             "original": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401983/original/c1_1587098555.jpg",
                             "standard": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401983/standard/c1_1587098555.jpg",
                             "thumb": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/401983/thumb/c1_1587098555.jpg"
                         }
     */
       let movie_stream_uniq_id:String?
       let movie_id:String?
       let content_publish_date:String?
       let movie_stream_id:String?
       let is_episode:Int?
       let muvi_uniq_id:String?
       let content_type_id:String?
       let ppv_plan_id:String?
       let permalink:String?
       let name:String?
       let full_movie:String?
       let story:String?
       let release_date:String?
       let content_types_id:String?
       let is_converted:String?
       let last_updated_date:String?
        let content_language:String?
        let censor_rating:String?
        let is_downloadable:String?
        let movieid:String?
        let geocategory_id:String?
        let studio_id:String?
        let category_id:String?
        let poster_url:String?
        let is_favorite:Int?
        let isFreeContent:Int?
        let embeddedUrl:String?
        let posterForTv:String?
        let poster_url_for_tv:String?
        let viewStatus:ComedyViewstatus?
        let Custommetadata:ComedyCustommetadata?
        let ComedyPoster:ComedyMovPosters?
//29
    // shippingRate = "0.00";
        //       taxRate = "0.00";
       enum CodingKeys: String, CodingKey {
           case movie_stream_uniq_id = "movie_stream_uniq_id"
           case movie_id = "movie_id"
           case content_publish_date = "content_publish_date"
           case movie_stream_id = "movie_stream_id"
           case is_episode = "is_episode"
           case muvi_uniq_id = "CategoryId"
        
           case content_type_id = "content_type_id"
           case ppv_plan_id = "ppv_plan_id"
           case permalink = "permalink"
           case name = "name"
           case full_movie = "full_movie"
           case story = "story"
           case release_date = "release_date"
           case content_types_id = "content_types_id"
       
           case is_converted = "is_converted"
           case last_updated_date = "last_updated_date"
           case content_language = "content_language"
           case censor_rating = "censor_rating"
           case is_downloadable = "is_downloadable"
           case movieid = "movieid"
           case geocategory_id = "geocategory_id"
           case studio_id = "studio_id"
        
           case category_id = "category_id"
           case poster_url = "poster_url"
           case is_favorite = "is_favorite"
           case isFreeContent = "isFreeContent"
           case embeddedUrl = "embeddedUrl"
           case posterForTv = "posterForTv"
           case poster_url_for_tv = "poster_url_for_tv"
           case viewStatus = "viewStatus"
           case Custommetadata = "custom_meta_data"
           case ComedyPoster = "allposters"
           
        
       }
       init(movie_stream_uniq_id:String?,
            movie_id:String?,
            content_publish_date:String?,
            movie_stream_id:String?,
            is_episode:Int?,
            muvi_uniq_id:String?,
            content_type_id:String?,
            ppv_plan_id:String?,
            permalink:String?,
            name:String?,
            full_movie:String?,
            story:String?,
            release_date:String?,
            content_types_id:String?,
            is_converted:String?,
            last_updated_date:String?,
            content_language:String?,
            censor_rating:String?,
            is_downloadable:String?,
            movieid:String?,
            geocategory_id:String?,
            studio_id:String?,
            category_id:String?,
            poster_url:String?,
            is_favorite:Int?,
             isFreeContent:Int?,
             embeddedUrl:String?,
             posterForTv:String?,
             poster_url_for_tv:String?,
             viewStatus:ComedyViewstatus?,
             Custommetadata:ComedyCustommetadata?,
             ComedyPoster:ComedyMovPosters?
       )
       {
           
           self.movie_stream_uniq_id = movie_stream_uniq_id
           self.movie_id = movie_id
           self.content_publish_date = content_publish_date
           self.movie_stream_id = movie_stream_id
           self.is_episode = is_episode
           self.muvi_uniq_id = muvi_uniq_id
           self.content_type_id = content_type_id
           self.ppv_plan_id = ppv_plan_id
           self.permalink = permalink
           self.name = name
           self.full_movie = full_movie
           self.story = story
           self.release_date = release_date
           self.content_types_id = content_types_id
           self.is_converted = is_converted
           self.last_updated_date = last_updated_date
           self.content_language = content_language
           self.censor_rating = censor_rating
           self.is_downloadable = is_downloadable
           self.movieid = movieid
           self.geocategory_id = geocategory_id
           self.studio_id = studio_id
           self.category_id = category_id
           self.poster_url = poster_url
           self.is_favorite = is_favorite
           self.isFreeContent = isFreeContent
           self.embeddedUrl = embeddedUrl
           self.posterForTv = posterForTv
           self.poster_url_for_tv = poster_url_for_tv
           self.viewStatus = viewStatus
           self.Custommetadata = Custommetadata
           self.ComedyPoster = ComedyPoster
       }
}
class LiveTVViewstatus: Codable {
    let viewcount, uniq_view_count: String?
   
    enum CodingKeys: String, CodingKey {
        case viewcount = "viewcount"
        case uniq_view_count = "uniq_view_count"
    }
    
    init(viewcount: String?, uniq_view_count: String?) {
        self.viewcount = viewcount
        self.uniq_view_count = uniq_view_count
    }
}
 
class LiveTVCustommetadata: Codable {
    let youtube_source, language_type,movie_name, original_artist,cover_artist : String?
   
    enum CodingKeys: String, CodingKey {
        case youtube_source = "youtube_source"
        case language_type = "language_type"
        case movie_name = "movie_name"
        case original_artist = "original_artist"
        case cover_artist = "cover_artist"
         
    }
    
    init(youtube_source: String?, language_type: String?,movie_name: String?, original_artist: String?,cover_artist: String? ) {
        self.youtube_source = youtube_source
        self.language_type = language_type
        self.movie_name = movie_name
        self.original_artist = original_artist
        self.cover_artist = cover_artist
       
    }
}
 
class LiveTVPosters: Codable {
    let original, standard,thumb: String?
   
    enum CodingKeys: String, CodingKey {
        case original = "original"
        case standard = "standard"
        case thumb = "thumb"
    }
    
    init(original: String?, standard: String?, thumb: String?) {
        self.original = original
        self.standard = standard
        self.thumb = thumb
    }
}


/*
 {
     "code": 200,
     "status": "OK",
     "lists": [
         {
             "movie_id": "281753",
             "content_category_value": "68182",
             "content_subcategory_value": null,
             "is_episode": "0",
             "episode_number": 0,
             "season_number": 0,
             "title": " | Dheem Tharikid Thom malyalam  Movie",
             "parent_content_title": "",
             "content_details": null,
             "content_title": " | Dheem Tharikid Thom malyalam  Movie",
             "play_btn": "<a href=\"javascript:void(0);\" data-toggle=\"modal\" data-content_title=\" | Dheem Tharikid Thom malyalam  Movie\" data-chk_register=\"\" data-api_available=\"\" data-target=\"#loginModal\" data-backdrop=\"static\" data-purchase_type=\"\"  data-movie_id=\"76503460e1c76c028c31bdccd97f2661\" data-content-permalink=\"malayalam-super-hit-comedy-full-movie-malayalam-comedy-full-movie-dheem-tharikid-thom-full-movie\" data-stream_id=\"0\" data-isppv=\"1\" data-is_ppv_bundle=\"0\" data-name=\" | Dheem Tharikid Thom malyalam  Movie\" data-ctype=\"1\" class=\"playbtn\">Play Now</a><input type=\"hidden\" name=\"permalink\" id=\"permalink\" value=\"malayalam-super-hit-comedy-full-movie-malayalam-comedy-full-movie-dheem-tharikid-thom-full-movie\" /><input type=\"hidden\" name=\"content_name\" id=\"content_name\" value=\" | Dheem Tharikid Thom malyalam  Movie\" />",
             "buy_btn": "",
             "permalink": "https://bigfantv.com/en/malayalam-super-hit-comedy-full-movie-malayalam-comedy-full-movie-dheem-tharikid-thom-full-movie",
             "c_permalink": "malayalam-super-hit-comedy-full-movie-malayalam-comedy-full-movie-dheem-tharikid-thom-full-movie",
             "poster": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/510794/standard/Webp.net-resizeimage--2-_1595062123.jpg",
             "data_type": 0,
             "is_landscape": 0,
             "release_date": "",
             "full_release_date": "",
             "censor_rating": null,
             "movie_uniq_id": "76503460e1c76c028c31bdccd97f2661",
             "stream_uniq_id": 0,
             "video_duration": "02:18:33",
             "watch_duration": null,
             "video_duration_text": "2hr18m33s",
             "video_duration_in_seconds": 8313,
             "watch_duration_in_seconds": 0,
             "ppv": null,
             "payment_type": 0,
             "is_converted": "1",
             "movie_stream_id": "509957",
             "uniq_id": "76503460e1c76c028c31bdccd97f2661",
             "content_type_id": null,
             "content_types_id": "1",
             "ppv_plan_id": "0",
             "full_movie": "nakib102.mp4",
             "story": "",
             "short_story": "",
             "genres": null,
             "display_name": "",
             "content_permalink": null,
             "trailer_url": "",
             "trailer_is_converted": "",
             "trailer_player": null,
             "casts": null,
             "casting": null,
             "content_banner": "",
             "reviewformonly": "<div class=\"submit-review\"><p>You need to login to add your review. <a href=\"#\" data-toggle=\"modal\" data-target=\"#loginModal\">Click here</a> to login.</p></div>",
             "reviewsummary": "<div id=\"review_summary\"><input type=\"hidden\" class=\"rating\" data-readonly value=\"0\" />&nbsp;&nbsp;<span class=\"ratingcolorred\">0 out of 5 stars</span></div>",
             "reviews": "[]",
             "myreview": null,
             "defaultResolution": 144,
             "multipleVideo": [],
             "start_time": "0000-00-00 00:00:00",
             "duration": "",
             "custom": {
                 "language_type": {
                     "field_display_name": "Language Type",
                     "field_value": "Malyalam"
                 },
                 "youtube_source": {
                     "field_display_name": "Youtube Source",
                     "field_value": "https://www.youtube.com/watch?v=CgceVbZ9d_s"
                 }
             },
             "is_downloadable": "0",
             "download_btn": null,
             "content_language": null,
             "is_fav_status": 0,
             "custom_meta_data": {
                 "language_type": [
                     "Malyalam"
                 ],
                 "youtube_source": "https://www.youtube.com/watch?v=CgceVbZ9d_s"
             },
             "movie_stream_uniq_id": "15578c3dc808c5372883c984bf47b453",
             "name": " | Dheem Tharikid Thom malyalam  Movie",
             "content_form_id": "109479",
             "gateway_code": null,
             "parent_theme": "revo",
             "resume_play_btn": "",
             "is_free_login": 0,
             "show_playbtn": 1,
             "publish_status": "0",
             "publish_date": null,
             "publish_end_date": null,
             "ppv_subscribed_price": "$0.00",
             "ppv_unsubscribed_price": "$0.00",
             "ppv_unsubscribed_text": "free",
             "ppv_subscribed_text": "free",
             "booking_status": 0,
             "show_booking_button": 1,
             "booking_time": "",
             "posterForTv": "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/510795/standard/Webp.net-resizeimage--2-.jpg",
             "language_type": {
                 "field_display_name": "Language Type",
                 "field_value": "Malyalam"
             },
             "youtube_source": {
                 "field_display_name": "Youtube Source",
                 "field_value": "https://www.youtube.com/watch?v=CgceVbZ9d_s"
             },
             "played_count": "0",
             "like_count": 0,
             "category_list": [
                 {
                     "id": "68182",
                     "category_name": "Movies",
                     "category_desc": "",
                     "permalink": "movies"
                 }
             ]
         }
     ],
     "total_content": "317"
 }
 */
//filtered list

//1.comedy

/*
class FilteredComedyMovieList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[FilteredSubComedymovieList]
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[FilteredSubComedymovieList] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
        
    }
    
    
    
}
class FilteredSubComedymovieList: Codable {
             
     
       let movie_id:String?
       let content_category_value:String?
       let content_subcategory_value:String?
       let is_episode:String?
       let episode_number:Int?
       let season_number:Int?
       let title:String?
       let parent_content_title:String?
       let content_details:String?
    
       let content_title:String?
       let play_btn:String?
       let buy_btn:String?
       let permalink:String?
       let c_permalink:String?
       let poster:String?
       let data_type:Int?
       let is_landscape:Int?
       let release_date:String?
       let full_release_date:String?
       let censor_rating:String?
       let movie_uniq_id:String?
       let stream_uniq_id:Int?
       let video_duration:String?
       let watch_duration:String?
       let video_duration_text:String?
       let video_duration_in_seconds:Int?
       let watch_duration_in_seconds:Int?
       let ppv:String?
       let payment_type:Int?
       let is_converted:String?
       let movie_stream_id:String?
       let uniq_id:String?
       let content_type_id:String?
       let content_types_id:String?
       let ppv_plan_id:String?
       let full_movie:String?
       let story:String?
       let short_story:String?
       let genres:String?
       let display_name:Int?
       let content_permalink:String?
       let trailer_url:String?
       let trailer_is_converted:String?
       let trailer_player:String?
       let casts:String?
       let casting:String?
       let content_banner:String?
     
       enum CodingKeys: String, CodingKey {
           
           case movie_id = "movie_id"
           case content_category_value = "content_category_value"
           case content_subcategory_value = "content_subcategory_value"
           case is_episode = "is_episode"
           case episode_number = "episode_number"
           case season_number = "season_number"
           case title = "title"
           case parent_content_title = "parent_content_title"
           case content_details = "content_details"
           case content_title = "content_title"
           case play_btn = "play_btn"
           case buy_btn = "buy_btn"
           case permalink = "permalink"
           case c_permalink = "c_permalink"
           case poster = "poster"
           case data_type = "data_type"
           case is_landscape = "is_landscape"
           case release_date = "release_date"
           case full_release_date = "full_release_date"
           case censor_rating = "censor_rating"
           case movie_uniq_id = "movie_uniq_id"
           case stream_uniq_id = "stream_uniq_id"
           case video_duration = "video_duration"
           case watch_duration = "watch_duration"
           case video_duration_text = "video_duration_text"
           case video_duration_in_seconds = "video_duration_in_seconds"
           case watch_duration_in_seconds = "watch_duration_in_seconds"
           case ppv = "ppv"
           case payment_type = "payment_type"
           case is_converted = "is_converted"
           case uniq_id = "uniq_id"
           case muvi_uniq_id = "CategoryId"
           case content_type_id = "content_type_id"
           case content_types_id = "content_types_id"
           case ppv_plan_id = "ppv_plan_id"
           case full_movie = "full_movie"
           case story = "story"
           case short_story = "short_story"
           case genres = "genres"
           case display_name = "display_name"
           case content_permalink = "content_permalink"
           case trailer_url = "trailer_url"
           case trailer_is_converted = "trailer_is_converted"
           case trailer_player = "trailer_player"
           case casts = "casts"
           case casting = "casting"
         case content_banner = "content_banner"
            
        
        
        
        
       }
       init(
            movie_id:String?,
            content_category_value:String?,
            content_subcategory_value:String?,
            is_episode:String?,
            episode_number:Int?,
            season_number:Int?,
            title:String?,
            parent_content_title:String?,
            content_details:String?,
            content_title:String?,
            play_btn:String?,
            buy_btn:String?,
            permalink:String?,
            c_permalink:String?,
            poster:String?,
            data_type:Int?,
            is_landscape:Int?,
            release_date:String?,
            full_release_date:String?,
            censor_rating:String?,
            movie_uniq_id:String?,
            stream_uniq_id:Int?,
            video_duration:String?,
            watch_duration:String?,
            video_duration_text:String?,
            video_duration_in_seconds:Int?,
            watch_duration_in_seconds:Int?,
            ppv:String?,
            payment_type:Int?,
            is_converted:String?,
            movie_stream_id:String?,
            uniq_id:String?,
             content_type_id:String?,
             content_types_id:String?,
             ppv_plan_id:String?,
             full_movie:String?,
             story:String?,
             short_story:String?,
             genres:String?,
             display_name:Int?,
             content_permalink:String?,
             trailer_url:String?,
             trailer_is_converted:String?,
             trailer_player:String?,
             casts:String?,
             casting:String?,
             content_banner:String?
             
             
       )
       {
           
         self.movie_id = movie_id
         self.content_category_value = content_category_value
         self.content_subcategory_value = content_subcategory_value
         self.is_episode = is_episode
        self.episode_number = episode_number
        self.season_number = season_number
        self.title = title
        self.parent_content_title = parent_content_title
        self.content_details = content_details
        self.content_title = content_title
        self.play_btn = play_btn
        self.buy_btn = buy_btn
        self.permalink = permalink
        self.c_permalink = c_permalink
        self.poster = poster
        self.data_type = data_type
        self.is_landscape = is_landscape
        self.release_date = release_date
        self.full_release_date = full_release_date
        self.censor_rating = censor_rating
        self.movie_uniq_id = movie_uniq_id
        self.stream_uniq_id = stream_uniq_id
        self.video_duration = video_duration
        self.watch_duration = watch_duration
        self.video_duration_text = video_duration_text
        self.video_duration_in_seconds = video_duration_in_seconds
        self.watch_duration_in_seconds = watch_duration_in_seconds
        self.ppv = ppv
        self.payment_type = payment_type
        self.is_converted = is_converted
        self.movie_stream_id = movie_stream_id
        self.uniq_id = uniq_id
        self.content_type_id = content_type_id
        self.content_types_id = content_types_id
        self.ppv_plan_id = ppv_plan_id
        self.full_movie = full_movie
        self.story = story
        self.short_story = short_story
        self.genres = genres
        self.display_name = display_name
        self.content_permalink = content_permalink
        self.trailer_url = trailer_url
        self.trailer_is_converted = trailer_is_converted
        self.trailer_player = trailer_player
        self.casts = casts
        self.casting = casting
        self.content_banner = content_banner
       
           
       }
}
class FilteredComedyViewstatus: Codable {
    let viewcount, uniq_view_count: String?
   
    enum CodingKeys: String, CodingKey {
        case viewcount = "viewcount"
        case uniq_view_count = "uniq_view_count"
    }
    
    init(viewcount: String?, uniq_view_count: String?) {
        self.viewcount = viewcount
        self.uniq_view_count = uniq_view_count
    }
}
 
class FilteredComedyCustommetadata: Codable {
    let youtube_source, language_type,movie_name, original_artist,cover_artist : String?
   
    enum CodingKeys: String, CodingKey {
        case youtube_source = "youtube_source"
        case language_type = "language_type"
        case movie_name = "movie_name"
        case original_artist = "original_artist"
        case cover_artist = "cover_artist"
         
    }
    
    init(youtube_source: String?, language_type: String?,movie_name: String?, original_artist: String?,cover_artist: String? ) {
        self.youtube_source = youtube_source
        self.language_type = language_type
        self.movie_name = movie_name
        self.original_artist = original_artist
        self.cover_artist = cover_artist
       
    }
}
 
class FilteredComedyMovPosters: Codable {
    let original, standard,thumb: String?
   
    enum CodingKeys: String, CodingKey {
        case original = "original"
        case standard = "standard"
        case thumb = "thumb"
    }
    
    init(original: String?, standard: String?, thumb: String?) {
        self.original = original
        self.standard = standard
        self.thumb = thumb
    }
}
*/

class newFilteredComedyMovieList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[newFilteredSubComedymovieList]
    
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
       
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[newFilteredSubComedymovieList] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}

 
class newFilteredSubComedymovieList: Codable {
             
     
        
       let title:String?
       let poster:String?
       let movie_uniq_id:String?
       let c_permalink:String?
       let permalink:String?
      let content_types_id:String?
    
       var is_fav_status:Int?
       let watch_duration_in_seconds:Int?
     //  let custom_meta_data : comedycustom_meta_data
       var custom:ComedyCustomDetails?
    /*
       let video_duration:String?
       let description:String?
       let genres:[String]?
     
      
         
      
    
    */
       enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case poster = "poster"
           case movie_uniq_id = "movie_uniq_id"
           case c_permalink = "c_permalink"
           case is_fav_status = "is_fav_status"
           case content_types_id = "content_types_id"
        //   case custom_meta_data = "custom_meta_data"
           case custom = "custom"
           case watch_duration_in_seconds = "watch_duration_in_seconds"
         case permalink = "permalink"
        /*
           case video_duration = "video_duration_text"
           case description = "story"
           case genres = "genres"
        
           
           */
           
          }
       init(
          
            title:String?,
            poster:String?,
            movie_uniq_id:String?,
            c_permalink:String?,
            permalink:String?,
            content_types_id:String?,
         //    custom_meta_data: comedycustom_meta_data,
             custom:ComedyCustomDetails?,
            is_fav_status:Int?,
            watch_duration_in_seconds:Int?
        /*
            video_duration:String?,
            description:String?,
            genres:[String]?,
           
            
            
            */
        )
       {
    
        self.title = title
        self.poster = poster
        self.movie_uniq_id = movie_uniq_id
        self.c_permalink = c_permalink
        self.permalink = permalink
        self.content_types_id = content_types_id
        self.is_fav_status = is_fav_status
      //  self.custom_meta_data = custom_meta_data
        self.custom = custom
        self.watch_duration_in_seconds = watch_duration_in_seconds
       /*
        
        self.video_duration = video_duration
        self.description = description
        self.genres = genres
        
        self.custom = custom
       */
        
       
        
       }
}
class ComedyCustomDetails: Codable {
               
       
        let customimdb:Comedyimdb_idDetails?
         
          enum CodingKeys: String, CodingKey
          {
               case customimdb = "imdb_id"
            
            }
         init(
           
              customimdb:Comedyimdb_idDetails?
         )
         {
      
          self.customimdb = customimdb
          
          
         }
  }
class Comedyimdb_idDetails: Codable {
             
     
        
         let field_display_name,field_value:String?
        enum CodingKeys: String, CodingKey
        {
             case field_display_name = "field_display_name"
            case field_value = "field_value"
          
          }
       init(
         
           field_display_name:String?,
           field_value:String?
       )
       {
    
        self.field_display_name = field_display_name
        self.field_value = field_value
        
        
       }
}
   
class comedycustom_meta_data: Codable {
             
     
        
       let title: String?
        enum CodingKeys: String, CodingKey
        {
             case title = "language_type"
          
          }
       init(
         
            title: String?
       )
       {
    
        self.title = title
        
        
       }
}
class ThrillerMovieList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[subThrillermovieList]
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[subThrillermovieList] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
        
    }
    
    
    
}
 
class subThrillermovieList: Codable {
             
     
        
       let title:String?
       let poster:String?
       let video_duration:String?
       let description:String?
       let genres:[String]?
       let custom_meta_data : Thrillercustom_meta_data
       let custom:thrillerCustomDetails
       enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case poster = "poster"
           case video_duration = "video_duration_text"
           case description = "story"
           case genres = "genres"
           case custom_meta_data = "custom_meta_data"
           case custom = "custom"
        
          }
       init(
         
            title:String?,
            
            poster:String?,
             
            video_duration:String?,
            description:String?,
            genres:[String]?,
            custom_meta_data: Thrillercustom_meta_data,
            custom:thrillerCustomDetails
             
       )
       {
    
        self.title = title
        
        self.poster = poster
    
        self.video_duration = video_duration
        self.description = description
        self.genres = genres
        self.custom_meta_data = custom_meta_data
        self.custom  = custom
        
       
           
       }
}
  class thrillerCustomDetails: Codable {
               
       
        let customimdb:thrillerimdb_idDetails
         
          enum CodingKeys: String, CodingKey
          {
               case customimdb = "imdb_id"
            
            }
         init(
           
              customimdb:thrillerimdb_idDetails
         )
         {
      
          self.customimdb = customimdb
          
          
         }
  }
class thrillerimdb_idDetails: Codable {
             
     
        
         let field_display_name,field_value:String?
        enum CodingKeys: String, CodingKey
        {
             case field_display_name = "field_display_name"
            case field_value = "field_value"
          
          }
       init(
         
           field_display_name:String?,
           field_value:String?
       )
       {
    
        self.field_display_name = field_display_name
        self.field_value = field_value
        
        
       }
}
   
class Thrillercustom_meta_data: Codable {
             
     
        
       let title:[String]?
        enum CodingKeys: String, CodingKey
        {
             case title = "language_type"
          
          }
       init(
         
            title:[String]?
       )
       {
    
        self.title = title
        
        
       }
}
 class ActionMovieList: Codable {
  
     let code :Int?
     let total_content,status:String?
     var subComedymovList:[subActionmovieList]
     
     
      enum CodingKeys: String, CodingKey {
         
         case code = "code"
         case status = "status"
         case total_content = "total_content"
         case subComedymovList = "lists"
       
      
     }
     
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[subActionmovieList] ) {
         self.code = code
         self.status = status
         self.total_content = total_content
         self.subComedymovList = subComedymovList
        
        
         
     }
     
     
     
 }
  
 class subActionmovieList: Codable {
              
      
         
        let title:String?
        let poster:String?
        let video_duration:String?
        let description:String?
        let genres:[String]?
       let custom_meta_data : Actioncustom_meta_data
       let  custom:ActionCustomDetails
        enum CodingKeys: String, CodingKey {
            
       
            case title = "title"
            case poster = "poster"
            case video_duration = "video_duration_text"
            case description = "story"
            case genres = "genres"
            case custom_meta_data = "custom_meta_data"
             case custom = "custom"
         
           }
        init(
          
             title:String?,
             
             poster:String?,
              
             video_duration:String?,
             description:String?,
             genres:[String]?,
             custom_meta_data: Actioncustom_meta_data,
             custom:ActionCustomDetails
              
              
        )
        {
     
         self.title = title
         
         self.poster = poster
     
         self.video_duration = video_duration
         self.description = description
         self.genres = genres
          self.custom_meta_data = custom_meta_data
            self.custom = custom
         
        
            
        }
 }
   class ActionCustomDetails: Codable {
                  
          
           let customimdb:Actionimdb_idDetails
            
             enum CodingKeys: String, CodingKey
             {
                  case customimdb = "imdb_id"
               
               }
            init(
              
                 customimdb:Actionimdb_idDetails
            )
            {
         
             self.customimdb = customimdb
             
             
            }
     }
   class Actionimdb_idDetails: Codable {
                
        
           
            let field_display_name,field_value:String?
           enum CodingKeys: String, CodingKey
           {
                case field_display_name = "field_display_name"
               case field_value = "field_value"
             
             }
          init(
            
              field_display_name:String?,
              field_value:String?
          )
          {
       
           self.field_display_name = field_display_name
           self.field_value = field_value
           
           
          }
   }
 class Actioncustom_meta_data: Codable {
              
      
         
        let title:[String]?
         enum CodingKeys: String, CodingKey
         {
              case title = "language_type"
           
           }
        init(
          
             title:[String]?
        )
        {
     
         self.title = title
         
         
        }
 }
  
class LiveTVsportsList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[SubLiveTVsports]
   
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
        
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[SubLiveTVsports],description:String? ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
        
        
    }
    
    
    
}
class SubLiveTVsports: Codable {
       let title:String?
       let poster:String?
       let video_duration:String?
     //  let  custom_meta_data:SubLiveTVsportscustom_meta_data
     let description:String?
    enum CodingKeys: String, CodingKey {
         case title = "title"
         case poster = "poster"
         case video_duration = "video_duration_text"
       // case custom_meta_data = "custom_meta_data"
        case description = "description"
        }
       init(
              title:String?,
              poster:String?,
              video_duration:String?,
              // custom_meta_data:SubLiveTVsportscustom_meta_data,
              description:String?
        
        )
       {
         self.title = title
         self.poster = poster
        self.video_duration = video_duration
        //self.custom_meta_data = custom_meta_data
        self.description = description
       }
}
class SubLiveTVsportscustom_meta_data: Codable {
             
     
        
       let title:[String]?
        enum CodingKeys: String, CodingKey
        {
             case title = "language_type"
          
          }
       init(
         
            title:[String]?
       )
       {
    
        self.title = title
        
        
       }
}

class LiveTVspirtualList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[SubLiveTVspirtual]
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[SubLiveTVspirtual] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
        
    }
    
    
    
}
class SubLiveTVspirtual: Codable {
       let title:String?
       let poster:String?
       let video_duration:String?
     // let custom_meta_data:SubLiveTVspirtualcustom_meta_data
      let description:String?
    enum CodingKeys: String, CodingKey {
         case title = "title"
         case poster = "poster"
         case video_duration = "video_duration_text"
       //  case custom_meta_data = "custom_meta_data"
        case description = "description"
        }
       init(
              title:String?,
              poster:String?,
              video_duration:String?,
        //      custom_meta_data:SubLiveTVspirtualcustom_meta_data,
              description:String?
        )
       {
         self.title = title
         self.poster = poster
        self.video_duration = video_duration
        // self.custom_meta_data = custom_meta_data
         self.description = description
       }
}
class SubLiveTVspirtualcustom_meta_data: Codable {
             
     
        
       let title:[String]?
        enum CodingKeys: String, CodingKey
        {
             case title = "language_type"
          
          }
       init(
         
            title:[String]?
       )
       {
    
        self.title = title
        
        
       }
}

class LiveTVmusicList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[SubLiveTVmusic]
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[SubLiveTVmusic] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
        
    }
    
    
    
}
class SubLiveTVmusic: Codable {
       let title:String?
       let poster:String?
       let video_duration:String?
       let description:String?
   // let custom_meta_data:SubLiveTVMusiccustom_meta_data
    enum CodingKeys: String, CodingKey {
         case title = "title"
         case poster = "poster"
         case video_duration = "video_duration_text"
   //    case custom_meta_data = "custom_meta_data"
        case description = "description"
        }
       init(
              title:String?,
              poster:String?,
              video_duration:String?,
   //           custom_meta_data:SubLiveTVMusiccustom_meta_data,
              description:String?
        )
       {
         self.title = title
         self.poster = poster
        self.video_duration = video_duration
   //     self.custom_meta_data = custom_meta_data
        self.description = description
       }
}
class SubLiveTVMusiccustom_meta_data: Codable {
             
     
        
       let title:[String]?
        enum CodingKeys: String, CodingKey
        {
             case title = "language_type"
          
          }
       init(
         
            title:[String]?
       )
       {
    
        self.title = title
        
        
       }
}

class LiveTVentertainmentList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[SubLiveTVentertainment]
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[SubLiveTVentertainment] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
        
    }
    
    
    
}
class SubLiveTVentertainment: Codable {
       let title:String?
       let poster:String?
       let video_duration:String?
         
    enum CodingKeys: String, CodingKey {
         case title = "title"
         case poster = "poster"
         case video_duration = "video_duration_text"
        }
       init(
              title:String?,
              poster:String?,
              video_duration:String?
        )
       {
         self.title = title
         self.poster = poster
        self.video_duration = video_duration
       }
}


class LiveTVnewsList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[SubLiveTVnews]
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[SubLiveTVnews] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
        
    }
    
    
    
}
class SubLiveTVnews: Codable {
       let title:String?
       let poster:String?
       let video_duration:String?
         
    enum CodingKeys: String, CodingKey {
         case title = "title"
         case poster = "poster"
         case video_duration = "video_duration_text"
        }
       init(
              title:String?,
              poster:String?,
              video_duration:String?
        )
       {
         self.title = title
         self.poster = poster
        self.video_duration = video_duration
       }
}
class IMDBdataList: Codable {
 /*
     {
         "Title": "Guardians of the Galaxy Vol. 2",
         "Year": "2017",
         "Rated": "PG-13",
         "Released": "05 May 2017",
         "Runtime": "136 min",
         "Genre": "Action, Adventure, Comedy, Sci-Fi",
         "Director": "James Gunn",
         "Writer": "James Gunn, Dan Abnett (based on the Marvel comics by), Andy Lanning (based on the Marvel comics by), Steve Englehart (Star-Lord created by), Steve Gan (Star-Lord created by), Jim Starlin (Gamora and Drax created by), Stan Lee (Groot created by), Larry Lieber (Groot created by), Jack Kirby (Groot created by), Bill Mantlo (Rocket Raccoon created by), Keith Giffen (Rocket Raccoon created by), Steve Gerber (Howard the Duck created by), Val Mayerik (Howard the Duck created by)",
         "Actors": "Chris Pratt, Zoe Saldana, Dave Bautista, Vin Diesel",
         "Plot": "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
         "Language": "English",
         "Country": "USA",
         "Awards": "Nominated for 1 Oscar. Another 15 wins & 56 nominations.",
         "Poster": "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
         "Ratings": [
             {
                 "Source": "Internet Movie Database",
                 "Value": "7.6/10"
             },
             {
                 "Source": "Rotten Tomatoes",
                 "Value": "85%"
             },
             {
                 "Source": "Metacritic",
                 "Value": "67/100"
             }
         ],
         "Metascore": "67",
         "imdbRating": "7.6",
         "imdbVotes": "545,424",
         "imdbID": "tt3896198",
         "Type": "movie",
         "DVD": "22 Aug 2017",
         "BoxOffice": "$389,804,217",
         "Production": "Walt Disney Pictures",
         "Website": "N/A",
         "Response": "True"
     }
     */
    
    let Title :String?
    let Year :String?
    let Rated :String?
    let Released :String?
    let Runtime :String?
    let Genre :String?
    let Director :String?
    let Writer :String?
    let Actors :String?
    let Plot :String?
    let Language :String?
    let Country :String?
    let Awards :String?
    let Poster :String?
    let imdbRating :String?
    let Production:String?
    let Response:String?
    
     
    
     enum CodingKeys: String, CodingKey {
        
        case Title = "Title"
        case Year = "Year"
        case Rated = "Rated"
        case Released = "Released"
        case Runtime = "Runtime"
        case Genre = "Genre"
        case Director = "Director"
        case Writer = "Writer"
        case Actors = "Actors"
        case Plot = "Plot"
        case Language = "Language"
       case Country = "Country"
       case Awards = "Awards"
       case Poster = "Poster"
       case imdbRating = "imdbRating"
       case Production = "Production"
        case Response = "Response"
        
        
     
    }
    
    init(Title :String?,
         Year :String?,
         Rated :String?,
         Released :String?,
         Runtime :String?,
         Genre :String?,
         Director :String?,
         Writer :String?,
         Actors :String?,
         Plot :String?,
         Language :String?,
         Awards :String?,
         Country :String?,
         Poster :String?,
         imdbRating :String?,
         Production:String?,
         Response:String?
         
         
         ) {
        self.Title = Title
        self.Year = Year
        self.Rated = Rated
        self.Released = Released
        self.Runtime = Runtime
        self.Genre = Genre
        self.Director = Director
        self.Writer = Writer
        self.Actors = Actors
        self.Plot = Plot
        self.Language = Language
        self.Country = Country
        self.Awards = Awards
        self.Poster = Poster
        self.imdbRating = imdbRating
        self.Production = Production
        self.Response = Response
        
        
    }
    
    
    
}
 
class subIMDBdataList: Codable {
             
     
        
       let title:String?
       let poster:String?
       let video_duration:String?
       let description:String?
       let genres:[String]?
       let custom_meta_data : Actioncustom_meta_data
       enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case poster = "poster"
           case video_duration = "video_duration_text"
           case description = "story"
           case genres = "genres"
           case custom_meta_data = "custom_meta_data"
        
          }
       init(
         
            title:String?,
            
            poster:String?,
             
            video_duration:String?,
            description:String?,
            genres:[String]?,
            custom_meta_data: Actioncustom_meta_data
             
             
       )
       {
    
        self.title = title
        
        self.poster = poster
    
        self.video_duration = video_duration
        self.description = description
        self.genres = genres
         self.custom_meta_data = custom_meta_data
        
       
           
       }
}
  
class arrayList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[arrraymovieList]
    
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "lists"
       
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[arrraymovieList] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}

 
class arrraymovieList: Codable {
             
     
        
       let title:String?
       let poster:String?
       let video_duration:String?
       let description:String?
       let c_permalink:String?
       let genres:[String]?
        enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case poster = "poster"
           case video_duration = "video_duration_text"
           case description = "story"
           case genres = "genres"
          case c_permalink = "c_permalink"
          }
       init(
         
            title:String?,
            
            poster:String?,
             
            video_duration:String?,
            description:String?,
            genres:[String]?,
            c_permalink:String?
            
             
             
       )
       {
    
        self.title = title
        
        self.poster = poster
    
        self.video_duration = video_duration
        self.description = description
        self.genres = genres
        self.c_permalink = c_permalink
        
       
           
       }
}
 class SuccessResponse: Codable {
              
   
        let code:Int?
        let status:String?
        let msg:String?
    
         enum CodingKeys: String, CodingKey
         {
             case code = "code"
             case status = "status"
             case msg = "msg"
         }
    init(
          
             code:Int?,
             status:String?,
             msg:String?
             
        )
        {
     
           self.code = code
           self.status = status
           self.msg = msg
        
        }
 }
  


class FavouriteList: Codable {
 
    let code  :Int?
    let total_content:String?
    var subComedymovList:[newFilteredSubComedymovieList]?
    
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        
        case total_content = "item_count"
        case subComedymovList = "movieList"
       
     
    }
    
    init(code :Int?, total_content:String?, subComedymovList:[newFilteredSubComedymovieList]? ) {
        self.code = code
       
        self.total_content = total_content
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}

 
class SubFavouriteList: Codable {
             
     
        
       let title:String?
       let poster:String?
       let video_duration:String?
       let description:String?
    let content_types_id:String?
      // let genres:[String]?
      // let custom_meta_data : comedycustom_meta_data
    //var custom:ComedyCustomDetails
         
       let movie_uniq_id:String?
       let is_fav_status:Int?
    
        
       enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case poster = "poster"
           case video_duration = "video_duration_text"
           case description = "story"
        //   case genres = "genres"
        //   case custom_meta_data = "custom_meta_data"
       //    case custom = "custom"
           
           case movie_uniq_id = "movie_uniq_id"
           case is_fav_status = "is_fav_status"
        case content_types_id = "content_types_id"
          }
       init(
          
            title:String?,
            poster:String?,
            video_duration:String?,
            description:String?,
            content_types_id:String?,
          //  genres:[String]?,
          //  custom_meta_data: comedycustom_meta_data,
         //   custom:ComedyCustomDetails,
            
            movie_uniq_id:String?,
            is_fav_status:Int?
        )
       {
    
        self.title = title
        self.poster = poster
        self.video_duration = video_duration
        self.description = description
        self.content_types_id = content_types_id
       // self.genres = genres
       // self.custom_meta_data = custom_meta_data
      //  self.custom = custom
       
        self.movie_uniq_id = movie_uniq_id
       
        self.is_fav_status = is_fav_status
       }
}
 

class searchList: Codable {
 
    let code ,status:Int?
    let total_content:String?
    var subComedymovList:[newFilteredSubComedymovieList]
    
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "search"
       
     
    }
    
    init(code :Int?,status:Int?,total_content:String?, subComedymovList:[newFilteredSubComedymovieList] ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}

 
class SubsearchList: Codable {
             
     
        
       let title:String?
       let poster:String?
       let video_duration:String?
       let description:String?
       let c_permalink:String?
      // let genres:[String]?
      // let custom_meta_data : comedycustom_meta_data
    //var custom:ComedyCustomDetails
         
       let movie_uniq_id:String?
       let is_fav_status:Int?
       let permalink:String?
      let watch_duration_in_seconds:Int?
        
       enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case poster = "poster"
           case video_duration = "video_duration_text"
           case description = "story"
           case permalink = "permalink"
           case c_permalink = "c_permalink"
           case watch_duration_in_seconds = "watch_duration_in_seconds"
        //   case genres = "genres"
        //   case custom_meta_data = "custom_meta_data"
       //    case custom = "custom"
           
           case movie_uniq_id = "movie_uniq_id"
           case is_fav_status = "is_fav_status"
          }
       init(
          
            title:String?,
            poster:String?,
            video_duration:String?,
            description:String?,
            c_permalink:String?,
          //  genres:[String]?,
          //  custom_meta_data: comedycustom_meta_data,
         //   custom:ComedyCustomDetails,
            
            movie_uniq_id:String?,
            is_fav_status:Int?,
            permalink:String?,
            watch_duration_in_seconds:Int?
        )
       {
    
        self.title = title
        self.poster = poster
        self.video_duration = video_duration
        self.description = description
         self.c_permalink = c_permalink
        self.watch_duration_in_seconds = watch_duration_in_seconds
       // self.genres = genres
       // self.custom_meta_data = custom_meta_data
      //  self.custom = custom
       
        self.movie_uniq_id = movie_uniq_id
       
        self.is_fav_status = is_fav_status
        self.permalink = permalink
       }
}
class contentdetails: Codable {
 
    let code  :Int?
    let msg,category_name:String?
    let submovie:Subcontentdetails?
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case msg = "msg"
        case category_name = "category_name"
         case submovie = "movie"
     
    }
    
    init(code :Int? ,msg:String?,category_name:String? , submovie:Subcontentdetails?) {
        self.code = code
        self.msg = msg
        self.category_name = category_name
        self.submovie = submovie
     }
    
  
}

 
class Subcontentdetails: Codable {
           /*
     ": "b8be263fc78e2035d9189544d1254894",
             ""
     */
        
       let movieUrl:String?
       let feed_url:String?
       let poster:String?
       let name:String?
       let story:String?
       let video_duration:String?
       let custommetadata:contentdetailsCustommetadata?
       let resolutiondata:[contentdetailsResolutiondata]?
    let embeddedUrl:String?
    let muvi_uniq_id:String?

    let ppv_plan_id:String?
    let permalink:String?
    let custom3:String?
       enum CodingKeys: String, CodingKey
       {
          case movieUrl = "movieUrl"
          case poster  = "poster"
          case name = "name"
          case custommetadata = "custom_meta_data"
          case resolutiondata = "resolutiondata"
          case story = "story"
         case video_duration = "video_duration"
        case embeddedUrl = "embeddedUrl"
        case feed_url = "feed_url"
        case muvi_uniq_id = "muvi_uniq_id"
        case ppv_plan_id = "ppv_plan_id"
        case permalink = "permalink"
        case custom3 = "custom3"

          }
       init(
          
            movieUrl:String?,
            story:String?,
            poster:String?,
            name:String?,
            video_duration:String?,
            custommetadata:contentdetailsCustommetadata?,
            resolutiondata:[contentdetailsResolutiondata]?,
            embeddedUrl:String?,
            feed_url:String?,
        muvi_uniq_id:String?,
        ppv_plan_id:String?,
        permalink:String?,
        custom3:String?

        )
       {
    
        self.movieUrl = movieUrl
        self.story = story
        self.poster = poster
        self.name = name
         self.video_duration = video_duration
        self.custommetadata = custommetadata
        self.resolutiondata = resolutiondata
        self.embeddedUrl = embeddedUrl
        self.feed_url = feed_url
        self.muvi_uniq_id = muvi_uniq_id
        self.ppv_plan_id = ppv_plan_id
        self.permalink = permalink
        self.custom3 = custom3

       }
}
class  contentdetailsCustommetadata: Codable {
             
      
       let language_type:String?
       let movie_name:String?
       let original_artist:String?
       let cover_artist:String?
       enum CodingKeys: String, CodingKey {
           
      
           case language_type = "language_type"
           case movie_name  = "poster"
           case original_artist = "original_artist"
           case cover_artist = "cover_artist"
          }
       init(
          
            language_type:String?,
            movie_name:String?,
            original_artist:String?,
            cover_artist:String?
        )
       {
    
        self.language_type = language_type
        self.movie_name = movie_name
        self.original_artist = original_artist
         self.cover_artist = cover_artist
       }
}
class  contentdetailsResolutiondata: Codable {
             
      
       let resolution:String?
       let url:String?
       
       enum CodingKeys: String, CodingKey {
           
      
           case resolution = "resolution"
           case url  = "url"
          
          }
       init(
          
            resolution:String?,
            url:String?
        )
       {
    
        self.resolution = resolution
        self.url = url
         
       }
}

class Userprofile: Codable {
             
  
       let code:Int?
       let status:String?
       let msg:String?
       let profileimage:String?
   
        enum CodingKeys: String, CodingKey {
            case code = "code"
            case status = "status"
            case msg = "msg"
            case profileimage = "profile_image"
           
          
          }
       init(
         
            code:Int?,
            status:String?,
            msg:String?,
            profileimage:String?
            
       )
       {
    
          self.code = code
          self.status = status
          self.msg = msg
          self.profileimage = profileimage
       
       }
}
 

class PlanList: Codable {
    let code: Int?
    let status  : String?
    var list: [PlanListDetails]
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case list = "plans"
    }
    
    init(code: Int?, status: String?, list: [PlanListDetails]) {
        self.code = code
        self.status = status
         
        self.list = list
    }
}

// MARK: - MeetingOrganizationList
class PlanListDetails: Codable {
    let id, name,price,recurrence: String?
    let currency:CurrencyData?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "name"
        case price = "price"
        case recurrence = "recurrence"
        case currency = "currency"
        
    }
    
    init(id: String?, name: String?,price:String?,recurrence:String?,currency:CurrencyData?) {
        self.id = id
        self.name = name
        self.price = price
        self.recurrence = recurrence
        self.currency = currency
    }
}
class Authorizescontent: Codable {
 
    let string_code, status,msg : String?
    
    enum CodingKeys: String, CodingKey {
        case string_code = "string_code"
        case status = "status"
        case msg = "msg"
       
        
    }
    
    init(string_code: String?, status: String?,msg:String? ) {
        self.string_code = string_code
        self.status = status
        self.msg = msg
         
    }
}
class MyPlanList: Codable {
    let code: Int?
    let status  : String?
    var list: [MyPlanListDetails]?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "msg"
        case list = "Plan"
    }
    
    init(code: Int?, status: String?, list: [MyPlanListDetails]?) {
        self.code = code
        self.status = status
         
        self.list = list
    }
}

// MARK: - MeetingOrganizationList
class MyPlanListDetails: Codable {
    let id, name,price,recurrence: String?
    let currency:CurrencyData?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case recurrence = "recurrence"
        case currency = "currency"
        
    }
    
    init(id: String?, name: String?,price:String?,recurrence:String?,currency:CurrencyData?) {
        self.id = id
        self.name = name
        self.price = price
        self.recurrence = recurrence
        self.currency = currency
    }
}
class CurrencyData: Codable {
    
    let symbol  : String?
     
    
    enum CodingKeys: String, CodingKey {
        
        case symbol = "symbol"
         
    }
    
    init( symbol: String? ) {
        self.symbol = symbol
       
    }
}

class EdpisodeData: Codable {
      
         let string_code, status,msg : String?
         var list: [Edpisodedetails]?
         enum CodingKeys: String, CodingKey {
             case string_code = "item_count"
             case status = "status"
             case msg = "msg"
             case list = "episode"
            
             
         }
         
         init(string_code: String?, status: String?,msg:String?,list: [Edpisodedetails]?) {
             self.string_code = string_code
             self.status = status
             self.msg = msg
            self.list = list
              
         }
}
/*
class  contentdetailsCustommetadata: Codable {
             
      
       let language_type:String?
       let movie_name:String?
       let original_artist:String?
       let cover_artist:String?
       enum CodingKeys: String, CodingKey {
           
      
           case language_type = "language_type"
           case movie_name  = "poster"
           case original_artist = "original_artist"
           case cover_artist = "cover_artist"
          }
       init(
          
            language_type:String?,
            movie_name:String?,
            original_artist:String?,
            cover_artist:String?
        )
       {
    
        self.language_type = language_type
        self.movie_name = movie_name
        self.original_artist = original_artist
         self.cover_artist = cover_artist
       }
}
*/
class Edpisodedetails: Codable {
             
      
       let episode_title:String?
       let video_url:String?
       let poster_url:String?
       let video_duration:String?
       let episode_date:String?
       let episode_story:String?
      let embeddedUrl:String?
       enum CodingKeys: String, CodingKey {
           
      
           case episode_title = "episode_title"
           case video_url  = "video_url"
           case poster_url = "poster_url"
           case video_duration = "video_duration"
           case episode_date = "episode_date"
           case episode_story = "episode_story"
          case embeddedUrl = "movieUrlForTv"
          
          }
       init(
          
            episode_title:String?,
            video_url:String?,
            poster_url:String?,
            video_duration:String?,
            episode_date:String?,
            episode_story:String?,
            embeddedUrl:String?
            
        )
       {
    
        self.episode_title = episode_title
        self.video_url = video_url
        self.poster_url = poster_url
        self.video_duration = video_duration
        self.episode_date = episode_date
        self.episode_story = episode_story
        self.embeddedUrl = embeddedUrl
         
         
       }
}
/*
 "id": "162218",
      "email": "rajT@gmail.com",
      "display_name": "Raju",
      "studio_id": "7962",
      "is_newuser": 0,
      "profile_image": "https://d1yjifjuhwl7lc.cloudfront.net/public/no-user.png",
      "isSubscribed": 0,
      "login_history_id": "431802",
      "code": 200,
      "status": "OK",
      "msg": "Login Success"
 */
class GoogleLogin: Codable {
             
      
    let id:String?
    let email:String?
    let display_name:String?
    let studio_id:String?
    let profile_image:String?
    let status:String?
    let msg:String?
    let is_newuser:Int?
    
       
       enum CodingKeys: String, CodingKey {
           
      
        case id = "id"
        case email  = "email"
        case display_name = "display_name"
        case studio_id = "studio_id"
        case profile_image  = "video_url"
        case status = "status"
         case msg = "msg"
        case is_newuser = "is_newuser"
       
          }
       init(
          
            id:String?,
            email:String?,
            display_name:String?,
            studio_id:String?,
            profile_image:String?,
            status:String?,
            msg:String?,
            is_newuser:Int?
         )
       {
    
        self.id = id
        self.email = email
        self.display_name = display_name
        self.studio_id = studio_id
        self.profile_image = profile_image
        self.status = status
        self.msg = msg
        self.is_newuser = is_newuser
        
         
       }
}
 
class FacebookLogin: Codable {
             
      
    let id:String?
    let email:String?
    let display_name:String?
    
       enum CodingKeys: String, CodingKey {
           
      
        case id = "id"
        case email  = "email"
        case display_name = "name"
         
          }
       init(
          
            id:String?,
            email:String?,
            display_name:String?
         )
       {
    
        self.id = id
        self.email = email
        self.display_name = display_name
       
         
       }
}

class WatchhistoryList: Codable {
 
    let code :Int?
    let total_content,status:String?
    var subComedymovList:[Watchhistorydeatails]?
    
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        case total_content = "total_content"
        case subComedymovList = "list"
       
     
    }
    
    init(code :Int?,status:String?,total_content:String?, subComedymovList:[Watchhistorydeatails]? ) {
        self.code = code
        self.status = status
        self.total_content = total_content
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}

 
class Watchhistorydeatails: Codable {
             
     
        
       let title:String?
       let poster:String?
       let movie_uniq_id:String?
       let c_permalink:String?
       let is_fav_status:Int?
     
       var custom:ComedyCustomDetails?
       let video_duration_in_seconds:Int?
       let watch_duration_in_seconds:Int?
    let content_types_id:String?
    let permalink:String?

        enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case poster = "poster"
           case movie_uniq_id = "movie_uniq_id"
           case c_permalink = "c_permalink"
           case is_fav_status = "is_fav_status"
           case video_duration_in_seconds = "video_duration_in_seconds"
           case watch_duration_in_seconds = "watch_duration_in_seconds"
            case content_types_id = "content_types_id"
            case permalink = "permalink"

          }
       init(
          
            title:String?,
            poster:String?,
            movie_uniq_id:String?,
            c_permalink:String?,
            custom:ComedyCustomDetails?,
            is_fav_status:Int?,
            video_duration_in_seconds:Int?,
            watch_duration_in_seconds:Int?,
        content_types_id:String?,
        permalink:String?

       
        )
       {
    
        self.title = title
        self.poster = poster
        self.movie_uniq_id = movie_uniq_id
        self.c_permalink = c_permalink
        self.is_fav_status = is_fav_status
        self.video_duration_in_seconds = video_duration_in_seconds
        self.watch_duration_in_seconds = watch_duration_in_seconds
        self.content_types_id = content_types_id
        self.permalink = permalink
        
       }
}
struct RadioData {
    let Icon,Url,Title:String
}


 
struct finalRadioData {
    let Icon,Url,Title:String
}
 

class BannerList: Codable {
  
    var subComedymovList:[BannerListdeatails]?
    var status:String?
     enum CodingKeys: String, CodingKey {
          case subComedymovList = "banners"
        case status = "status"
        
    }
    
    init( subComedymovList:[BannerListdeatails]?,status:String ) {
         
        self.subComedymovList = subComedymovList
        self.status = status
        
    }
    
  
}

 
class BannerListdeatails: Codable {
             
     
        
       let mobile_view:String?
    let banner_type:String?
    let video_placeholder_img:String?
     let video_remote_url:String?
    
      
        enum CodingKeys: String, CodingKey {
           
      
           case mobile_view = "mobile_view"
             case banner_type = "banner_type"
             case video_placeholder_img = "video_placeholder_img"
       case video_remote_url = "video_remote_url"
          }
       init(
          
            mobile_view:String?,
             banner_type:String?,
             video_placeholder_img:String?,
              video_remote_url:String?
       
        )
       {
    
        self.mobile_view = mobile_view
         self.banner_type = banner_type
        self.video_placeholder_img = video_placeholder_img
         self.video_remote_url = video_remote_url
      
       }
}
 class NewBannerList: Codable {
   
     var subComedymovList:[NewBannerListdeatails]?
     var Message:String?
    let Success:Int?
      enum CodingKeys: String, CodingKey {
           case subComedymovList = "BannerList"
         case Message = "Message"
        case Success = "Success"
         
     }
     
    init( subComedymovList:[NewBannerListdeatails]?,Message:String?,Success:Int? ) {
          
         self.subComedymovList = subComedymovList
         self.Message = Message
        self.Success = Success
         
     }
     
   
 }

  
 class NewBannerListdeatails: Codable {
              
      
         
        let bannerImage:String?
       let action:String?
       let bannerURL:String?
    let permalink:String?
         enum CodingKeys: String, CodingKey {
            
       
            case bannerImage = "bannerImage"
             case action = "action"
            case bannerURL = "bannerURL"
            case permalink = "c_permalink"
              
           }
        init(
           
             bannerImage:String?,
              action:String?,
              bannerURL:String?,
            permalink:String?
              
        
         )
        {
     
         self.bannerImage = bannerImage
            self.action = action
            self.bannerURL = bannerURL
            self.permalink = permalink
        
        }
 }
class LoginData: Codable {
  
        let id:String?
       let email:String?
       let display_name:String?
       let profile_image:String?
       let status:String?
       let msg:String?
      let isSubscribed :Int?
       
     
       
        enum CodingKeys: String, CodingKey {
           
      
           case id = "id"
           case email = "email"
           case display_name = "display_name"
           case profile_image = "profile_image"
           case status = "status"
            case msg = "msg"
            case isSubscribed = "isSubscribed"
          
                 
          }
       init(
          
            id:String?,
            email:String?,
            display_name:String?,
            profile_image:String?,
            status:String?,
            msg:String?,
            isSubscribed:Int?
       
        )
       {
    
        self.id = id
        self.email = email
        self.display_name = display_name
        self.profile_image = profile_image
        self.status = status
        self.msg = msg
        self.isSubscribed = isSubscribed
       
       }
  
}
/*
 {
     "code": 200,
     "status": "OK",
     "section": [
         {
             "invoice_id": "ch_1HXMF4H0IuiJqsYikbPaktVK",
             "transaction_date": "October 01, 2020",
             "amount": "49.00",
             "transaction_status": "Success",
             "currency_symbol": "$",
             "currency_code": "USD",
             "id": "idkUHpFSoNlYHpkcjZkVhN2aKVVVB1TP",
             "statusppv": "Active",
             "Content_type": "digital",
             "plan_name": "Prime",
             "plan_duration": "1 Month",
             "transaction_for": "Monthly subscription"
         },
         {
             "invoice_id": "ch_1HWNNLH0IuiJqsYiTKLUsAHv",
             "transaction_date": "September 28, 2020",
             "amount": "9.00",
             "transaction_status": "Success",
             "currency_symbol": "$",
             "currency_code": "USD",
             "id": "iZkWXRVVaNlUspFWXxmVhN2aKVVVB1TP",
             "statusppv": "Active",
             "Content_type": "digital",
             "plan_name": "Basic",
             "plan_duration": "1 Month",
             "transaction_for": "Monthly subscription"
         },
         {
             "invoice_id": "ch_1HM7JxH0IuiJqsYi0TRfifas",
             "transaction_date": "August 31, 2020",
             "amount": "49.00",
             "transaction_status": "Success",
             "currency_symbol": "$",
             "currency_code": "USD",
             "id": "hBDcFd1aaNVTVFzMTxmVhN2aKVVVB1TP",
             "statusppv": "Active",
             "Content_type": "digital",
             "plan_name": "Prime",
             "plan_duration": "1 Month",
             "transaction_for": "Monthly subscription"
         },
         {
             "invoice_id": "ch_1HL8dpH0IuiJqsYiu4b0Txuk",
             "transaction_date": "August 28, 2020",
             "amount": "9.00",
             "transaction_status": "Success",
             "currency_symbol": "$",
             "currency_code": "USD",
             "id": "UpmR0ZFSoNlYHpkeTxmVhN2aKVVVB1TP",
             "statusppv": "Active",
             "Content_type": "digital",
             "plan_name": "Basic",
             "plan_duration": "1 Month",
             "transaction_for": "Monthly subscription"
         }
     ]
 }
 */

class PurchasehistoryList: Codable {
 
    let code :Int?
    let status:String?
    var subComedymovList:[Purchasehistorydeatails]?
    
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        
        case subComedymovList = "section"
       
     
    }
    
    init(code :Int?,status:String? , subComedymovList:[Purchasehistorydeatails]? ) {
        self.code = code
        self.status = status
        
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}

 
class Purchasehistorydeatails: Codable {
   
       let transaction_date:String?
       let amount:String?
       let currency_symbol:String?
       let currency_code:String?
       let statusppv:String?
       let plan_name:String?
       let plan_duration:String?
        enum CodingKeys: String, CodingKey {
           
      
           case transaction_date = "transaction_date"
           case amount = "amount"
           case currency_symbol = "currency_symbol"
           case currency_code = "currency_code"
           case statusppv = "statusppv"
           case plan_name = "plan_name"
           case plan_duration = "plan_duration"
                 
          }
       init(
          
            transaction_date:String?,
            amount:String?,
            currency_symbol:String?,
            currency_code:String?,
            statusppv:String?,
             plan_name:String?,
            plan_duration:String?
       
        )
       {
    
        self.transaction_date = transaction_date
        self.amount = amount
        self.currency_symbol = currency_symbol
        self.currency_code = currency_code
        self.statusppv = statusppv
        self.plan_name = plan_name
        self.plan_duration = plan_duration
           
        
       }
}
class CardData: Codable {
 
    let code :Int?
    let status:String?
    var subComedymovList:[CardDatadetails]?
    
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        
        case subComedymovList = "cards"
       
     
    }
    
    init(code :Int?,status:String? , subComedymovList:[CardDatadetails]? ) {
        self.code = code
        self.status = status
        
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}

class CardDatadetails: Codable {
          
        let card_holder_name:String?
        let card_last_fourdigit:String?
        let card_type:String?
         enum CodingKeys: String, CodingKey {
           
      
           case card_holder_name = "card_holder_name"
           case card_last_fourdigit = "card_last_fourdigit"
           case card_type = "card_type"
           
                 
          }
       init(
          
            card_holder_name:String?,
            card_last_fourdigit:String?,
            card_type:String?
            
        )
       {
    
        self.card_holder_name = card_holder_name
        self.card_last_fourdigit = card_last_fourdigit
        self.card_type = card_type
       
       }
  
}

class FeaturedData: Codable {
 
    let code :Int?
    let status:String?
    var subComedymovList:[FeaturedDataList]?
    
    
     enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case status = "status"
        
        case subComedymovList = "section"
       
     
    }
    
    init(code :Int?,status:String? , subComedymovList:[FeaturedDataList]? ) {
        self.code = code
        self.status = status
        
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}
class MainAudiopodcastData: Codable {
 
    let code :Int?
    let status:String?
    var subComedymovList:[MainAudiopodcastDataList]?
 
    
    init(code :Int?,status:String? , subComedymovList:[MainAudiopodcastDataList]? ) {
        self.code = code
        self.status = status
        
        self.subComedymovList = subComedymovList
       
        
    }
    
  
}
class MainAudiopodcastDataList: Codable {
          
        let title:String?
        let permalink:String?
        var contents:[AudioPodcastDataListDetails]?
 
       init(
       
        permalink:String?,

            title:String?,
            contents:[AudioPodcastDataListDetails]?
             
           
            
        )
       {
    
        self.permalink = permalink

        self.title = title
        self.contents = contents
        
         
       }
  
}

class FeaturedDataList: Codable {
          
        let title:String?
        let total:Int?
        var contents:[FeaturedDatadetails]?
       
         enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case contents = "contents"
             case total = "total"
          }
       init(
          
            title:String?,
            contents:[FeaturedDatadetails]?,
             total:Int?
           
            
        )
       {
    
        self.title = title
        self.contents = contents
        self.total = total
         
       }
  
}
class FeaturedDatadetails: Codable {
             
     
        
       let title:String?
       let poster:String?
       let movie_uniq_id:String?
       let c_permalink:String?
    let permalink:String?
       let is_fav_status:Int?
       let watch_duration_in_seconds:Int?
       let content_types_id:String?
     //  let custom_meta_data : comedycustom_meta_data
       var custom:ComedyCustomDetails?
    /*
       let video_duration:String?
       let description:String?
       let genres:[String]?
     
      
         
      
    
    */
       enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case poster = "poster"
           case movie_uniq_id = "movie_uniq_id"
           case c_permalink = "c_permalink"
           case is_fav_status = "is_fav_status"
        case permalink = "permalink"
        //   case custom_meta_data = "custom_meta_data"
           case custom = "custom"
           case watch_duration_in_seconds = "watch_duration_in_seconds"
        case content_types_id = "content_types_id"
        /*
           case video_duration = "video_duration_text"
           case description = "story"
           case genres = "genres"
        
           
           */
           
          }
       init(
          
            title:String?,
            poster:String?,
            movie_uniq_id:String?,
            c_permalink:String?,
            permalink:String?,
         //    custom_meta_data: comedycustom_meta_data,
             custom:ComedyCustomDetails?,
            is_fav_status:Int?,
            watch_duration_in_seconds:Int?,
            content_types_id:String?
        /*
            video_duration:String?,
            description:String?,
            genres:[String]?,
           
            
            
            */
        )
       {
    
        self.title = title
        self.poster = poster
        self.movie_uniq_id = movie_uniq_id
        self.c_permalink = c_permalink
        self.permalink = permalink
        self.is_fav_status = is_fav_status
      //  self.custom_meta_data = custom_meta_data
        self.custom = custom
        self.watch_duration_in_seconds = watch_duration_in_seconds
        self.content_types_id = content_types_id
       /*
        
        self.video_duration = video_duration
        self.description = description
        self.genres = genres
        
        self.custom = custom
       */
        
       
        
       }
}
class PodcastData : Codable {
   
       let channel:PodcastDataList?
       
        enum CodingKeys: String, CodingKey
        {
            case channel = "channel"
       }
    init(
        channel:PodcastDataList?
        )
       {
        self.channel = channel
       }
}
class PodcastDataList: Codable
{
       let title:String?
       let itunesimage:String?
       let description:String?
       let language:String?
       let list:[PodcastDataListDetails]?
       
    enum CodingKeys: String, CodingKey
    {
       case title = "title"
       case itunesimage = "itunes:image"
       case description = "description"
       case language = "language"
       case list = "items"
     }
    init(
        title:String?,
        itunesimage:String?,
        description:String?,
        language:String?,
        list:[PodcastDataListDetails]?
        )
    {
        self.title = title
        self.itunesimage = itunesimage
        self.description = description
        self.language = language
        self.list = list
     }
}

class PodcastDataListDetails: Codable {
   
       let title:String?
       let itunesimage:String?
       let description:String?
       let url:String?
       let pubDate:String?
       let duration:String?
        
        enum CodingKeys: String, CodingKey {
           
      
           case title = "title"
           case itunesimage = "itunes:image"
           case description = "description"
           case url = "url"
           case pubDate = "pubDate"
             case duration = "itunes:duration"
            
            
                 
          }
       init(
          
            title:String?,
            itunesimage:String?,
            description:String?,
            url:String?,
            pubDate:String?,
            duration:String?
            
       
        )
       {
    
        self.title = title
        self.itunesimage = itunesimage
        self.description = description
        self.url = url
        self.pubDate = pubDate
        self.duration = duration
         
           
        
       }
}


class NewPodcastData : Codable {
   
       var channel:[NewPodcastDataList]?
       
        enum CodingKeys: String, CodingKey
        {
            case channel = "channel"
       }
    init(
        channel:[NewPodcastDataList]?
        )
       {
        self.channel = channel
       }
}
class NewPodcastDataList: Codable
{
       let title:String?
       let itunesimage:String?
       let description:String?
       let language:String?
       let list:[NewPodcastDataListDetails]?
       
    enum CodingKeys: String, CodingKey
    {
       case title = "title"
       case itunesimage = "itunes:image"
       case description = "description"
       case language = "language"
      case list = "items"
        
    }
    init(
        title:String?,
        itunesimage:String?,
        description:String?,
        language:String?,
        list:[NewPodcastDataListDetails]?
        )
    {
        
        self.title = title
        self.itunesimage = itunesimage
        self.description = description
        self.language = language
        self.list = list
     }
}

class NewPodcastDataListDetails: Codable {
   
          let title:String?
          let itunesimage:String?
          let description:String?
          let url:String?
          let pubDate:String?
          let duration:String?
           
           enum CodingKeys: String, CodingKey {
              
         
              case title = "title"
              case itunesimage = "itunes:image"
              case description = "description"
              case url = "url"
              case pubDate = "pubDate"
                case duration = "itunes:duration"
               
               
                    
             }
          init(
             
               title:String?,
               itunesimage:String?,
               description:String?,
               url:String?,
               pubDate:String?,
               duration:String?
               
          
           )
          {
       
           self.title = title
           self.itunesimage = itunesimage
           self.description = description
           self.url = url
           self.pubDate = pubDate
           self.duration = duration
            
              
           
          }
   }
class AudioPodcastDataList: Codable
{
       let status:String?
       let list:[AudioPodcastDataListDetails]?
       
    enum CodingKeys: String, CodingKey
    {
       case status = "status"
 
      case list = "lists"
        
    }
    init(
        status:String?,
 
        list:[AudioPodcastDataListDetails]?
        )
    {
        
        self.status = status
 
        self.list = list
     }
}


 
class AudioPodcastDataListDetails: Codable {
   
          let title:String?
          let itunesimage:String?
          let c_permalink:String?
          
           enum CodingKeys: String, CodingKey {
              
         
              case title = "title"
              case itunesimage = "poster"
              case c_permalink = "c_permalink"
              
               
                    
             }
          init(
             
               title:String?,
               itunesimage:String?,
               c_permalink:String?
                
               
          
           )
          {
       
           self.title = title
           self.itunesimage = itunesimage
           self.c_permalink = c_permalink
            
           
          }
   }
/*
class Episodedata: Codable {

       let name:String?
       let episode:[EpisodedataDetails]?
       
    enum CodingKeys: String, CodingKey
    {
        case name = "name"
        case episode = "episode"
    }
    init(
        
        name:String?,
        episode:[EpisodedataDetails]?
         )
       {
        self.name = name
        self.episode = episode
        
       }
}
class EpisodedataDetails: Codable {

       let episode_title:String?
       let video_url:String?
       let poster_url:String?
        
        enum CodingKeys: String, CodingKey {
           
      
           case episode_title = "episode_title"
           case video_url = "video_url"
           case poster_url = "poster_url"
          
                 
          }
       init(
          
            episode_title:String?,
            video_url:String?,
            poster_url:String?
            
       
        )
       {
    
        self.episode_title = episode_title
        self.video_url = video_url
        self.poster_url = poster_url
         
           
        
       }
}
*/
class SubcategoryData: Codable {
    let code: Int?
    let status: String?
    let subCategoryList: [SubCategoryList]?

    enum CodingKeys: String, CodingKey {
        case code, status
        case subCategoryList = "sub_category_list"
    }

    init(code: Int?, status: String?, subCategoryList: [SubCategoryList]?) {
        self.code = code
        self.status = status
        self.subCategoryList = subCategoryList
    }
}

// MARK: - SubCategoryList
class SubCategoryList: Codable {
    let subcategoryID, subcatName, permalink: String?
    let subcategoryImgURL: String?
    let subImgSize: [String]?

    enum CodingKeys: String, CodingKey {
        case subcategoryID = "subcategory_id"
        case subcatName = "subcat_name"
        case permalink
        case subcategoryImgURL = "subcategory_img_url"
        case subImgSize = "sub_img_size"
    }

    init(subcategoryID: String?, subcatName: String?, permalink: String?, subcategoryImgURL: String?, subImgSize: [String]?) {
        self.subcategoryID = subcategoryID
        self.subcatName = subcatName
        self.permalink = permalink
        self.subcategoryImgURL = subcategoryImgURL
        self.subImgSize = subImgSize
    }
}
class RadioBannerdata: Codable {
    let success: Int
    let code, message: String
    let radioList: [RadioList]

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case radioList = "RadioList"
    }

    init(success: Int, code: String, message: String, radioList: [RadioList]) {
        self.success = success
        self.code = code
        self.message = message
        self.radioList = radioList
    }
}

// MARK: - RadioList
class RadioList: Codable {
    let radioID, title: String
    let radioURL: String
    let sortOrder: String
    let radioImage: String
    var isFavourite:String

    enum CodingKeys: String, CodingKey {
        case radioID = "radioId"
        case title, radioURL, sortOrder, radioImage
        case isFavourite = "isFavourite"
    }

    init(radioID: String, title: String, radioURL: String, sortOrder: String, radioImage: String,isFavourite:String) {
        self.radioID = radioID
        self.title = title
        self.radioURL = radioURL
        self.sortOrder = sortOrder
        self.radioImage = radioImage
        self.isFavourite = isFavourite
    }
}
 
 
class successFavouriteRadioList: Codable {
    
    let Success: Int
    enum CodingKeys: String, CodingKey {
        case Success = "Success"
        
    }

    init(Success: Int ) {
        self.Success = Success
        
    }
}
// MARK: - FavouriteRadioList
class FavRadiodata: Codable {
    let success: Int
    let code, message: String
    let favouriteRadioList: [FavouriteRadioList]

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case favouriteRadioList = "FavouriteRadioList"
    }

    init(success: Int, code: String, message: String, favouriteRadioList: [FavouriteRadioList]) {
        self.success = success
        self.code = code
        self.message = message
        self.favouriteRadioList = favouriteRadioList
    }
}

// MARK: - FavouriteRadioList
class FavouriteRadioList: Codable
{
    let radioID, title: String
    let radioURL: String
    let sortOrder, radioImage: String
    var isFavourite: String?

    enum CodingKeys: String, CodingKey {
        case radioID = "radioId"
        case title, radioURL, sortOrder, radioImage, isFavourite
    }

    init(radioID: String, title: String, radioURL: String, sortOrder: String, radioImage: String, isFavourite: String?) {
        self.radioID = radioID
        self.title = title
        self.radioURL = radioURL
        self.sortOrder = sortOrder
        self.radioImage = radioImage
        self.isFavourite = isFavourite
    }
}
//registerDeviceToken
class registerDeviceToken: Codable {
    let success: Int?
    let AccessToken : String?
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        
        case AccessToken = "AccessToken"
       
    }

    init(success: Int?,  AccessToken: String? ) {
        self.success = success
        self.AccessToken = AccessToken
       
         
    }
}
class PodcastRssfeeddata: Codable {
    let success: Int?
    let code, message: String?
    let podcastList: [PodcastRssfeeddataList]?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case podcastList = "Podcast List"
    }

    init(success: Int?, code: String?, message: String?, podcastList: [PodcastRssfeeddataList]?) {
        self.success = success
        self.code = code
        self.message = message
        self.podcastList = podcastList
    }
}
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}// MARK: - PodcastList
class PodcastRssfeeddataList: Codable {
    let podcastCategoryID, title,type: String?
    let podcast: [PodcastRssfeeddatadetails]?

    enum CodingKeys: String, CodingKey {
        case podcastCategoryID = "podcastCategoryId"
        case title
        case podcast = "Podcast"
        case type = "Type"
    }

    init(podcastCategoryID: String?, title: String?,type: String?, podcast: [PodcastRssfeeddatadetails]?) {
        self.podcastCategoryID = podcastCategoryID
        self.title = title
        self.podcast = podcast
        self.type = type
    }
}

// MARK: - Podcast
class PodcastRssfeeddatadetails: Codable {
    let podcastID, podcastDescription: String?
    let image: String?
    let podcastURL: String?
    let title, pubDate: String?
    let type: TypeUnion

    enum CodingKeys: String, CodingKey {
        case podcastID = "podcastId"
        case podcastDescription = "description"
        case image
        case podcastURL = "podcastUrl"
        case title, pubDate
        case type = "Type"
    }

    init(podcastID: String, podcastDescription: String, image: String, podcastURL: String, title: String, pubDate: String,type:TypeUnion ) {
        self.podcastID = podcastID
        self.podcastDescription = podcastDescription
        self.image = image
        self.podcastURL = podcastURL
        self.title = title
        self.pubDate = pubDate
        self.type = type
    }
}

enum TypeUnion: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(TypeUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TypeUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

class FavouriteRadioData: Codable {
    let success: Int
    let code, message: String
    let favouriteRadioList: [DataFavouriteRadioList]

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case favouriteRadioList = "FavouriteRadioList"
    }

    init(success: Int, code: String, message: String, favouriteRadioList: [DataFavouriteRadioList]) {
        self.success = success
        self.code = code
        self.message = message
        self.favouriteRadioList = favouriteRadioList
    }
}

// MARK: - FavouriteRadioList
class DataFavouriteRadioList: Codable {
    let radioID, radioFavouriteID, title: String
    let radioURL: String
    let sortOrder: String
    let radioImage: String
    let userID, isFavourite: String

    enum CodingKeys: String, CodingKey {
        case radioID = "radioId"
        case radioFavouriteID = "radioFavouriteId"
        case title, radioURL, sortOrder, radioImage
        case userID = "userId"
        case isFavourite
    }

    init(radioID: String, radioFavouriteID: String, title: String, radioURL: String, sortOrder: String, radioImage: String, userID: String, isFavourite: String) {
        self.radioID = radioID
        self.radioFavouriteID = radioFavouriteID
        self.title = title
        self.radioURL = radioURL
        self.sortOrder = sortOrder
        self.radioImage = radioImage
        self.userID = userID
        self.isFavourite = isFavourite
    }
}
class IsfavRadio: Codable {
    let success: Int?
    let code, message: String?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
    }

    init(success: Int?, code: String?, message: String?) {
        self.success = success
        self.code = code
        self.message = message
    }
}
class LiveTVData: Codable {
    let success: Int?
    let code, message: String?
    let liveTvCategoriesList: [LiveTvCategoriesList]?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case liveTvCategoriesList = "LiveTvCategoriesList"
    }

    init(success: Int?, code: String?, message: String?, liveTvCategoriesList: [LiveTvCategoriesList]?) {
        self.success = success
        self.code = code
        self.message = message
        self.liveTvCategoriesList = liveTvCategoriesList
    }
}

// MARK: - LiveTvCategoriesList
class LiveTvCategoriesList: Codable {
    let liveTvCategroryID, title: String?
    let liveTvList: [LiveTvListdetails]?

    enum CodingKeys: String, CodingKey {
        case liveTvCategroryID = "liveTvCategroryId"
        case title
        case liveTvList = "LiveTvList"
    }

    init(liveTvCategroryID: String?, title: String?, liveTvList: [LiveTvListdetails]?) {
        self.liveTvCategroryID = liveTvCategroryID
        self.title = title
        self.liveTvList = liveTvList
    }
}

// MARK: - LiveTvList
class LiveTvListdetails: Codable {
    let liveTvID, liveTvCategroryID, liveTvCategroryName, liveTvListDescription: String?
    let tvImage: String?
    let shareLink: String?
    let source: String?
    var title, sortOrder, isFavourite: String?

    enum CodingKeys: String, CodingKey {
        case liveTvID = "liveTvId"
        case liveTvCategroryID = "liveTvCategroryId"
        case liveTvCategroryName
        case liveTvListDescription = "description"
        case tvImage, shareLink, source, title, sortOrder, isFavourite
    }

    init(liveTvID: String?, liveTvCategroryID: String?, liveTvCategroryName: String?, liveTvListDescription: String?, tvImage: String?, shareLink: String?, source: String?, title: String?, sortOrder: String?, isFavourite: String?) {
        self.liveTvID = liveTvID
        self.liveTvCategroryID = liveTvCategroryID
        self.liveTvCategroryName = liveTvCategroryName
        self.liveTvListDescription = liveTvListDescription
        self.tvImage = tvImage
        self.shareLink = shareLink
        self.source = source
        self.title = title
        self.sortOrder = sortOrder
        self.isFavourite = isFavourite
    }
}
class SpecififcLiveTVData: Codable {
    let success: Int?
    let code, message, totalLiveTVUnderCategory: String?
    var specificCategoryWiseLiveTv: [SpecificCategoryWiseLiveTv]?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case totalLiveTVUnderCategory = "totalLiveTvUnderCategory"
        case specificCategoryWiseLiveTv = "specificCategoryWiseLiveTv"
    }

    init(success: Int?, code: String?, message: String?, totalLiveTVUnderCategory: String?, specificCategoryWiseLiveTv: [SpecificCategoryWiseLiveTv]?) {
        self.success = success
        self.code = code
        self.message = message
        self.totalLiveTVUnderCategory = totalLiveTVUnderCategory
        self.specificCategoryWiseLiveTv = specificCategoryWiseLiveTv
    }
}

// MARK: - SpecificCategoryWiseLiveTv
class SpecificCategoryWiseLiveTv: Codable {
    let liveTvID, liveTvCategroryID, title: String?
    let shareLink: String?
    let sortOrder: String?
    let source: String?
    let userID: String?
    var tvImage,isFavourite: String?
    let specificCategoryWiseLiveTvDescription: String?

    enum CodingKeys: String, CodingKey {
        case liveTvID = "liveTvId"
        case liveTvCategroryID = "liveTvCategroryId"
        case title, shareLink, sortOrder, source
        case userID = "userId"
        case tvImage
        case specificCategoryWiseLiveTvDescription = "description"
        case isFavourite = "isFavourite"
    }

    init(liveTvID: String?, liveTvCategroryID: String?, title: String?, shareLink: String?, sortOrder: String?, source: String?, userID: String?, tvImage: String?, specificCategoryWiseLiveTvDescription: String?,isFavourite:String?) {
        self.liveTvID = liveTvID
        self.liveTvCategroryID = liveTvCategroryID
        self.title = title
        self.shareLink = shareLink
        self.sortOrder = sortOrder
        self.source = source
        self.userID = userID
        self.tvImage = tvImage
        self.isFavourite = isFavourite
        self.specificCategoryWiseLiveTvDescription = specificCategoryWiseLiveTvDescription
    }
}
class FavLiveTVData: Codable {
    let success: Int
    let code, message: String
    let liveTvFavouriteCategoriesList: [LiveTvFavouriteCategoriesList]

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case liveTvFavouriteCategoriesList = "LiveTvFavouriteCategoriesList"
    }

    init(success: Int, code: String, message: String, liveTvFavouriteCategoriesList: [LiveTvFavouriteCategoriesList]) {
        self.success = success
        self.code = code
        self.message = message
        self.liveTvFavouriteCategoriesList = liveTvFavouriteCategoriesList
    }
}

// MARK: - LiveTvFavouriteCategoriesList
class LiveTvFavouriteCategoriesList: Codable {
    let liveTvID, liveTvCategroryID, title, liveTvFavouriteCategoriesListDescription: String
    let shareLink: String
    let sortOrder: String
    let source: String
    let userID: String
    let tvImage: String
    var isFavourite: String

    enum CodingKeys: String, CodingKey {
        case liveTvID = "liveTvId"
        case liveTvCategroryID = "liveTvCategroryId"
        case title
        case liveTvFavouriteCategoriesListDescription = "description"
        case shareLink, sortOrder, source
        case userID = "userId"
        case tvImage, isFavourite
    }

    init(liveTvID: String, liveTvCategroryID: String, title: String, liveTvFavouriteCategoriesListDescription: String, shareLink: String, sortOrder: String, source: String, userID: String, tvImage: String, isFavourite: String) {
        self.liveTvID = liveTvID
        self.liveTvCategroryID = liveTvCategroryID
        self.title = title
        self.liveTvFavouriteCategoriesListDescription = liveTvFavouriteCategoriesListDescription
        self.shareLink = shareLink
        self.sortOrder = sortOrder
        self.source = source
        self.userID = userID
        self.tvImage = tvImage
        self.isFavourite = isFavourite
    }
}
class PPVplans: Codable {
    let code: Int
    let status, msg: String
    let isSubscribed: Int
    let canSaveCard, gatewayShortCode, currencyID, currencySymbol: String
    let plan: [Plan]

    enum CodingKeys: String, CodingKey {
        case code, status, msg
        case isSubscribed = "is_subscribed"
        case canSaveCard = "can_save_card"
        case gatewayShortCode = "gateway_short_code"
        case currencyID = "currency_id"
        case currencySymbol = "currency_symbol"
        case plan
    }

    init(code: Int, status: String, msg: String, isSubscribed: Int, canSaveCard: String, gatewayShortCode: String, currencyID: String, currencySymbol: String, plan: [Plan]) {
        self.code = code
        self.status = status
        self.msg = msg
        self.isSubscribed = isSubscribed
        self.canSaveCard = canSaveCard
        self.gatewayShortCode = gatewayShortCode
        self.currencyID = currencyID
        self.currencySymbol = currencySymbol
        self.plan = plan
    }
}

// MARK: - Plan
class Plan: Codable {
    let planID, externalID, planName, priceForSubscribed: String
    let priceForUnsubscribed, showSubscribedPrice, seasonSubscribedPrice, episodeSubscribedPrice: String
    let showUnsubscribedPrice, seasonUnsubscribedPrice, episodeUnsubscribedPrice: String

    enum CodingKeys: String, CodingKey {
        case planID = "plan_id"
        case externalID = "external_id"
        case planName = "plan_name"
        case priceForSubscribed = "price_for_subscribed"
        case priceForUnsubscribed = "price_for_unsubscribed"
        case showSubscribedPrice = "show_subscribed_price"
        case seasonSubscribedPrice = "season_subscribed_price"
        case episodeSubscribedPrice = "episode_subscribed_price"
        case showUnsubscribedPrice = "show_unsubscribed_price"
        case seasonUnsubscribedPrice = "season_unsubscribed_price"
        case episodeUnsubscribedPrice = "episode_unsubscribed_price"
    }

    init(planID: String, externalID: String, planName: String, priceForSubscribed: String, priceForUnsubscribed: String, showSubscribedPrice: String, seasonSubscribedPrice: String, episodeSubscribedPrice: String, showUnsubscribedPrice: String, seasonUnsubscribedPrice: String, episodeUnsubscribedPrice: String) {
        self.planID = planID
        self.externalID = externalID
        self.planName = planName
        self.priceForSubscribed = priceForSubscribed
        self.priceForUnsubscribed = priceForUnsubscribed
        self.showSubscribedPrice = showSubscribedPrice
        self.seasonSubscribedPrice = seasonSubscribedPrice
        self.episodeSubscribedPrice = episodeSubscribedPrice
        self.showUnsubscribedPrice = showUnsubscribedPrice
        self.seasonUnsubscribedPrice = seasonUnsubscribedPrice
        self.episodeUnsubscribedPrice = episodeUnsubscribedPrice
    }
}
class Appversion: Codable {
    let success: Int
    let code, message, deviceVersion: String

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case deviceVersion = "DeviceVersion"
    }

    init(success: Int, code: String, message: String, deviceVersion: String) {
        self.success = success
        self.code = code
        self.message = message
        self.deviceVersion = deviceVersion
    }
}
class Youtubepodcast: Codable {
    let items: [Item]

    init(items: [Item]) {
        self.items = items
    }
}

// MARK: - Item
class Item: Codable {
    let snippet: Snippet?

    init(snippet: Snippet?) {
        self.snippet = snippet
    }
}

// MARK: - Snippet
class Snippet: Codable {
    let channelID, title, snippetDescription: String?
    let thumbnails: Thumbnails?
    let channelTitle, playlistID: String?
    let resourceID: ResourceID?
    let videoOwnerChannelTitle, videoOwnerChannelID: String?

    enum CodingKeys: String, CodingKey {
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle
        case playlistID = "playlistId"
        case resourceID = "resourceId"
        case videoOwnerChannelTitle
        case videoOwnerChannelID = "videoOwnerChannelId"
    }

    init(channelID: String?, title: String?, snippetDescription: String?, thumbnails: Thumbnails?, channelTitle: String?, playlistID: String?,  resourceID: ResourceID?, videoOwnerChannelTitle: String?, videoOwnerChannelID: String?) {
        self.channelID = channelID
        self.title = title
        self.snippetDescription = snippetDescription
        self.thumbnails = thumbnails
        self.channelTitle = channelTitle
        self.playlistID = playlistID
        self.resourceID = resourceID
        self.videoOwnerChannelTitle = videoOwnerChannelTitle
        self.videoOwnerChannelID = videoOwnerChannelID
    }
}

// MARK: - ResourceID
class ResourceID: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }

    init(kind: String, videoID: String) {
        self.kind = kind
        self.videoID = videoID
    }
}

// MARK: - Thumbnails
class Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }

    init(thumbnailsDefault: Default, medium: Default, high: Default) {
        self.thumbnailsDefault = thumbnailsDefault
        self.medium = medium
        self.high = high
    }
}

// MARK: - Default
class Default: Codable {
    let url: String
    let width, height: Int

    init(url: String, width: Int, height: Int) {
        self.url = url
        self.width = width
        self.height = height
    }
}
class CategoryPodcastdata: Codable {
    let success: Int
    let code, message, podcastCount: String
    let podcastList: [PodcastList]

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case podcastCount = "Podcast Count"
        case podcastList = "Podcast List"
    }

    init(success: Int, code: String, message: String, podcastCount: String, podcastList: [PodcastList]) {
        self.success = success
        self.code = code
        self.message = message
        self.podcastCount = podcastCount
        self.podcastList = podcastList
    }
}

// MARK: - PodcastList
class PodcastList: Codable {
    let podcastID, podcastListDescription: String
    let image: String
    let podcastURL: String
    let title, pubDate, type: String

    enum CodingKeys: String, CodingKey {
        case podcastID = "podcastId"
        case podcastListDescription = "description"
        case image
        case podcastURL = "podcastUrl"
        case title, pubDate
        case type = "Type"
    }

    init(podcastID: String, podcastListDescription: String, image: String, podcastURL: String, title: String, pubDate: String, type: String) {
        self.podcastID = podcastID
        self.podcastListDescription = podcastListDescription
        self.image = image
        self.podcastURL = podcastURL
        self.title = title
        self.pubDate = pubDate
        self.type = type
    }
}
