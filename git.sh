if [ -z $1 ]; then
    echo 'arg1 project folder not defined';
    exit 1
fi
if [ -z $2 ]; then
    echo 'arg2 module folder (sub folder) not defined';
    exit 1
fi
if [ -z $3 ]; then
    echo 'arg3 git branch not defined';
    exit 1
fi
if [ -z $4 ]; then
    echo 'arg4 branch suffix not defined';
    exit 1
fi
if [ -z $5 ]; then
    echo 'arg5 git repo not defined';
    exit 1
fi
project=$1
folder=$2
branch=$3
branchSuffix=$4
repository=$5
if cd ../${project}/${folder}; then
    git config core.filemode false
    git stash
    git reset --hard
    git fetch origin +refs/heads/${branch}:refs/remotes/origin/${branch}
    git remote set-branches origin ${branch} ${branch}*
    git pull origin ${branch}
    git pull origin ${branch}-${branchSuffix}
else
    cd ../${project}
    git clone --branch ${branch} --single-branch ${repository} ./${folder}
    cd ${folder}
    git branch ${branch}-${branchSuffix}
    git checkout ${branch}-${branchSuffix}
fi
