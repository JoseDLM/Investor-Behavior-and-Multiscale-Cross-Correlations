# Investor-Behavior-and-Multiscale-Cross-Correlations
This MATLAB code repository features an algorithm using the **Detrended Cross-Correlation Cost (DCCC)** indicator to analyze shifts in investment strategies during financial crises, validated with data from major economies, highlighting its predictive capabilities for market changes.
The project is divided into several parts, each of which performs a specific task.

## Table of Contents

1. [Introduction](#introduction)
2. [Setup](#setup)
3. [Configuration](#configuration)
4. [Running the Project](#running-the-project)
5. [Dependencies](#dependencies)
6. [Project Structure](#project-structure)
7. [Detailed Code Sections](#detailed-code-sections)

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

## Configuration

Configuration details and how to set input parameters are included in `config.m`.

## Running the Project

To run the main script, execute the following command in MATLAB:
```matlab
main;
