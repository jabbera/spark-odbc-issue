#! /bin/bash

conda create -n crash python=3.10

PATH=/opt/conda/envs/crash/bin/:${PATH}

conda install pyodbc