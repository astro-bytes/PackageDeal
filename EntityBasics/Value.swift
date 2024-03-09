//
//  File.swift
//  
//
//  Created by Porter McGary on 2/10/24.
//

import Foundation

/// A protocol for types that represent values and can be compared for equality and hashed.
///
/// Conforming types must implement the requirements of the `Equatable` and `Hashable` protocols.
///
/// - Note: This protocol is commonly used for types that represent values and need to support equatability and hashing.
///
/// Conforming to `Value` allows instances of the conforming type to be compared for equality using the `==` operator and
/// used in hash-based collections like `Set` and `Dictionary`.
///
/// ```
/// struct Person: Value {
///     let name: String
///     let age: Int
/// }
/// ```
public protocol Value: Equatable, Hashable {}
