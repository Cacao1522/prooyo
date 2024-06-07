#!/bin/sh
# imagemagickで何か画像処理をして，/imgprocにかきこみ，テンプレートマッチング
# 最終テストは，直下のforループを次に変更 for image in $1/final/*.ppm; do
for i in 50 100 200; do
    echo $i%
    for image in $1/test/*.ppm; do
        bname=`basename ${image}`
        name="imgproc/"$bname
        x=0    	#
        echo $name
        convert -resize $i% "${image}" "${name}"  # 拡大縮小
        rotation=0
        echo $bname:
        for template in $1/*.ppm; do
        echo `basename ${template}`
        if [ $x = 0 ]
        then
            ./matching $name "${template}" $rotation 0.5 cpg 
            x=1
        else
            ./matching $name "${template}" $rotation 0.5 pg 
        fi
        done
        echo ""
    done
done
wait
