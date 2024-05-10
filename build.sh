dirName="Payload"
appName="BitClient.app"

cd /Users/alan/Desktop
cp -r /Users/alan/Library/Developer/Xcode/DerivedData/BitClient-glnmcbizdoabayenkmalinrhnxby/Build/Products/Release-iphoneos/$appName /Users/alan/Desktop/$appName
mkdir $dirName
cp -r ./$appName ./$dirName/$appName
zip -r BitClient.ipa $dirName