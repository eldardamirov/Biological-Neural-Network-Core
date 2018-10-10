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
        
    init ( networkA: Network, networkB: Network )
        {
        let networkASize = networkA.getNeurons().size();
        let networkBSize = networkB.getNeurons().size();
        
        let outputLevelIndex = UInt ( Int ( numberOfInputs! ) + Int ( numberOfHiddenLayers! ) );
        let neuronsSumIndex = UInt ( Int ( numberOfInputs! ) + Int ( numberOfHiddenLayers! ) + Int ( numberOfOutputs! ) );
        
        if ( networkASize == networkBSize )
            {
            numberOfInputs = networkA.getInputLayerSize();
            numberOfHiddenLayers = networkA.getHiddenLayerSize;
            numberOfOutputs = networkA.getOutputLayerSize();
            
            // crossing over;
            var swapPoint = Int.random ( in: 0...networkASize );
            
            for index in 0..<networkASize
                {
                if ( index < swapPoint )
                    {
                    neurons.append ( Neuron ( parentNeuron: networkB.getNeurons() [ index ] ) );
                    }
                else
                    {
                    neurons.append ( Neuron ( parentNeuron: networkA.getNeurons() [ index ] ) );
                    }
                    
                neurons.last?.input.resetOutputReferences();
                }

            
            for currentNeuron in neurons [ UInt ( numberOfInputs! )..<outputLevelIndex ]
                {
                for neuronToAdd in neurons [ 0..<numberOfInputs ]
                    {
                    currentNeuron.addNewInput ( neuronToAdd );
                    }
                }
                
            for currentNeuron in neurons [ outputLevelIndex..<neuronsSumIndex ]
                {
                for neuronToAdd in neurons [ numberOfInputs..<outputLevelIndex ]
                    {
                    currentNeuron.addNewInput ( neuronToAdd );
                    }
                }
            }
        else
            {
            print ( "Error: Inheriting networks have different size." );
            }
        
        }
        
    func update()
        {
        let numberOfNeurons: UInt = UInt ( neurons.count );
        for index in numberOfInputs!..<numberOfNeurons
            {
            neurons [ Int ( index ) ].calculateOutput();
            }
        }
    
    func getOutput ( id: UInt ) -> Double
        {
        if ( id < numberOfInputs! )
            {
            return neurons [ Int ( numberOfInputs! + numberOfHiddenLayers! + id ) ].getOutput();
            }
        else
            {
            print ( "Id is incorrect." );
            }
        }
        
    func getNeurons() -> [ Neuron ]
        {
        return neurons;
        }
    
    func setOutput ( id: UInt, value: Double )
        {
        if ( id < numberOfInputs! )
            {
            return neurons [ Int ( numberOfInputs! + numberOfHiddenLayers! + id ) ].setOutput ( output: value );
            }
        else
            {
            print ( "Id is incorrect." );
            }
        }
        
    func mutate ( strength: Double, rate: Double )
        {
        for currentNeuron in neurons
            {
            currentNeuron.mutate ( mutationStrength: strength, percentageOfNeurons: rate );
            }
        
        }
        
    func getInputLayerSize() -> UInt
        {
        return numberOfInputs!;
        }
    
    func getHiddenLayerSize() -> UInt
        {
        return numberOfHiddenLayers!;
        }  
    
    func getOutputLayerSize() -> UInt
        {
        return numberOfOutputs!;
        }
    
    };
