//
//  TimeModel.swift
//  HustleReactorKit
//
//  Created by Juyeon on 2021/08/19.
//

import Foundation

struct TimeModel: Codable {
    let abbreviation, clientIP, datetime: String
    let dayOfWeek, dayOfYear: Int
    let dst: Bool
    let dstFrom: Int?
    let dstOffset: Int
    let dstUntil: Int?
    let rawOffset: Int
    let timezone: String
    let unixtime: Int
    let utcDatetime, utcOffset: String
    let weekNumber: Int

    enum CodingKeys: String, CodingKey {
        case abbreviation = "abbreviation"
        case clientIP = "client_ip"
        case datetime = "datetime"
        case dayOfWeek = "day_of_week"
        case dayOfYear = "day_of_year"
        case dst = "dst"
        case dstFrom = "dst_from"
        case dstOffset = "dst_offset"
        case dstUntil = "dst_until"
        case rawOffset = "raw_offset"
        case timezone = "timezone"
        case unixtime = "unixtime"
        case utcDatetime = "utc_datetime"
        case utcOffset = "utc_offset"
        case weekNumber = "week_number"
    }
}
