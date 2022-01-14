//
//  APIService.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

class APIService {
    
    private let dataSession: URLSession
    
    private let host = "https://api.openweathermap.org/"
    private let apiKey = "3d643e7a730a87feb1f52a47323647d9"
    
    private var generalParameters: [URLQueryItem] {
        return [
            URLQueryItem(name: "appid", value: apiKey)
        ]
    }
    
    init() {
        dataSession = URLSession(configuration: URLSessionConfiguration.default)
    }
}

// MARK: - Public

extension APIService {
    
    func loadData<T: Codable>(endpoint: String, method: HTTPMethod, parameters: [URLQueryItem], body: Data? = nil, responceModel: T.Type, _ completion: @escaping (Result<T?, Error>) -> Void) {
        guard let url = url(for: host, endpoint: endpoint, parameters: parameters) else { return }
        let request = request(url: url, method: method, body: body)
        dataSession.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let result = try? JSONDecoder().decode(responceModel.self, from: data)
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
    
    func url(for host: String, endpoint: String, parameters: [URLQueryItem]) -> URL? {
        
        guard
            let path = [host, endpoint].joined().encodeUrl(),
            var components = URLComponents(string: path)
        else { return nil }
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
