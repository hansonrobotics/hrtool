Install hrtool 
============

`curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash`

Install hrtool extension (optional)
============

**This allows you to access private resource**

1. Create Github personal token according to [Creating a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/), and write down the **token**. 

2. Add a system environment variable GITHUB_TOKEN

> For example, add "export GITHUB_TOKEN=<**token**>" to ~/.bashrc

3. Install head-hr-ext
 `hr install head-hr-ext`

Install HEAD
============

`hr install head`

Run robot
============

`hr run <robot>`
