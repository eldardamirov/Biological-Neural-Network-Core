//
//  Neuron.swift
//  Biological Neural Network Core
//
//  Created by Эльдар Дамиров on 10.10.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation

struct poisonValue
    {
    static let int = 12345678;
    static let double = 1234.5678;
    };


struct inputCharacteristics
    {
    var weights = [ Double ]();
    var inputs = [ Neuron ]();
    
    public var size: Int
        {
        if ( weights.count == inputs.count )
            {
            return weights.count;
            }
        else
            {
            return poisonValue.int; 
            }
        };
    
    subscript ( index: Int ) -> ( Double, Double )
        {
        get 
            {
            return ( weights [ index ], inputs [ index ].output );
            }
        set ( newValue ) 
            {
            var ( newWeight, _ ) = newValue;
            weights [ index ] = newWeight;
            }
        }
        
    mutating func addNewInput ( input newInput: Neuron )
        {
        inputs.append ( newInput );
        weights.append ( Double.random ( in: -1.0...1.0 ) );
        }
        
    mutating func resetOutputReferences()
        {
        inputs.removeAll();
        } 
    
    func checkInputParametersEquality() -> Bool
        {
        return { () -> Bool in if ( weights.count == inputs.count ) { return true; } else { print ( "Something wrong with sizes" ); return false;  } }();
        }
        
    mutating func setWeights ( weights newWeights: [ Double ] )
        {
        weights = newWeights;
        }
        
    }

class Neuron
    {
    init (  )
        {
        }
    
    lazy var input = inputCharacteristics();
    lazy public var output: Double = 0.0;
    
    func setOutput ( output newOutput: Double )
        {
        output = newOutput;
        }
    
    func resetOutputReferences()
        {
        input.resetOutputReferences();
        }    
        
    func calculateOutput()
        {
        output = 0.0;
        
        let inputSize = input.size;
        
        for index in 0..<inputSize
            {
            var ( currentWeight, currentInput ) = input [ index ];
            output = output + ( currentWeight * currentInput );
            }
        }
        
    func getOutput() -> Double
        {
        return output;
        }
        
    func addNewInput ( inputNeuron newInputNeuron: Neuron )
        {
        input.addNewInput ( input: newInputNeuron );
        }
        
    func mutate ( mutationStrength: Double, percentageOfNeurons: Double )
        {
        var inputSize = input.size;
        
        for currentInput in 0...inputSize
            {
            if ( ( Int.random ( in: 0...1000000 ) < Int ( percentageOfNeurons * 1000000 ) ) )
                {
                input [ currentInput ] = ( ( ( Double.random ( in: -1.0...1.0 ) ) * mutationStrength ), 0 );
                }
            }
            
        }
        
    func getWeights() -> [ Double ]
        {
        return input.weights;
        }
        
    };
