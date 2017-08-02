# Remote git repo
SOURCE='ssh://git@github.com/tonjoo/repo'
# Local git bare repo to store source code
LOCAL_REPO='/path/to/local/git/repo'
# Target deploy folder
TARGET_DEPLOY='/path/to/target/deploy'

function init_repo() 
{
        if [ ! -f config ] ; then
                git init --bare
                git config remote.origin.fetch 'refs/heads/*:refs/heads/*'
                git remote set-url origin $SOURCE
        fi
}

function deploy() 
{
        if [ ! -d $TARGET_DEPLOY ]; then
                mkdir $TARGET_DEPLOY
        fi

        git fetch
        git --work-tree=$TARGET_DEPLOY --git-dir=$LOCAL_REPO checkout master -f
}

if [ ! -d $LOCAL_REPO ]  ; then
        mkdir $LOCAL_REPO
fi

cd $LOCAL_REPO
init_repo
deploy
# add chmod or chown
# chmod -R 775 $TARGET_DEPLOY
# chown -R www-data:www-data $TARGET_DEPLOY