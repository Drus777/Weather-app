//
//  APIService.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

final class APIService {
    
    private let dataSession: URLSession
    
    init() {
        dataSession = URLSession(configuration: URLSessionConfiguration.default)
    }
}

// MARK: - Public

extension APIService {
    
    func loadData<T: Codable>(host: String? = nil, endpoint: String, method: HTTPMethod, parameters: [URLQueryItem], apiKey: String? = nil, lang: String? = nil, units: String? = nil, body: Data? = nil, responseModel: T.Type, _ completion: @escaping (Result<T?, Error>) -> Void) {
        
        guard let url = url(for: host ?? Hosts.openweathermap.rawValue, endpoint: endpoint, apiKey: apiKey ?? ApiKeys.mainKey.rawValue, lang: lang ?? Lang.ru.rawValue, units: units ?? Units.metric.rawValue, parameters: parameters)
        else { return }
        let request = request(url: url, method: method, body: body)
        dataSession.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let result = try? JSONDecoder().decode(responseModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

// MARK: - Private

private extension APIService {
    
    func url(for host: String, endpoint: String, apiKey: String, lang: String, units: String, parameters: [URLQueryItem]) -> URL? {
        
        guard let path = [host, endpoint].joined().encodeUrl(),
              var components = URLComponents(string: path)
        else { return nil }
        
        let generalParameters: [URLQueryItem] = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "lang", value: lang),
            URLQueryItem(name: "units", value: units)
        ]
        
        let parameters = parameters + generalParameters
        if !parameters.isEmpty {
            components.queryItems = parameters
        }
        return components.url
    }
    
    func request(url: URL, method: HTTPMethod, body: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields?[Constant.contentTypeHeader] = Constant.contentTypeHeader
        request.allHTTPHeaderFields?[Constant.responseContentType] = Constant.contentType
        
        if let body = body {
            request.allHTTPHeaderFields?[Constant.contentSizeHeader] = "\(body.count)"
            request.httpBody = body
        }
        
        return request
    }
}

// MARK: - Constants

private extension APIService {
    
    enum Constant {
        static let contentTypeHeader = "Content-Type"
        static let contentType = "application/json"
        static let responseContentType = "Accept"
        static let contentSizeHeader = "Content-Length"
    }
}

// MARK: - String

fileprivate extension String {
    
    func encodeUrl() -> String? {
        let pureString = self.removingPercentEncoding
        return pureString?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
}
