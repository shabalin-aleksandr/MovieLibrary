//
//  APICaller.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 11.12.2023.
//

import Foundation


enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>)-> Void) {
        guard let url = URL(string: "\(Configuration.baseURL)/3/trending/movie/day?api_key=\(Configuration.API_KEY)") else {return}
        
        let response = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        response.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
            guard let url = URL(string: "\(Configuration.baseURL)/3/trending/tv/day?api_key=\(Configuration.API_KEY)") else {return}
            
            let response = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in guard let data = data, error == nil else {return}
                
                
                do {
                    let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    print(results)
                }
                catch {
                    completion(.failure(APIError.failedToGetData))
                }
            }
            response.resume()
        }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Configuration.baseURL)/3/movie/upcoming?api_key=\(Configuration.API_KEY)&language=en-US&page=1") else {return}
        let response = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(results)
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        response.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Configuration.baseURL)/3/movie/popular?api_key=\(Configuration.API_KEY)&language=en-US&page=1") else {return}
        let response = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(results)
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        response.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Configuration.baseURL)/3/movie/top_rated?api_key=\(Configuration.API_KEY)&language=en-US&page=1") else {return}
        let response = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(results)
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        response.resume()
    }
}
