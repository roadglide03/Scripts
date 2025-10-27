find ~ -type f|while read f;do b=${f##*/};mv "$f" "${f%/*}/${b//[^[:alnum:].]}";done
#for f in *;do mv "$f" "${f//[^0-9A-Za-z.]}";done
#brew install rename;find ~ -type f -exec rename 's/[^0-9A-Za-z.\/]/-/g;s/-+/-/g' {} \; rename -z *
