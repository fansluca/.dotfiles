#!/bin/bash

# 设置文件夹1和文件夹2的路径
folder1_path="$HOME/Pictures/LiveWallpaper/"
folder2_path="$HOME/Pictures/Background/"

# 清空文件夹2中的所有链接
rm -f $folder2_path/*

# 在文件夹2中创建指向文件夹1中随机文件的链接
readarray -t files < <(find "$folder1_path" -type f)
for ((i = 0; i < 8; i++)); do
	random_file=${files[RANDOM % ${#files[@]}]}
	ln -s "$random_file" "$folder2_path/paper_$i"
done
