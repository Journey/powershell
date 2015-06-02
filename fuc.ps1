function hello{
	if($args.Count -eq 0){
		"No Arguments";
	} else {
		$args | foreach{"Hello, $_"}
	}
}

function hello-to-sombody($name="default name"){
	return "hello, $name"
}

function strong-type([int]$va1,[int]$va2){
	$va1 - $va2;
}

# 函数可以有一个或多个返回值。

function gbMeasure($amount)
{
    "$amount GB=$($amount) GB"
    "$amount GB=$($amount*1gb/1mb) MB"
    "$amount GB=$($amount*1gb/1kb) KB"
    "$amount GB=$($amount*1gb) B"
}
#return: terminal the func excution, the functions return values - is the values before the return statement
function test-return{
	1+2
	2+3
	return 4
}

#write-host: write to screen, but not as return value
function screen-not-return{
	Write-Host "Try to calculate"
	3.12
	Write-Host "Done"
}

#write-debug
function test-write-debug(){
	$DebugPreference="Continue" #SilentContinue
	Write-Debug "Debug Begin"
	Write-Debug "Debug End"
	$DebugPreference="SilentContinue"

	#从这里开始隐藏所有的错误信息
    $ErrorActionPreference="SilentlyContinue"
    Stop-Process -Name "www.mossfly.com"
    #该进程不存在
 
    #恢复$ErrorActionPreference,错误开始输出
    $ErrorActionPreference="Continue"
}

function look-up-funcs(){
	#look-up - the build-in function
	dir function: | ft -AutoSize
	#look-up function body
	$function:prompt
}

function test-console(){
	Get-Help $host -full
	$host.ui.rawui.CursorPosition
}

# guandaofunction/filter/$_/   
function mark-exe{
	$oldColor = $host.ui.rawui.ForegroundColor;
	$oldColor = "White"

	Foreach($element in $input){
		If($element.name.toLower().endsWith(".exe")){
			$host.ui.Rawui.ForegroundColor = "Red";
		} Else {
			$host.ui.Rawui.ForegroundColor = $oldColor
		}
		$element
	}

	$host.ui.Rawui.ForegroundColor = $oldColor;
}

Filter test-pip{
	# 记录当前控制台的背景色
    $oldcolor = $host.ui.rawui.ForegroundColor
    # 当前的管道元素保存在 $_ 变量中
    # 如果后缀名为 ".exe",
    # 改变背景色为红色:
    If ($_.name.toLower().endsWith(".exe"))
    {
        $host.ui.Rawui.ForegroundColor = "red"
    }
    Else
    {
        # 否则使用之前的背景色
        $host.ui.Rawui.ForegroundColor = $oldcolor
    }
    # 输出当前元素
    $_
    # 最后恢复控制台颜色:
    $host.ui.Rawui.ForegroundColor = $oldcolor
}

Function a-pip-func
{
    begin
    {
        # 记录控制台的背景色
        $oldcolor = $host.ui.rawui.ForegroundColor
    }
    process
    {
        # 当前管道的元素 $_
        # 如果后缀名为 ".exe",
        # 改变背景色为红色:
        If ($_.name.toLower().endsWith(".exe"))
        {
            $host.ui.Rawui.ForegroundColor = "red"
        }
        Else
        {
            # 否则, 使用正常的背景色:
            $host.ui.Rawui.ForegroundColor = $oldcolor
         }
        # 输出当前的背景色
        $_
      }
    end
    {
        # 最后,恢复控制台的背景色:
        $host.ui.Rawui.ForegroundColor = $oldcolor
     }
}






function invoke{
	gbMeasure 1

	$store = gbMeasure 2
	$store.GetType().FullName
	$store[0];

	#call function
	strong-type -va1 3 -va2 4
	hello "journey" "tony"
	hello-to-sombody -name "Journey"

	test-return
	$temp = test-return
	$temp.GetType().FullName
	$temp[0]

	$temp = screen-not-return;
	$temp[0]
	Write-Host "test console------------------------------------------"
	test-console

	dir | mark-exe
}

#invoke
