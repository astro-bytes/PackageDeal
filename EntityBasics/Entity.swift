//
//  Entity.swift
//  EntityBasics
//
//  Created by Porter McGary on 1/20/24.
//

import Foundation

/// A protocol for types that represent entities and can be identified, compared for equality, and hashed.
///
/// Conforming types must implement the requirements of the `Identifiable`, `Equatable`, and `Hashable` protocols.
///
/// - Note: This protocol is commonly used for types that represent entities in a system and need to support identification, equatability, and hashing.
///
/// Conforming to `Entity` allows instances of the conforming type to be uniquely identified using an identifier, compared for equality using the `==` operator, and
/// used in hash-based collections like `Set` and `Dictionary`.
///
/// ```
/// struct User: Entity {
///     var id: UUID
///     var name: String
/// }
/// ```
public protocol Entity: Identifiable, Value {}
