//
//  IPaFileCache.swift
//  IPaFileCache
//
//  Created by IPa Chen on 2021/6/1.
//

import UIKit
public class IPaFileCache: NSCache<NSURL,NSData> {
    public static let shared = IPaFileCache()
    @inlinable public func cacheData(for url:URL) -> Data? {
        return self.object(forKey: url as NSURL) as? Data
    }
    @inlinable public func setCache(_ data:Data,for url:URL) {
        self.setObject(data as NSData, forKey: url as NSURL)
    }
}
public class IPaImageCache: NSCache<NSURL,UIImage> {
    public static let shared = IPaImageCache()
    @inlinable public func cacheImage(for url:URL) -> UIImage? {
        return self.object(forKey: url as NSURL)
    }
    @inlinable public func setCache(_ image:UIImage,for url:URL) {
        self.setObject(image, forKey: url as NSURL)
    }
}
