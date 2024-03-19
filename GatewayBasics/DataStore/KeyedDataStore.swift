//
//  KeyedDataStore.swift
//  GatewatBasics
//
//  Created by Porter McGary on 1/20/24.
//

import Foundation
import UseCaseBasics

/// A protocol for a keyed data store, where elements are uniquely identified by their ID.
public protocol KeyedDataStore<Key, Element>: DataStore where Payload == [Key: Element] {
    associatedtype Key: Hashable
    
    /// The type of elements stored in the data store, conforming to Identifiable.
    associatedtype Element
    
    /// Retrieves an element from the data store by its ID.
    /// - Parameter id: The ID of the element to retrieve.
    /// - Returns: A result containing the element on success, or an error on failure.
    func get(by id: Key) -> DataResult<Element>
    
    /// Sets or updates an element in the data store.
    /// - Parameter element: The element to be set or updated.
    func set(_ element: Element, for key: Key)
    
    /// Clears an element from the data store by its ID.
    /// - Parameter id: The ID of the element to clear.
    func clear(by id: Key)
    
    /// Clears an element from the data store.
    /// - Parameter id: The ID of the element to refresh.
    func refresh(by id: Key) async -> DataResult<Element>
    
    /// Clears an element from the data store.
    /// - Parameter id: The ID of the element to refresh.
    func refresh(by id: Key)
}
