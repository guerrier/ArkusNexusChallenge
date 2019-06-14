//
//  RxAlamofireUtils.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import ObjectMapper

extension ObservableType where Self.E == Alamofire.DataResponse<Any> {
    
    public func validateResponse() -> Observable<DataResponse<Any>> {
        return self.map({ (dataResponse) -> DataResponse<Any> in
            if let response = dataResponse.response {
                if response.statusCode == 401 {
                    throw ErrorModel.notAuthorized()
                } else if response.statusCode > 501 {
                    throw ErrorModel.notAllowedOperation()
                } else if response.statusCode > 400 {
                    if let json = dataResponse.result.value as? [String: Any],
                        let errorModel = Mapper<ErrorModel>().map(JSONObject: json),
                        json.keys.contains("context"),
                        errorModel.message != nil {
                        throw errorModel
                    }
                    throw ErrorModel.parseError()
                }
            }
            return dataResponse
        })
    }
}
