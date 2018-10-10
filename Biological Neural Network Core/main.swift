//
//  main.swift
//  Biological Neural Network Core
//
//  Created by Эльдар Дамиров on 10.10.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation

class Network
    {
    let numberOfInputs: UInt?;
    let numberOfHiddenLayers: UInt?;
    let numberOfOutputs: UInt?;
    
    lazy var neurons = [ Neuron ]();
    
    init ( numberOfInputs: UInt, numberOfHiddenLayers: UInt, numberOfOutputs: UInt )
        {
        self.numberOfInputs = numberOfInputs;
        self.numberOfHiddenLayers = numberOfHiddenLayers;
        self.numberOfOutputs = numberOfOutputs;
        
        for _ in 0..<numberOfInputs
            {
            neurons.append ( Neuron() );
            }
            
        for currentNeuron in numberOfInputs..<( numberOfInputs + numberOfHiddenLayers )
            {
            neurons.append ( Neuron() );
            for currentNeuronToAdd in 0..<numberOfInputs
                {
                neurons [ Int ( currentNeuron ) ].addNewInput ( inputNeuron: neurons [ Int ( currentNeuronToAdd ) ] );
                }
            }
            
        for currentNeuron in ( numberOfInputs + numberOfHiddenLayers )..<( numberOfInputs + numberOfHiddenLayers + numberOfOutputs )
            {
            neurons.append ( Neuron() );
            for currentNeuronToAdd in numberOfInputs..<( numberOfInputs + numberOfHiddenLayers )
                {
                neurons [ Int ( currentNeuron ) ].addNewInput ( inputNeuron: neurons [ Int ( currentNeuronToAdd ) ] );
                }
            }
        };
    
    
    
    };
