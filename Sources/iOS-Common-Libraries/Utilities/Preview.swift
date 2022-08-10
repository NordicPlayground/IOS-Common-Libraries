//
//  Preview.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 9/8/22.
//

import Foundation

#if DEBUG
public enum Preview {

    static public func decode<T: Decodable>(filename: String) throws -> T? {
        let path: String! = Bundle.main.path(forResource: filename, ofType: "json")
        let content: String! = try? String(contentsOfFile: path)
        let contentData: Data! = content.data(using: .utf8)
        return try? JSONDecoder().decode(T.self, from: contentData)
    }
}
#endif
