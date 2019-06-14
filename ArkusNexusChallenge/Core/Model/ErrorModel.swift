//
//  ErrorModel.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import ObjectMapper
import Localize

struct ErrorModel: Mappable, Error, LocalizedError {
    
    var context: AnyObject?
    var message: String?
    
    init(context: AnyObject? = nil, message: String) {
        self.context = context
        self.message = message
    }
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        context <- map["context"]
        message <- map["message"]
    }
    
    static func parseError() -> ErrorModel {
        let message: String = "generic-error-parse-response".localized
        return ErrorModel(message: message)
    }
    
    static func notAuthorized() -> ErrorModel {
        let message: String = "error-not-authorized".localized
        return ErrorModel(message: message)
    }
    
    static func notAllowedOperation() -> ErrorModel {
        let message: String = "generic-error-try-later".localized
        return ErrorModel(message: message)
    }
    
    var description: String {
        return "ErrorModel: {\(String(describing: context)), \(String(describing: message))}"
    }
    
    var localizedTitle: String {
        return message != nil ? message! : ""
    }
    
    var errorDescription: String? {
        get {
            var returnMessage: String = ""
            if context != nil, let dictContext = context as? [String:[String]] {
                for messagesContext in dictContext.values {
                    for messageContext in messagesContext {
                        returnMessage.append(messageContext)
                        returnMessage.append("\n")
                    }
                }
            } else if let errorMesssage = message {
                returnMessage = errorMesssage
            }
            return returnMessage
        }
    }
    
}
