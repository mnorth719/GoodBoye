//
//  SearchResult.swift
//  GoodBoye
//
//  Created by Envoy on 4/7/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import Foundation

class SearchResult {
    var type : String!
    var displayRecipeSourcesBadges : Bool!
    var displayShoppingSourcesBadges : Bool!
    var instrumentation : Instrumentation!
    var nextOffsetAddCount : Int!
    var pivotSuggestions : [PivotSuggestion]!
    var queryExpansions : [Suggestion]!
    var readLink : String!
    var totalEstimatedMatches : Int!
    var value : [Value]!
    var webSearchUrl : String!
    var webSearchUrlPingSuffix : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        type = dictionary["_type"] as? String
        displayRecipeSourcesBadges = dictionary["displayRecipeSourcesBadges"] as? Bool
        displayShoppingSourcesBadges = dictionary["displayShoppingSourcesBadges"] as? Bool
        if let instrumentationData = dictionary["instrumentation"] as? [String:Any]{
            instrumentation = Instrumentation(fromDictionary: instrumentationData)
        }
        nextOffsetAddCount = dictionary["nextOffsetAddCount"] as? Int
        pivotSuggestions = [PivotSuggestion]()
        if let pivotSuggestionsArray = dictionary["pivotSuggestions"] as? [[String:Any]]{
            for dic in pivotSuggestionsArray{
                let value = PivotSuggestion(fromDictionary: dic)
                pivotSuggestions.append(value)
            }
        }
        queryExpansions = [Suggestion]()
        if let queryExpansionsArray = dictionary["queryExpansions"] as? [[String:Any]]{
            for dic in queryExpansionsArray{
                let value = Suggestion(fromDictionary: dic)
                queryExpansions.append(value)
            }
        }
        readLink = dictionary["readLink"] as? String
        totalEstimatedMatches = dictionary["totalEstimatedMatches"] as? Int
        value = [Value]()
        if let valueArray = dictionary["value"] as? [[String:Any]]{
            for dic in valueArray{
                let valueDict = Value(fromDictionary: dic)
                value.append(valueDict)
            }
        }
        webSearchUrl = dictionary["webSearchUrl"] as? String
        webSearchUrlPingSuffix = dictionary["webSearchUrlPingSuffix"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if type != nil{
            dictionary["_type"] = type
        }
        if displayRecipeSourcesBadges != nil{
            dictionary["displayRecipeSourcesBadges"] = displayRecipeSourcesBadges
        }
        if displayShoppingSourcesBadges != nil{
            dictionary["displayShoppingSourcesBadges"] = displayShoppingSourcesBadges
        }
        if instrumentation != nil{
            dictionary["instrumentation"] = instrumentation.toDictionary()
        }
        if nextOffsetAddCount != nil{
            dictionary["nextOffsetAddCount"] = nextOffsetAddCount
        }
        if pivotSuggestions != nil{
            var dictionaryElements = [[String:Any]]()
            for pivotSuggestionsElement in pivotSuggestions {
                dictionaryElements.append(pivotSuggestionsElement.toDictionary())
            }
            dictionary["pivotSuggestions"] = dictionaryElements
        }
        if queryExpansions != nil{
            var dictionaryElements = [[String:Any]]()
            for queryExpansionsElement in queryExpansions {
                dictionaryElements.append(queryExpansionsElement.toDictionary())
            }
            dictionary["queryExpansions"] = dictionaryElements
        }
        if readLink != nil{
            dictionary["readLink"] = readLink
        }
        if totalEstimatedMatches != nil{
            dictionary["totalEstimatedMatches"] = totalEstimatedMatches
        }
        if value != nil{
            var dictionaryElements = [[String:Any]]()
            for valueElement in value {
                dictionaryElements.append(valueElement.toDictionary())
            }
            dictionary["value"] = dictionaryElements
        }
        if webSearchUrl != nil{
            dictionary["webSearchUrl"] = webSearchUrl
        }
        if webSearchUrlPingSuffix != nil{
            dictionary["webSearchUrlPingSuffix"] = webSearchUrlPingSuffix
        }
        return dictionary
    }
    
}

struct Value{
    
    var accentColor : String!
    var contentSize : String!
    var contentUrl : String!
    var datePublished : String!
    var encodingFormat : String!
    var height : Int!
    var hostPageDisplayUrl : String!
    var hostPageUrl : String!
    var hostPageUrlPingSuffix : String!
    var imageId : String!
    var imageInsightsToken : String!
    var insightsSourcesSummary : InsightsSourcesSummary!
    var name : String!
    var thumbnail : Thumbnail!
    var thumbnailUrl : String!
    var webSearchUrl : String!
    var webSearchUrlPingSuffix : String!
    var width : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        accentColor = dictionary["accentColor"] as? String
        contentSize = dictionary["contentSize"] as? String
        contentUrl = dictionary["contentUrl"] as? String
        datePublished = dictionary["datePublished"] as? String
        encodingFormat = dictionary["encodingFormat"] as? String
        height = dictionary["height"] as? Int
        hostPageDisplayUrl = dictionary["hostPageDisplayUrl"] as? String
        hostPageUrl = dictionary["hostPageUrl"] as? String
        hostPageUrlPingSuffix = dictionary["hostPageUrlPingSuffix"] as? String
        imageId = dictionary["imageId"] as? String
        imageInsightsToken = dictionary["imageInsightsToken"] as? String
        if let insightsSourcesSummaryData = dictionary["insightsSourcesSummary"] as? [String:Any]{
            insightsSourcesSummary = InsightsSourcesSummary(fromDictionary: insightsSourcesSummaryData)
        }
        name = dictionary["name"] as? String
        if let thumbnailData = dictionary["thumbnail"] as? [String:Any]{
            thumbnail = Thumbnail(fromDictionary: thumbnailData)
        }
        thumbnailUrl = dictionary["thumbnailUrl"] as? String
        webSearchUrl = dictionary["webSearchUrl"] as? String
        webSearchUrlPingSuffix = dictionary["webSearchUrlPingSuffix"] as? String
        width = dictionary["width"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accentColor != nil{
            dictionary["accentColor"] = accentColor
        }
        if contentSize != nil{
            dictionary["contentSize"] = contentSize
        }
        if contentUrl != nil{
            dictionary["contentUrl"] = contentUrl
        }
        if datePublished != nil{
            dictionary["datePublished"] = datePublished
        }
        if encodingFormat != nil{
            dictionary["encodingFormat"] = encodingFormat
        }
        if height != nil{
            dictionary["height"] = height
        }
        if hostPageDisplayUrl != nil{
            dictionary["hostPageDisplayUrl"] = hostPageDisplayUrl
        }
        if hostPageUrl != nil{
            dictionary["hostPageUrl"] = hostPageUrl
        }
        if hostPageUrlPingSuffix != nil{
            dictionary["hostPageUrlPingSuffix"] = hostPageUrlPingSuffix
        }
        if imageId != nil{
            dictionary["imageId"] = imageId
        }
        if imageInsightsToken != nil{
            dictionary["imageInsightsToken"] = imageInsightsToken
        }
        if insightsSourcesSummary != nil{
            dictionary["insightsSourcesSummary"] = insightsSourcesSummary.toDictionary()
        }
        if name != nil{
            dictionary["name"] = name
        }
        if thumbnail != nil{
            dictionary["thumbnail"] = thumbnail.toDictionary()
        }
        if thumbnailUrl != nil{
            dictionary["thumbnailUrl"] = thumbnailUrl
        }
        if webSearchUrl != nil{
            dictionary["webSearchUrl"] = webSearchUrl
        }
        if webSearchUrlPingSuffix != nil{
            dictionary["webSearchUrlPingSuffix"] = webSearchUrlPingSuffix
        }
        if width != nil{
            dictionary["width"] = width
        }
        return dictionary
    }
    
}

struct InsightsSourcesSummary{
    
    var recipeSourcesCount : Int!
    var shoppingSourcesCount : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        recipeSourcesCount = dictionary["recipeSourcesCount"] as? Int
        shoppingSourcesCount = dictionary["shoppingSourcesCount"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if recipeSourcesCount != nil{
            dictionary["recipeSourcesCount"] = recipeSourcesCount
        }
        if shoppingSourcesCount != nil{
            dictionary["shoppingSourcesCount"] = shoppingSourcesCount
        }
        return dictionary
    }
    
}

struct PivotSuggestion{
    
    var pivot : String!
    var suggestions : [Suggestion]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        pivot = dictionary["pivot"] as? String
        suggestions = [Suggestion]()
        if let suggestionsArray = dictionary["suggestions"] as? [[String:Any]]{
            for dic in suggestionsArray{
                let value = Suggestion(fromDictionary: dic)
                suggestions.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if pivot != nil{
            dictionary["pivot"] = pivot
        }
        if suggestions != nil{
            var dictionaryElements = [[String:Any]]()
            for suggestionsElement in suggestions {
                dictionaryElements.append(suggestionsElement.toDictionary())
            }
            dictionary["suggestions"] = dictionaryElements
        }
        return dictionary
    }
    
}

struct Suggestion{
    
    var displayText : String!
    var searchLink : String!
    var text : String!
    var thumbnail : Thumbnail!
    var webSearchUrl : String!
    var webSearchUrlPingSuffix : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        displayText = dictionary["displayText"] as? String
        searchLink = dictionary["searchLink"] as? String
        text = dictionary["text"] as? String
        if let thumbnailData = dictionary["thumbnail"] as? [String:Any]{
            thumbnail = Thumbnail(fromDictionary: thumbnailData)
        }
        webSearchUrl = dictionary["webSearchUrl"] as? String
        webSearchUrlPingSuffix = dictionary["webSearchUrlPingSuffix"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if displayText != nil{
            dictionary["displayText"] = displayText
        }
        if searchLink != nil{
            dictionary["searchLink"] = searchLink
        }
        if text != nil{
            dictionary["text"] = text
        }
        if thumbnail != nil{
            dictionary["thumbnail"] = thumbnail.toDictionary()
        }
        if webSearchUrl != nil{
            dictionary["webSearchUrl"] = webSearchUrl
        }
        if webSearchUrlPingSuffix != nil{
            dictionary["webSearchUrlPingSuffix"] = webSearchUrlPingSuffix
        }
        return dictionary
    }
    
}

struct Thumbnail{
    
    var thumbnailUrl : String!
    var height : Int!
    var width : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        thumbnailUrl = dictionary["thumbnailUrl"] as? String
        height = dictionary["height"] as? Int
        width = dictionary["width"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if thumbnailUrl != nil{
            dictionary["thumbnailUrl"] = thumbnailUrl
        }
        if height != nil{
            dictionary["height"] = height
        }
        if width != nil{
            dictionary["width"] = width
        }
        return dictionary
    }
}

struct Instrumentation{
    
    var pageLoadPingUrl : String!
    var pingUrlBase : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        pageLoadPingUrl = dictionary["pageLoadPingUrl"] as? String
        pingUrlBase = dictionary["pingUrlBase"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if pageLoadPingUrl != nil{
            dictionary["pageLoadPingUrl"] = pageLoadPingUrl
        }
        if pingUrlBase != nil{
            dictionary["pingUrlBase"] = pingUrlBase
        }
        return dictionary
    }
    
}
