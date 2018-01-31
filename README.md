 - [Installation](#installation)
   - [Install hrtool](#hrtool)
   - [Install hrtool extension (optional)](#hrtoolext)
   - [Initialize Workspace](#init)
   - [Install HEAD](#head)
 - [Run robot](#run)
 - [Update hrtool](#update)
 - [Usage](#usage)
 - [Migrate from old hrtool](#migrate)

# <a name="installatin"></a>Installation
## <a name="hrtool"></a>Install hrtool

Run this single command to install hrtool.

`curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash`

## <a name="hrtoolext"></a>Install hrtool extension (optional)

**This allows you to access private resources**

1. Create Github personal token according to [Creating a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/), and write down the **token**.

    Note: In the `Select scopes`, select `repo`, and all its sub-scopes.

2. Add a system environment variable `GITHUB_TOKEN`

    For example, add `export GITHUB_TOKEN=<token>` to ~/.bashrc

3. Test the token. You will see it prints out the latest version of hrtool-ext, for example, `v0.6.1`

    `source ~/.bashrc && hr cmd get_latest_version hansonrobotics/hrtool-ext`

4. Install head-hr-ext

    `hr install head-hr-ext`

4a. To install pre-release versions of hrtool and hrtool-ext (for testing and development) purposes

    `hr install -p head-hr`

5. Clean up hash

    `hash -r`

## <a name="init"></a>Initialize Workspace

`hr init [workspace]`

## <a name="head"></a>Install HEAD

`hr install head`

If installing on top of an earlier installation, be sure to force:

`hr install -f head`

# <a name="run"></a>Run robot

`hr run <robot>`

# <a name="update"></a>Update hrtool

`hr install head-hr`

# <a name="usage"></a>Usage

1. `hr` to show all the available commands.
2. `hr install -p <package>` to install pre-release packages.
3. `hr install -f <package>` to force install packages.
4. `hr install head` to install/update HEAD stack.
5. `hr role <user|developer>` to switch roles.

# <a name="migrate"></a>Migrate from old hrtool

Unfortunately, the new hrtool is not compatible with old hrtool. So in order to use the new hrtool, you need to clean up your system.

- Commit all the local changes and push to GitHub
- Uninstall rospkg and catkin_pkg: `pip3 uninstall rospkg catkin_pkg`
- Delete `~/hansonrobotics`
- Delete `/opt/hansonrobotics`
- Delete `~/.hr`
- Install the newest `hrtool`, following the above steps.
- Be sure to force installation using `hr install -f head`.

# <a name="troubleshooting"></a>Troubleshooting

## Hash Sum mismatch

If you see such errors when you do `sudo apt-get update`
```
W: Failed to fetch http://hk.archive.ubuntu.com/ubuntu/dists/trusty-updates/universe/source/Sources  Hash Sum mismatch
W: Failed to fetch http://hk.archive.ubuntu.com/ubuntu/dists/trusty-updates/universe/binary-amd64/Packages  Hash Sum mismatch
W: Failed to fetch http://hk.archive.ubuntu.com/ubuntu/dists/trusty-updates/universe/binary-i386/Packages  Hash Sum mismatch
E: Some index files failed to download. They have been ignored, or old ones used instead.
```
Go to "System Settings" -> "Software & Updates" -> "Ubuntu Software". Then choose the "Download from" drop down menu, select "Main Server"

## head-deps is not installed

Uninstall nodejs if it's of version 0.10.x or older. HEAD requires nodejs to be 6.6.x or newer.
