# vim-config Documentation

## Overview
This project contains configuration settings for the CoC (Conqueror of Completion) plugin in Vim, specifically tailored for C, C++, Objective-C, and Objective-C++ development using Clangd as the language server.

## Installation
- First thing first install vim-plug that can manage all plugins from this github repository `junegunn/vim-plug` refer to the official documentation for installation.
- Install node-js, clangd for c/c++ and black for python and mentioned the exe file path to the `coc-settings.json`.
- For more details on configuring CoC and using Clangd, refer to the official documentation of the CoC plugin and Clangd.

## Files
- **coc-settings.json**: Contains configuration settings for the CoC plugin, including language server settings for Clangd and various preferences for suggestions and formatting.

## Setup Instructions
1. Ensure you have Vim installed on your system.
2. Install the CoC plugin for Vim.
3. Place the `coc-settings.json` file in your Vim configuration directory.
4. Make sure you have Clangd installed and update the command path in `coc-settings.json` accordingly.
5. For Python formatting, ensure you have Black installed and update the path in `coc-settings.json`.

## Usage Guidelines
- Open a C, C++, Objective-C, or Objective-C++ file in Vim.
- The CoC plugin will automatically trigger suggestions and formatting based on the settings defined in `coc-settings.json`.
- Use the formatting features on save to maintain code style.


