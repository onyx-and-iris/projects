Set-PSReadLineOption -Colors @{
#"ContinuationPrompt" =     [ConsoleColor]:: White
#"Emphasis" =     [ConsoleColor]:: White    
#"Error" =     [ConsoleColor]:: White
#"Selection" =     [ConsoleColor]:: White
#"Default" =     [ConsoleColor]:: White
#"Comment" =     [ConsoleColor]:: White
#"Keyword" =     [ConsoleColor]:: White
#"String" =     [ConsoleColor]:: White
#"Operator" =     [ConsoleColor]:: White
#"Variable" =     [ConsoleColor]:: White
"Command" =     [ConsoleColor]:: Red
#"Parameter" =     [ConsoleColor]:: White
#"Type" =     [ConsoleColor]:: White
#"Number" =     [ConsoleColor]:: White
#"Member" =     [ConsoleColor]:: White
}

function buildc {
 param( [switch]$d )
 # get cur dir name
 $name = pwd | Select-Object | %{$_.ProviderPath.Split("\")[-1]}

 if ($d) {
    gcc -Wall -std=c11 -DDEBUG=TRUE $name.c $name.h -o "$name.exe"
 } else {
    gcc -Wall -std=c11 $name.c $name.h -o "$name.exe"
 }
}

function venv_make {
	$input = Read-Host 'Name?'
	$venv = "venv_$input"

	python -m venv "$venv"
	$activate = ".\$venv\Scripts\activate.ps1"
	Invoke-Expression $activate

	python -m pip install --upgrade pip setuptools wheel
}
