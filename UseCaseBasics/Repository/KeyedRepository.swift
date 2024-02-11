//
//  KeyedRepository.swift
//  UseCaseBasics
//
//  Created by Porter McGary on 1/30/24.
//

import Foundation
import Utility

// TODO: Comment again

/// Protocol defining a keyed repository, which extends the basic repository pattern and provides methods to interact with data elements using their identifiers.
public protocol KeyedRepository<Key, Element>: Repository where Payload == [Key: Element] {
    // TODO: Comment
    associatedtype Key: Hashable
    
    /// Associated type representing the elements stored in the repository, which must conform to the `Identifiable` protocol.
    associatedtype Element
    
    /// Retrieves an element from the repository by its identifier.
    ///
    /// - Parameter id: The identifier of the element to retrieve.
    /// - Returns: A `DataResult` containing the element with the specified identifier.
    func get(by key: Key, within timeout: TimeInterval) async throws -> Element
    
    /// Sets the provided element in the repository.
    ///
    /// - Parameter element: The element to set in the repository.
    func set(_ element: Element, for key: Key)
    
    /// Clears the element with the specified identifier from the repository.
    ///
    /// - Parameter id: The identifier of the element to clear.
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
    public func get(by key: Key, within timeout: TimeInterval = .to(seconds: 5)) async throws -> Element {
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
