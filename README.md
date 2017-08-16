 - [Install hrtool](#hrtool)
 - [Install hrtool extension (optional)](#hrtoolext)
 - [Install HEAD](#head)
 - [Run robot](#run)
 - [Migrate from old hrtool](#migrate)

# <a name="hrtool"></a>Install hrtool 

Run this single command to install hrtool.

`curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash`

# <a name="hrtoolext"></a>Install hrtool extension (optional)

**This allows you to access private resources**

1. Create Github personal token according to [Creating a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/), and write down the **token**. 

2. Add a system environment variable `GITHUB_TOKEN`

    For example, add `export GITHUB_TOKEN=<token>` to ~/.bashrc

3. Test the token. You will see it prints out the latest version of hrtool-ext, for example, `v0.6.1`

    `source ~/.bashrc && hr cmd get_latest_version hansonrobotics/hrtool-ext`

4. Install head-hr-ext

    `hr install head-hr-ext`

# <a name="head"></a>Install HEAD

`hr install head`

# <a name="run"></a>Run robot

`hr run <robot>`

# <a name="migrate"></a>Migrate from old hrtool

Unfortunately, the new hrtool is not compatible with old hrtool. So in order to use the new hrtool, you need to clean up your system. 

- Commit all the local changes and push to GitHub
- Uninstall rospkg and catkin_pkg: `pip3 uninstall rospkg catkin_pkg`
- Delete ~/hansonrobotics
- Delete /opt/hansonrobotics
- Delete ~/.hr
- Install new hrtool, following the above steps. 
