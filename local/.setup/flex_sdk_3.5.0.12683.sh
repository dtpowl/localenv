#!/bin/sh

root=../modules/flex_sdk_3.5.0.12683

( cd bin && ls -d ../$root/bin/* | egrep -v '\.(config|exe|bat)$' | xargs -I {} echo 'rm `basename {}`; ln -s {} `basename {}`' | sh )
( cd lib && ls -d ../$root/lib/* | egrep '\.jar$' | xargs -I {} echo 'rm `basename {}`; ln -s {} `basename {}`' | sh )
( ls -d $root/frameworks | xargs -I {} echo 'rm `basename {}`; ln -s {} `basename {}`' | sh )
( ls -d $root/runtimes | xargs -I {} echo 'rm `basename {}`; ln -s {} `basename {}`' | sh )
