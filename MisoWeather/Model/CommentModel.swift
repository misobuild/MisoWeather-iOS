//
//  CommentModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/08.
//

struct CommentModel: Decodable {
    let data: Comment
    let message: String
    let status: String
}

struct Comment: Decodable {
    let commentList: [CommentList]
    let hasNext: Bool
}

struct CommentList: Decodable {
    let createdAt: String
    let id: Int
    let content: String
    let bigScale: String
    let nickname: String
    let emoji: String
}
