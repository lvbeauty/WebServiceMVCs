//
//  NetworkManager.swift
//  Service_Demo
//
//  Created by Tong Yi on 5/28/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class Service
{
    static let shared = Service()
    static var dataSource = [Items]()
    typealias SeviceModel = [Items]
    
    private init() {}
    
    private static let url = URL(string: "https://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")
   
    private static func fatchData(completeHandler: @escaping ([Items]?) -> Void)
    {
        guard let url = url else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url)
        {(data, response, error) in
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else
            {
                let httpResponse = response as! HTTPURLResponse
                print("response status code: \(httpResponse.statusCode)")
                
                guard let data = data else { return }
                
                do
                {
                    let json = try JSONDecoder().decode(Flickr.self, from: data)
                    completeHandler(json.items)
                }
                catch
                {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    static func loadDataSource(completionHandler: @escaping () -> () )
    {
        fatchData
        { (data) in
            guard let dataSource = data else { return }
            
            self.dataSource = dataSource
            completionHandler()
        }
    }
    
    static func loadImage(item: Int, handler: (UIImage) -> ())
    {
        
        guard let imageUrl = self.dataSource[item].media.imageURL else { return }
        
        do
        {
            let data = try Data(contentsOf: imageUrl)
            guard let image = UIImage(data: data) else { return }
                handler(image)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
    }
}
