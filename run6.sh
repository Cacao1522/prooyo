#!/bin/sh
# imagemagickで何か画像処理をして，/imgprocにかきこみ，テンプレートマッチング
# 最終テストは，直下のforループを次に変更 for image in $1/final/*.ppm; do
for image in $1/test/*.ppm; do
    echo `basename ${image}`
    
    x=0    	#
    for i in 0 90 180 270; do
        echo $i°
        for template in $1/*.ppm; do
        bname=`basename ${template}`
        name="imgproc/"$bname
        echo $name
        convert -rotate $i% "${template}" "${name}"  # 回転
        rotation=0
        echo $bname:
        if [ $x = 0 ]
        then
            ./matching "${image}" $name $rotation 0.5 cpg 
            x=1
        else
            ./matching "${image}" $name $rotation 0.5 pg 
        fi
        done
        echo ""
    done
done
wait
