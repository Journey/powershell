$DebugPreference="Inquire"

function test{
	Write-Debug "debug info 1"
	1+2
	Write-Debug "debug info 2"
}

function test-single-step{
	Set-PSDebug -step
	1+2
	2+3
}
test-single-step
#test