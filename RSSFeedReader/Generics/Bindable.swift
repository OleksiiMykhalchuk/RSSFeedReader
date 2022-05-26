//
//  Bindable.swift
//
//  Created by Denysov Illia on 19.10.2020.
//  Copyright © 2020  macbook. All rights reserved.
//

import Foundation

class Bindable<Value> {
    private var observations = [(Value) -> Bool]()
    private(set) var lastValue: Value?

    init(_ value: Value? = nil) {
        lastValue = value
    }
}

private extension Bindable {
    func addObservation<O: AnyObject>(for object: O,
                                      handler: @escaping (O, Value) -> Void) {
        lastValue.map { handler(object, $0) }
        observations.append { [weak object] value in
            guard let object = object else {
                return false
            }
            handler(object, value)
            return true
        }
    }
}

extension Bindable {
    func update(with value: Value) {
        lastValue = value
        observations = observations.filter { $0(value) }
    }
}

extension Bindable {
    func bind<O: AnyObject>(to object: O,
                            callback: @escaping (Value) -> Void) {
        addObservation(for: object) { _, observed in
            callback(observed)
        }
    }
}

extension Bindable {
    func bind<O: AnyObject, R>(to object: O,
                               callback: @escaping (R?) -> Void,
                               transform: @escaping (Value) -> R?) {
        addObservation(for: object) { _, observed in
            callback(transform(observed))
        }
    }
}

extension Bindable {
    func bind<O: AnyObject, T>(_ sourceKeyPath: KeyPath<Value, T>,
                               to object: O,
                               _ objectKeyPath: ReferenceWritableKeyPath<O, T>) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }
}

extension Bindable {
    func bind<O: AnyObject, T>(_ sourceKeyPath: KeyPath<Value, T>,
                               to object: O,
                               _ objectKeyPath: ReferenceWritableKeyPath<O, T?>) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }
}

extension Bindable {
    func bind<O: AnyObject, T, R>(_ sourceKeyPath: KeyPath<Value, T>,
                                  to object: O,
                                  _ objectKeyPath: ReferenceWritableKeyPath<O, R?>,
                                  transform: @escaping (T) -> R?) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            let transformed = transform(value)
            object[keyPath: objectKeyPath] = transformed
        }
    }
}
