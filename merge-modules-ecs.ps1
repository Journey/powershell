param([int]$type=$(throw "Choose type: 0:All 1:Definition 2:Estimation 3:Simulation"))
echo $type

echo "=============set path============"
$prefixSource=(Split-Path $pwd.path -parent)+"\";
$prefixTarget=$pwd.path+"\";
$source;
$sourceUtil = $prefixSource +"\utils";
$target;
$targetUtil;
$typeDir;

#set source/target paths
switch($type){
	1 {$typeDir="definition"}
	2 {$typeDir="estimation"}
	3 {$typeDir="simulation"}
	Default {}
}

$source=$prefixSource + $typeDir;
$target=$prefixTarget + $typeDir + "\src\main\" + $typeDir;
$targetUtil = $prefixTarget + $typeDir + "\src\main\utils";
$sourceCompressed=$source+"\Component-preload.js";
$targetCompressed=$prefixTarget + $typeDir + "\target\"+$typeDir+"\Component-preload.js"

echo "source:$source";
echo "target source:$target";
echo "target uitl:$targetUtil";
echo "source preload: $sourceCompressed";
echo "target preload: $targetCompressed";

#remove
echo "========clean target directory begin =========="
if(Test-Path $target){
	Remove-Item $target -Force -Recurse
}
echo "Deleted:"+@$target;

if(Test-Path $targetUtil){
	Remove-Item $targetUtil -Force -Recurse
	echo "Deleted:"+@$targetUitl;
}

echo "=======clean target directory end  ======="

#copy from source to target
robocopy $source $target /MIR
echo "copy $source done"
robocopy $sourceUtil $targetUtil /MIR
echo "copy $sourceUtil done"

cd $prefixTarget$typeDir

#mvn begin
echo "=============maven work======================"
mvn clean compile
echo "compress done"

#copy compressed file to hana
echo "target compressed: $targetCompressed"
copy-item $targetCompressed $sourceCompressed
echo "copied from $targetCompressed to $sourceCompressed";
echo "copied to the hana, please active it"


#clean source
echo "===============clean source========="
mvn clean
echo "delted target"
Remove-Item -Recurse -Force $targetUtil
echo "deleted $targetUtil"
Remove-Item -Recurse -Force $target
echo "deleted $target"

echo "please active hana content $sourceCompressed"

cd ..\



