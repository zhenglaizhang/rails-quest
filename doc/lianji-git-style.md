# 联极Git 风格指南

## Host

* 统一采用[Bitbucket](https://bitbucket.org)来管理代码，它提供了一个高可靠且私密的基于git协议的代码管理服务。 

## Branches

* 选择*简短*和*具有描述性*的名字来命名分支：

  ```shell
  # 好
  $ git checkout -b oauth-migration

  # 不好，过于模糊
  $ git checkout -b login_fix
  ```

* 来自外部的标识符也适合用作分支的名字，例如来自 github/bitbucket 的 Issue 序号。

* 用破折号分割单词。

* 当不同的人围绕同一个特性开发时，维护整个团队的特性分支与每个人的独立分支是比较方便的做法。使用如下的命名方式：

  ```shell
  $ git checkout -b f-a/master # team-wide branch
  $ git checkout -b f-a/maria # Maria's branch
  $ git checkout -b f-a/nick # Nick's branch
  ```


## Commits

* 每个提交应当只包含一个简单的逻辑改动，不要在一个提交里包含多个逻辑改动。比如，如果一个补丁修复了一个 Bug，又优化了一个特性的性能，就将其拆分。
* 不要将一个逻辑改动拆分提交。例如一个功能的实现及其对应的测试应当一并提交。
* 尽早、尽快提交。出问题时，短小、完整的提交更容易发现并修正。
* 提交应当依*逻辑*排序。例如，如果 X 提交依赖于 Y，那么 Y 提交应该在 X 前面。
* 擅用`git squash`和`git rebase`确保git提交历史记录干净整齐可追述

## Merging

* **不要篡改提交历史.**仓库的历史本身就很宝贵，重要的是它能够还原*实际发生了什么*。对任何参与项目的人来说，修改历史是万恶之源。
* 尽管如此，有些时候还是可以重写历史，例如：
  * 你一个人孤军奋战，而且你的代码不会被人看到。
  * 你希望整理分支（例如使用 squash），以便日后合并。
    最重要的，*不要重写你的 master 分支历史* 或者任何有特殊意义的分支（例如发布分支或 CI 分支）。
* 保持你的提交历史*干净*、*简单*。*在你 merge* 你的分支之前：
  1. 确保它符合风格指南，如果不符合就执行相应操作，比如 squash 或重写提交信息。
  2. 将其 rebase 到目标分支：
     ```shell
     [my-branch] $ git fetch
     [my-branch] $ git rebase origin/master
     # then merge
     ```
     这样会在 master 后直接添加一个新版本，令提交历史更简洁。

  *（这个策略更适合较短生命周期的分支，否则还是最好经常合并而不是 rebase。）*

* 如果你的分支包含多个 commmit , 不要使用快进模式。
  ```shell
  # 好；注意添加合并信息
  $ git merge --no-ff my-branch

  # 不好
  $ git merge my-branch
  ```

## Misc.

* *保持统一*， 这涉及到从工作流到你的提交信息，分支名还有标签。 在整个 Repository 中保持统一的命名风格有助于辨认工作进度。
* *push 前测试*， 不要提交未完成的工作。
* 使用 [annotated tags](http://git-scm.com/book/en/v2/Git-Basics-Tagging#Annotated-Tags) 标记发布版本或者其他重要的时间点。

  个人开发可以使用 [lightweight tags](http://git-scm.com/book/en/v2/Git-Basics-Tagging#Lightweight-Tags)，例如为以后参考做标记。
* 定期维护，保证你的仓库状态良好，包括本地还有远程的仓库。


