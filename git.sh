if [ -z $1 ]; then
    exit 1
fi
if [ -z $2 ]; then
    exit 1
fi
if [ -z $3 ]; then
    exit 1
fi
if [ -z $4 ]; then
    exit 1
fi
folder=$1
branch=$2
branchSuffix=$3
repository=$4
if cd ${folder}; then
    git config core.filemode false
    git stash
    git reset --hard
    git fetch origin +refs/heads/${branch}:refs/remotes/origin/${branch}
    git remote set-branches origin ${branch} ${branch}*
    git pull origin ${branch}
    git pull origin ${branch}-${branchSuffix}
    cd ..
else
    git clone --branch ${branch} --single-branch ${repository} ./${folder}
    cd ${folder}
    git branch ${branch}-${branchSuffix}
    git checkout ${branch}-${branchSuffix}
    cd ..
fi
