BeforeAll {
    . .\voicemeeter.ps1
    Login
}

Describe 'Macrobutton Tests' {
    . .\voicemeeter.ps1
    Context 'mode = State' {
        It 'Should set macrobutton[0] State to 1' {
            MB_Set -ID 0 -SET 1 -MODE 1
            MB_Get -ID 0 -MODE 1 | Should -Be 1
        }

        It 'Should set macrobutton[0] State to 0' {
            MB_Set -ID 0 -SET 0 -MODE 1
            MB_Get -ID 0 -MODE 1 | Should -Be 0
        }

        It 'Should set macrobutton[1] State to 1' {
            MB_Set -ID 1 -SET 1 -MODE 1
            MB_Get -ID 1 -MODE 1 | Should -Be 1
        }

        It 'Should set macrobutton[1] State to 0' {
            MB_Set -ID 1 -SET 0 -MODE 1
            MB_Get -ID 1 -MODE 1 | Should -Be 0
        }

        It 'Should set macrobutton[2] State to 1' {
            MB_Set -ID 2 -SET 1 -MODE 1
            MB_Get -ID 2 -MODE 1 | Should -Be 1
        }

        It 'Should set macrobutton[2] State to 0' {
            MB_Set -ID 2 -SET 0 -MODE 1
            MB_Get -ID 2 -MODE 1 | Should -Be 0
        }
    }

    Context 'mode = StateOnly' {
        It 'Should set macrobutton[0] StateOnly to 1' {
            MB_Set -ID 0 -SET 1 -MODE 2
            MB_Get -ID 0 -MODE 2 | Should -Be 1
        }

        It 'Should set macrobutton[0] StateOnly to 0' {
            MB_Set -ID 0 -SET 0 -MODE 2
            MB_Get -ID 0 -MODE 2 | Should -Be 0
        }

        It 'Should set macrobutton[1] StateOnly to 1' {
            MB_Set -ID 1 -SET 1 -MODE 2
            MB_Get -ID 1 -MODE 2 | Should -Be 1
        }

        It 'Should set macrobutton[1] StateOnly to 0' {
            MB_Set -ID 1 -SET 0 -MODE 2
            MB_Get -ID 1 -MODE 2 | Should -Be 0
        }

        It 'Should set macrobutton[2] StateOnly to 1' {
            MB_Set -ID 2 -SET 1 -MODE 2
            MB_Get -ID 2 -MODE 2 | Should -Be 1
        }

        It 'Should set macrobutton[2] StateOnly to 0' {
            MB_Set -ID 2 -SET 0 -MODE 2
            MB_Get -ID 2 -MODE 2 | Should -Be 0
        }
    }

    Context 'mode = Trigger' {
        It 'Should set macrobutton[0] Trigger to 1' {
            MB_Set -ID 0 -SET 1 -MODE 3
            MB_Get -ID 0 -MODE 3 | Should -Be 1
        }

        It 'Should set macrobutton[0] Trigger to 0' {
            MB_Set -ID 0 -SET 0 -MODE 3
            MB_Get -ID 0 -MODE 3 | Should -Be 0
        }

        It 'Should set macrobutton[1] Trigger to 1' {
            MB_Set -ID 1 -SET 1 -MODE 3
            MB_Get -ID 1 -MODE 3 | Should -Be 1
        }

        It 'Should set macrobutton[1] Trigger to 0' {
            MB_Set -ID 1 -SET 0 -MODE 3
            MB_Get -ID 1 -MODE 3 | Should -Be 0
        }

        It 'Should set macrobutton[2] Trigger to 1' {
            MB_Set -ID 2 -SET 1 -MODE 3
            MB_Get -ID 2 -MODE 3 | Should -Be 1
        }

        It 'Should set macrobutton[2] Trigger to 0' {
            MB_Set -ID 2 -SET 0 -MODE 3
            MB_Get -ID 2 -MODE 3 | Should -Be 0
        }
    }
}

AfterAll  {
    . .\voicemeeter.ps1
    Logout
}
