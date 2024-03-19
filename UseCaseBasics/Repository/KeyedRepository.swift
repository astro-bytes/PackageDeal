//
//  KeyedRepository.swift
//  UseCaseBasics
//
//  Created by Porter McGary on 1/30/24.
//

import Foundation
import Utility

/// Protocol defining a keyed repository, which extends the basic repository pattern and provides methods to interact with data elements using their identifiers.
/// A protocol representing a repository that stores elements keyed by identifiers.
///
/// Conforming types must implement the requirements of the `Repository` protocol and provide a payload of type `[Key: Element]`.
///
/// - Note: This protocol is commonly used for repositories that store elements with unique identifiers.
public protocol KeyedRepository<Key, Element>: Repository where Payload == [Key: Element] {
    /// The type of the key used to identify elements in the repository, which must conform to the `Hashable` protocol.
    associatedtype Key: Hashable
    
    /// The type representing the elements stored in the repository.
    associatedtype Element
    
    /// Retrieves an element from the repository by its identifier.
    ///
    /// - Parameter key: The key used to identify the element.
    /// - Returns: A `DataResult` containing the element with the specified key.
    func get(by key: Key) async throws -> Element
    
    /// - Parameter element: The element to set in the repository.
    func set(_ element: Element, for key: Key)
    
    /// Refreshes the element with the specified key in the repository asynchronously.
    ///
    /// - Parameter key: The key used to identify the element to refresh.
    func refresh(by key: Key) async
    
    /// Refreshes the element with the specified key in the repository and returns the result asynchronously.
    ///
    /// - Parameter key: The key used to identify the element to refresh.
    /// - Returns: A `DataResult` containing the refreshed element, if successful.
    func refresh(by key: Key) async -> DataResult<Element>
    
    /// Clears the element with the specified key from the repository.
    ///
    /// - Parameter key: The key used to identify the element to clear.
    func clear(by key: Key)
}


extension KeyedRepository where Payload == [Key: Element] {
    /// Retrieves an element from the keyed repository by its identifier asynchronously.
    ///
    /// - Parameters:
    ///   - id: The identifier of the element to retrieve.
    ///   - timeout: The maximum time to wait for the operation to complete. Default is 5 seconds.
    /// - Returns: The element with the specified identifier.
    /// - Throws: An error if the retrieval fails or the element is not found.
    public func get(by key: Key, within timeout: TimeInterval) async throws -> Element {
        let payload = try await get(within: timeout)
        guard let value = payload[key] else {
            throw CoreError.notFound
        }
        return value
    }
}

extension KeyedRepository where Element: Identifiable, Key == Element.ID {
    // TODO: Comment & Test
    public func set(_ element: Element) {
        set(element, for: element.id)
    }
}
