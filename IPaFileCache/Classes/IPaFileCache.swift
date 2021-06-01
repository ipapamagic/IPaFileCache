//
//  IPaFileCache.swift
//  IPaFileCache
//
//  Created by IPa Chen on 2021/6/1.
//

import UIKit
import IPaSecurity
public class IPaFileCache: NSObject {
    public static let shared = IPaFileCache()
    lazy var cachePath:String = {
        var cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        cachePath = (cachePath as NSString).appendingPathComponent("IPaFileCache")
        let fileMgr = FileManager.default
        if fileMgr.fileExists(atPath: cachePath) {
            //remove cache at begining
            try? fileMgr.removeItem(atPath: cachePath)
        }
        try? fileMgr.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
        return cachePath
    }()
    public func cacheFilePath(for url:URL) -> String  {
        return (cachePath as NSString ).appendingPathComponent(url.absoluteString.md5String ?? url.absoluteString) as String
    }
    public func cacheFileData(for url:URL) -> Data?  {
        let path = self.cacheFilePath(for:url)
        if !FileManager.default.fileExists(atPath: path) {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath:path))
    }
    @discardableResult
    public func moveToCache(for url:URL,from fileUrl:URL) -> URL {
        let path = self.cacheFilePath(for:url)
        let pathUrl = URL(fileURLWithPath: path)
        try? FileManager.default.moveItem(at: fileUrl, to: pathUrl)
        return pathUrl
    }
    @discardableResult
    public func copyToCache(for url:URL,from fileUrl:URL) -> URL {
        let path = self.cacheFilePath(for:url)
        let pathUrl = URL(fileURLWithPath: path)
        try? FileManager.default.copyItem(at: fileUrl, to: pathUrl)
        return pathUrl
    }
}
