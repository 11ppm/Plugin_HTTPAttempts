<br/>
<p align="center">
<img src="./img/img2.jpg" width="225" alt="PluginJapan">
</a>
</p>
<br/>

# Plugin_HTTPAttempts

 [README 日本語版](https://github.com/11ppm/Plugin_HTTPAttempts/blob/main/README_JP.md)

This repository is for editing the `schema.go` file and changing the value of `DefaultMaxHTTPAttempts` to `2`. Although it had been tried `5` times to avoid losing data from the `API`, it was reduced to `2` times. See below for details.

## [GoPlugin/Plugin](https://github.com/GoPlugin/Plugin)

## Features
Plugin_HTTPAttempts.sh has the following features.

1. Check the current version of `Node.js`. If it is different from the default of `PluginNode`, which is `v15.14.0`, change the version to `v15.14.0` using nvm.
2. Edit the `schema.go` file in the script. The item to be edited is to change the value of `DefaultMaxHTTPAttempts` to `2`.
3. Stop the main process using `pm2` and load the `profile`.
4. Install the `Plugin` using `make install`.

## Requirements
Before using this script, you need to meet the following requirements.
* You can switch the version of `Node.js` using `nvm`.
* `pm2` is installed and the necessary scripts for managing `PluginNode` can be executed.
* Make sure that the path to the `schema.go` file used in the script is correct. By default, the path is `~/plugin-deployment/Plugin/core/store/orm/schema.go`.

## Notes
* It is recommended to create a backup before using this script.
* The name of the main process must be `2_nodeStartPM2` or `[sS]tart[nN]ode`. If these process names are not found, the script will exit with an error.
* If you run the script with only `./Plugin_HTTPAttempts.sh`, the version of `Node.js` will only be valid within the shell script process and changes will be discarded when the shell script is exited. By running `source ./Plugin_HTTPAttempts.sh`, the version of `Node.js` will be the default of `PluginNode`, which is `v15.14.0`.

## Execution command
You can run this script using the following command:

1. Open the terminal and move to any directory where you can run the `git clone` and `source` commands.

2. Clone the repository using the following command:
```sh
git clone https://github.com/11ppm/Plugin_HTTPAttempts
```

3. Move to the Plugin_HTTPAttempts directory:
```sh
cd Plugin_HTTPAttempts
```

4. Give execution permission to the Plugin_HTTPAttempts.sh file:
sh
```sh
chmod +x Plugin_HTTPAttempts.sh
```

5. Run the shell script using the `source` command. Be sure to include `./`.
```sh
source ./Plugin_HTTPAttempts.sh
```

## Important
* If you run the script with only `./Plugin_HTTPAttempts.sh`, the version of `Node.js` will only be valid within the shell script process and changes will be discarded when the shell script is exited. By running `source ./Plugin_HTTPAttempts.sh`, the version of `Node.js` will be the default of `PluginNode`, which is `v15.14.0`. If you are already running a version other than `v15.14.0`, be sure to change it to `v15.14.0` before running the script.

```sh
./Plugin_HTTPAttempts.sh
```

## Author

* @11ppm
