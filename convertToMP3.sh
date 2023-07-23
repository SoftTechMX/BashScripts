#!/bin/sh

# VARIABLES GLOBALES
MUSIC_DIRECTORY="/Peliculas/Musica"
DELETE_ORIGINALS="y"
RECURSIVELY="y"
EXT="webm"

convertAllToMP3()
{
	# CONVERTIMOS TODOS LOS VIDEOS A MP3 EN EL DIRECTORIO RAIZ
	for file in *.$EXT; do

		# VALIDAMOS SI ES UN ARCHIVO PARA USAR FFMPEG
		if [ -f "$file" ]; then
			echo "Converting to MP3 ... $file"
			newFileName=$(echo "$file" | cut -f 1 -d '.')
			ffmpeg -i "$file" "$newFileName.mp3" 2>/dev/null
			chmod 660 "$newFileName.mp3"
			# SI ESTA MARCADA LA OPCION DE ELIMINAR LOS ARCHIVOS ORIGINALES
			if [ $DELETE_ORIGINALS = "y" ]; then
				echo "Deleting ............ $file"
				rm "$file"
			fi
		fi
	done
}

printOptions()
{
	echo "Options"
	# echo "Write the full path to the directory where the program is to be executed: "
	# read MUSIC_DIRECTORY

	# echo "Run recursively on subfolders ? [Y/n]"
	# read RECURSIVELY

	# echo "you want to delete the original files after converting them to MP3 ? [Y/n]"
	# read DELETE_ORIGINALS

	# echo "File extension: [webm]"
	# read EXT
}

printBanner()
{
	echo "Banner"
	# cat << "EOF"
	# EOF
}

# CAMBIAMOS AL DIRECTORIO DONDE ESTAN LAS CARPETAS CON CANCIONES
cd "${MUSIC_DIRECTORY}"

printBanner

# CONVERTIMOS TODOS LOS FICHEROS DE AUDIO A MP3 EN EL DIRECTORIO INDICADO POR EL USUARIO
convertAllToMP3

# VAMOS A CONVERTIR LOS VIDEOS O AUDIOS A MP3 EN LOS SUBDIRECTORIOS
for directory in *; do
	# VALIDAMOS SI ES UN DIERCTORIO
	if [ -d "$directory" ]; then
		cd "$directory"
		convertAllToMP3
		cd ".."
	fi
done
