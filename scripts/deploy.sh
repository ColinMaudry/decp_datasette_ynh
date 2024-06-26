#!/bin/bash

#ssh yuno_root 'yunohost app remove decp-datasette'
ssh yuno_root 'yunohost app remove decp-datasette__2'

for branch in main develop
do
	hash=`curl -sL https://github.com/ColinMaudry/decp.info/archive/refs/heads/$branch.zip | sha256sum`
	git checkout $branch
	sed -i -E "s/(SOURCE_SUM=)[a-f0-9]+/\1${hash:0:64}/" conf/app.src
	git commit -am "Updated hash"
	git push origin $branch

done

#ssh yuno_root 'yunohost app install -f https://github.com/ColinMaudry/decp_datasette_ynh/tree/main --args "domain=decp.info&path=/&is_public=true"'
ssh yuno_root 'yunohost app install -f https://github.com/ColinMaudry/decp_datasette_ynh/tree/develop --args "domain=test.decp.info&path=/&is_public=true"'


