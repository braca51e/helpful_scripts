dataset=$1

if [[ ! ($dataset == "HorseSeg" || $dataset == "DogSeg") ]]
then
	echo Invalid dataset
	exit
fi

#for synset in `find images/$dataset/ -name n* -type d | xargs -IX basename X`
for synset in `find annotations/DogSeg_img/ -name n* -type d | xargs -IX basename X`
do
	for mask in annotations/DogSeg_img/$synset/*.JPEG; do
	    rename=$(echo "$mask" | sed 's/.*\(\(n[0-9]\{1,\}\)_[0-9]\{1,\}\).*/\2\/\1/' | sed 's/.*[/]//').png
	    #mv $mask $rename
		mkdir -p annotations/DogSeg_Ann2/$synset
		mv annotations/DogSeg_Ann/$synset/$rename annotations/DogSeg_Ann2/$synset/$rename
		echo $mask $rename
		#$rename
	done
	echo $synset
done

#find annotations/DogSeg_Ann/ -empty -type d -delete

#for synset in `find annotations/DogSeg_Ann/ -name n* -type d | xargs -IX basename X`
##for synset in `find annotations/test/ -name n* -type d | xargs -IX basename X`
#do
#	for mask in annotations/DogSeg_Ann/$synset/*.png; do
#	    rename=$(echo "$mask" | sed 's/.*\(\(n[0-9]\{1,\}\)_[0-9]\{1,\}\).*/\2\/\1/' | sed 's/.*[/]//').JPEG
#		mkdir -p annotations/DogSeg_Img/$synset
#		mv images/$dataset/$synset/$rename annotations/DogSeg_Img/$synset/$rename
#		echo $mask $rename
#		#$rename
#	done
#	echo $synset
#done


