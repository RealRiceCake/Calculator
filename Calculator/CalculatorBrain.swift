//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Xiaohang Lv on 10/19/17.
//  Copyright © 2017 Xiaohang Lv. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperaion((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "AC" : Operation.constant(0),
        "√" : Operation.unaryOperation(sqrt),
        "sin" : Operation.unaryOperation(sin),
        "cos" : Operation.unaryOperation(cos),
        "tan" : Operation.unaryOperation(tan),
        "±" : Operation.unaryOperation({ -$0 }),
        "%" : Operation.unaryOperation({ $0 / 100 }),
        "+" : Operation.binaryOperaion({ $0 + $1 }),
        "-" : Operation.binaryOperaion({ $0 - $1 }),
        "×" : Operation.binaryOperaion({ $0 * $1 }),
        "÷" : Operation.binaryOperaion({ $0 / $1 }),
        "=" : Operation.equals,
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperaion(let function):
                if accumulator != nil {
                    pdo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            default:
                break
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pdo != nil && accumulator != nil {
            accumulator = pdo?.perform(with: accumulator!)
            pdo = nil
        }
    }
    
    private var pdo: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double{
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
