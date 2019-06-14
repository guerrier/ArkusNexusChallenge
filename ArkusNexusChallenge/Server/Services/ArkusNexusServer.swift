//
//  ArkusNexusServer.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import RxSwift
import RxAlamofire
import Alamofire
import ObjectMapper

public final class ArkusNexusServer<N: BaseMappable> {
    public func request(_ request: URLRequestConvertible) -> Observable<N> {
        return RxAlamofire.request(request)
            .responseJSON().validateResponse().map({ (dataResponse) -> N in
                return try self.map(data: dataResponse)
            })
    }
    
    public func arrayRequest(_ request: URLRequestConvertible) -> Observable<[N]> {
        return RxAlamofire.request(request)
            .responseJSON().validateResponse().map({ (dataResponse) -> [N] in
                return try self.arrayMap(data: dataResponse)
            })
    }
    
    public func dictionaryRequest(_ request: URLRequestConvertible) -> Observable<[String:N]> {
        return RxAlamofire.request(request)
            .responseJSON().validateResponse().map({ (dataResponse) -> [String:N] in
                return try self.dictionaryMap(data: dataResponse)
            })
    }
    
    private func errorMap(data: DataResponse<Any>) throws {
        if let json = data.result.value as? [String: Any],
            let errorModel = Mapper<ErrorModel>().map(JSONObject: json),
            json.keys.contains("context"),
            errorModel.message != nil {
            throw errorModel
        }
    }
    
    private func map(data: DataResponse<Any>) throws -> N {
        if N.self != SuccessMessageResponse.self || data.response?.statusCode != 200 {
            try errorMap(data: data)
        }
        if let value = data.result.value, value is NSNull, N.self == EmptyResponse.self {
            let dictionary: [String:Any] = [:]
            guard let parseModel = Mapper<N>().map(JSONObject: dictionary) else {
                throw ErrorModel.parseError()
            }
            return parseModel
        } else {
            guard let parseModel = Mapper<N>().map(JSONObject: data.result.value) else {
                throw ErrorModel.parseError()
            }
            return parseModel
        }
    }
    
    private func arrayMap(data: DataResponse<Any>) throws -> [N] {
        try errorMap(data: data)
        guard let parseModel = Mapper<N>().mapArray(JSONObject: data.result.value) else {
            if let array = Mapper<EmptyResponse>().mapArray(JSONObject: data.result.value) {
                if (array.count == 0) {
                    return []
                }
            }
            throw ErrorModel.parseError()
        }
        return parseModel
    }
    
    private func dictionaryMap(data: DataResponse<Any>) throws -> [String:N] {
        try errorMap(data: data)
        guard let parseModel = Mapper<N>().mapDictionary(JSONObject: data.result.value) else {
            if let array = Mapper<EmptyResponse>().mapArray(JSONObject: data.result.value) {
                if (array.count == 0) {
                    return [:]
                }
            }
            throw ErrorModel.parseError()
        }
        return parseModel
    }
}
