CommandDispatch
===============

CommandDispatcher allows grouping of commands and executing them sequentially or in parallel
You can nest multiple commands or command groups as per example below:
[SERIAL GROUP #1] BEGIN
     SERIAL ACTION #1
     SERIAL ACTION #2
     [PARALLEL GROUP #1] BEGIN
         PARALLEL ACTION #1
         [SERIAL GROUP #2] BEGIN
             SERIAL ACTION #11
             SERIAL ACTION #12
         [SERIAL GROUP #2] END
         PARALLEL ACTION #2
     [PARALLEL GROUP #1] END
     SERIAL ACTION #3
     SERIAL ACTION #4
[SERIAL GROUP #1] END

Your command classes have to adhere to the Action protocol. Use ActionGroup instances to group your commands.

Remark
There is no demo app yet, for a usage example check out the unit tests. Note that execution results are displayed in the XCode console.
