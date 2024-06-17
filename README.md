# Investor-Behavior-and-Multiscale-Cross-Correlations
This MATLAB code repository features an algorithm using the **Detrended Cross-Correlation Cost (DCCC)** indicator to analyze shifts in investment strategies during financial crises, validated with data from major economies, highlighting its predictive capabilities for market changes.
The project is divided into several parts, each of which performs a specific task.

# MATLAB Project

This repository contains MATLAB code for data analysis and visualization. The project is divided into several parts, each of which performs a specific task.

## Table of Contents

1. [Introduction](#introduction)
2. [Setup](#setup)
3. [Running the Project](#running-the-project)
4. [Dependencies](#dependencies)
5. [Project Structure](#project-structure)

## Introduction

This project involves data preparation, preprocessing, static and dynamic analysis, and filtering through the Minimum Spanning Tree (MST) method. The main script orchestrates the workflow by calling several other scripts.

## Setup

Steps to set up the project:

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/my-matlab-project.git
    cd my-matlab-project
    ```

2. Open MATLAB and add the repository to your path:
    ```matlab
    addpath(genpath('path/to/your/repository'));
    ```

## Running the Project

To run the project, open MATLAB, navigate to the repository directory, and run the `main.m` script:
1. Open MATLAB.
2. Navigate to the repository directory:
    ```matlab
    cd 'path/to/your/repository'
    ```
3. Run the `main.m` script:
    ```matlab
    run('main.m');
    ```

## Dependencies

- MATLAB R2021b or later

## Project Structure

- `main.m`: Main script to run the entire project
- `config.m`: Configuration file for input parameters
- `scripts/`: Folder containing individual scripts
  - [`download.m`](scripts/download.m): Script to download data from Yahoo Finance
  - [`preprocessing.m`](scripts/preprocessing.m): Script to preprocess the data
  - [`plotStandData.m`](scripts/plotStandData.m): Script to plot standardized data
  - [`rho_DCCA.m`](scripts/rho_DCCA.m): Script to compute DCCA coefficients
  - [`rho_DCCADistancesRollingWindow.m`](scripts/rho_DCCADistancesRollingWindow.m): Script to compute DCCA distances using a rolling window
  - [`filtering_MST.m`](scripts/filtering_MST.m): Script to filter data using MST
  - [`plotDensities.m`](scripts/plotDensities.m): Script to plot densities
- `functions/`: Folder for storing reusable functions
  - [`DCCA.m`](functions/DCCA.m): Function to compute DCCA coefficients
  - [`getMarketDataViaYahoo.m`](functions/getMarketDataViaYahoo.m): Function to download market data from Yahoo Finance




