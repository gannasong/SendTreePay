//
//  Pharmacy.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/5/29.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation

struct Pharmacy: Codable, Equatable {
  let id: String?
  let name: String?
  let phone: String?
  let address: String?
  let maskAdult: Int?
  let maskChild: Int?
  let updated: String?
  let available: String?
  let note: String?
  let customNote: String?
  let website: String?
  let county: String?
  let town: String?
  let cunli: String?
  let servicePeriods: String?
  let coordinates: [Double]?

  enum BaseKeys: String, CodingKey {
    case properties
    case geometry
  }

  enum PropertiesKeys: String, CodingKey {
    case id
    case name
    case phone
    case address
    case maskAdult = "mask_adult"
    case maskChild = "mask_child"
    case updated
    case available
    case note
    case customNote = "custom_note"
    case website
    case county
    case town
    case cunli
    case servicePeriods = "service_periods"
  }

  enum GeometryKeys: String, CodingKey {
    case coordinates
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: BaseKeys.self)
    let properties = try container.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
    id = try properties.decodeIfPresent(String.self, forKey: .id)
    name = try properties.decodeIfPresent(String.self, forKey: .name)
    phone = try properties.decodeIfPresent(String.self, forKey: .phone)
    address = try properties.decodeIfPresent(String.self, forKey: .address)
    maskAdult = try properties.decodeIfPresent(Int.self, forKey: .maskAdult)
    maskChild = try properties.decodeIfPresent(Int.self, forKey: .maskChild)
    updated = try properties.decodeIfPresent(String.self, forKey: .updated)
    available = try properties.decodeIfPresent(String.self, forKey: .available)
    note = try properties.decodeIfPresent(String.self, forKey: .note)
    customNote = try properties.decodeIfPresent(String.self, forKey: .customNote)
    website = try properties.decodeIfPresent(String.self, forKey: .website)
    county = try properties.decodeIfPresent(String.self, forKey: .county)
    town = try properties.decodeIfPresent(String.self, forKey: .town)
    cunli = try properties.decodeIfPresent(String.self, forKey: .cunli)
    servicePeriods = try properties.decodeIfPresent(String.self, forKey: .servicePeriods)
    let geometry = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
    coordinates = try geometry.decodeIfPresent([Double].self, forKey: .coordinates)
  }
}
