//
//  SearchResult.swift
//  GoodBoye
//
//  Created by Envoy on 4/7/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var type : String?
    var displayRecipeSourcesBadges : Bool?
    var displayShoppingSourcesBadges : Bool?
    var instrumentation : Instrumentation?
    var nextOffsetAddCount : Int?
    var pivotSuggestions : [PivotSuggestion]?
    var queryExpansions : [Suggestion]?
    var readLink : String?
    var totalEstimatedMatches : Int?
    var value : [Value]?
    var webSearchUrl : String?
    var webSearchUrlPingSuffix : String?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case displayRecipeSourcesBadges
        case displayShoppingSourcesBadges
        case instrumentation
        case nextOffsetAddCount
        case pivotSuggestions
        case queryExpansions
        case readLink
        case totalEstimatedMatches
        case value
        case webSearchUrl
        case webSearchUrlPingSuffix
    }
}

struct Value: Codable {
    var accentColor : String?
    var contentSize : String?
    var contentUrl : String?
    var datePublished : String?
    var encodingFormat : String?
    var height : Int?
    var hostPageDisplayUrl : String?
    var hostPageUrl : String?
    var hostPageUrlPingSuffix : String?
    var imageId : String?
    var imageInsightsToken : String?
    var insightsSourcesSummary : InsightsSourcesSummary?
    var name : String?
    var thumbnail : Thumbnail?
    var thumbnailUrl : String?
    var webSearchUrl : String?
    var webSearchUrlPingSuffix : String?
    var width : Int?
}

struct InsightsSourcesSummary: Codable {
    var recipeSourcesCount : Int?
    var shoppingSourcesCount : Int?
}

struct PivotSuggestion: Codable {
    var pivot : String?
    var suggestions : [Suggestion]?
}

struct Suggestion: Codable {
    var displayText : String?
    var searchLink : String?
    var text : String?
    var thumbnail : Thumbnail?
    var webSearchUrl : String?
    var webSearchUrlPingSuffix : String?
}

struct Thumbnail: Codable {
    var thumbnailUrl : String?
    var height : Int?
    var width : Int?
}

struct Instrumentation: Codable {
    var pageLoadPingUrl : String?
    var pingUrlBase : String?
}
