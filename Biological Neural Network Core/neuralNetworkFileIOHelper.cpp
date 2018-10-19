//
//  neuralNetworkFileIOHelper.cpp
//  Biological Neural Network Core
//
//  Created by Эльдар Дамиров on 19.10.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

#include "neuralNetworkFileIOHelper.hpp"

Network::Network (char filename [])
    {
    FILE* file;

    fopen_s (&file, filename, "r");

    fscanf_s (file, "%d ", &N_inp);
    fscanf_s (file, "%d ", &N_hid);
    fscanf_s (file, "%d ", &N_out);

    std::vector <double> weights;

    for (int i = 0; i < N_inp; i++)
        neurons.push_back (new Neuron);
    for (int i = N_inp; i < N_inp+N_hid; i++)
        {
        for (int j = 0; j < N_inp; j++)
            {
            double value = 0;
            fscanf_s (file, "%lg ", &value);
            weights.push_back (value);
            }
                
        neurons.push_back (new Neuron (weights));
        for (int j = 0; j < N_inp; j++)
            neurons [i]->addNewInput (neurons [j]);

        weights.clear ();
        }
        
    for (int i = N_inp+N_hid; i < N_inp+N_hid+N_out; i++)
        {
        for (int j = 0; j < N_hid; j++)
            {
            double value = 0;
            fscanf_s (file, "%lg ", &value);
            weights.push_back (value);
            }

        neurons.push_back (new Neuron (weights));
        for (int j = N_inp; j < N_hid+N_inp; j++)
            neurons [i]->addNewInput (neurons [j]);

        weights.clear ();
        }
        
    fclose (file);
    }
