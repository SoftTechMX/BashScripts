#! /bin/sh

configurePermission()
{
    for file in *; do

        sudo chgrp compartido "$file"

        if [ -f "$file" ]; then
            echo "File ........ $file"
            sudo chmod 660 "$file"
        fi

        if [ -d "$file" ]; then
            echo "Directory ... $file"
            sudo chmod 770 "$file"
            cd "$file"
            configurePermission
            cd ..
        fi

    done
}

cd "/Peliculas"
configurePermission
