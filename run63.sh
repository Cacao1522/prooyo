#!/bin/sh
# imagemagickで何か画像処理をして，/imgprocにかきこみ，テンプレートマッチング
# 最終テストは，直下のforループを次に変更 for image in $1/final/*.ppm; do
for image in $1/test/*.ppm; do
    bname=`basename ${image}`
    name="imgproc/"$bname
    x=0    	#
    echo $name
    convert "${image}" "${name}"  # 何もしない画像処理

    rotation=0
    echo $bname:
    for i in 50 100 200; do
        echo $i%
        for template in $1/*.ppm; do
            tempbname=`basename ${template}`
            tempname="imgproc/"$tempbname
            convert -resize $i% "${template}" "${tempname}" # 拡⼤縮⼩
            echo $tempbname:
	        if [ $x = 0 ]
	        then
	            ./matching $name "${tempname}" $rotation 0.432 cpg
	            x=1
	        else
	            ./matching $name "${tempname}" $rotation 0.432 pg 
	        fi
        done
        echo ""
    done
done
wait
