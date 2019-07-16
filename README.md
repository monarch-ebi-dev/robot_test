## Testing a new ROBOT feature on a branch with the ODK

To test a new ROBOT feature on a branch with the ODK, simply run:


```
BRANCH=532-fix ROBOT_REPO=rctauber/robot ./prepare_robot_test.sh 
```

The previous command 

1. clones the ROBOT_REPO from GitHub 
1. checks out the branch with the fix (BRANCH)
1. builds the robot jar using the usual maven commands
1. pushes it upstream to the target directory of this here (robot_test) repo
1. clones ODK
1. compiles a dev version (obolibrary/odkdev) of the ODK including the robot jar created earlier

This ODK can now be used to run tests.