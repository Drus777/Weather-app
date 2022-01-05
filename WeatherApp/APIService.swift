//
//  APIService.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

class APIService {
    
    let dataSession: URLSession
    
    let langValue = "ru"
    let unitsValue = "metric"
    let apiKey = "3d643e7a730a87feb1f52a47323647d9"
    
    private var generalParameters: [URLQueryItem] {
        return [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: unitsValue),
            URLQueryItem(name: "lang", value: langValue)
        ]
    }
    
    init() {
        dataSession = URLSession(configuration: URLSessionConfiguration.default)
    }
}

// MARK: - Public

extension APIService {
    
    func loadData<T: Codable>(host: String, endpoint: String, method: HTTPMethod, parameters: [URLQueryItem], body: Data? = nil, model: T.Type, _ completion: @escaping (Result<T?, Error>) -> Void) {
        
        guard let url = url(for: host, endpoint: endpoint, parameters: parameters) else { return }
        let request = request(url: url, method: method, body: body)
        dataSession.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let result = try? JSONDecoder().decode(model.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: - Private

private extension APIService {
    
    func url(for host: String, endpoint: String, parameters: [URLQueryItem]) -> URL? {
        let path = [host, endpoint].joined().encodeUrl() ?? ""
        let parameters = parameters + generalParameters
        guard var components = URLComponents(string: path) else { return nil }
        if parameters.count > 0 {
            components.queryItems = parameters
        }
        return components.url
    }
    
    func request(url: URL, method: HTTPMethod, body: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields?[Constant.contentTypeHeader] = Constant.contentType
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
