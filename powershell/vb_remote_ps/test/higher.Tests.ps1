Describe -Tag 'higher', -TestName 'All Alias Tests' {
    Describe 'Macrobutton Tests' {
        Context 'mode = State' {
            It 'Should set macrobutton[0] State to 1' {
                $button[0].state = 1
                $button[0].state | Should -Be 1
            }

            It 'Should set macrobutton[0] State to 0' {
                $button[0].state = 0
                $button[0].state | Should -Be 0
            }

            It 'Should set macrobutton[1] State to 1' {
                $button[1].state = 1
                $button[1].state | Should -Be 1
            }

            It 'Should set macrobutton[1] State to 0' {
                $button[1].state = 0
                $button[1].state | Should -Be 0
            }

            It 'Should set macrobutton[2] State to 1' {
                $button[2].state = 1
                $button[2].state | Should -Be 1
            }

            It 'Should set macrobutton[2] State to 0' {
                $button[2].state = 0
                $button[2].state | Should -Be 0
            }
        }

        Context 'mode = StateOnly' {
            It 'Should set macrobutton[0] StateOnly to 1' {
                $button[0].stateonly = 1
                $button[0].stateonly | Should -Be 1
            }

            It 'Should set macrobutton[0] StateOnly to 0' {
                $button[0].stateonly = 0
                $button[0].stateonly | Should -Be 0
            }

            It 'Should set macrobutton[1] StateOnly to 1' {
                $button[1].stateonly = 1
                $button[1].stateonly | Should -Be 1
            }

            It 'Should set macrobutton[1] StateOnly to 0' {
                $button[1].stateonly = 0
                $button[1].stateonly | Should -Be 0
            }

            It 'Should set macrobutton[2] StateOnly to 1' {
                $button[2].stateonly = 1
                $button[2].stateonly | Should -Be 1
            }

            It 'Should set macrobutton[2] StateOnly to 0' {
                $button[2].stateonly = 0
                $button[2].stateonly | Should -Be 0
            }
        }

        Context 'mode = Trigger' {
            It 'Should set macrobutton[0] Trigger to 1' {
                $button[0].trigger = 1
                $button[0].trigger | Should -Be 1
            }

            It 'Should set macrobutton[0] Trigger to 0' {
                $button[0].trigger = 0
                $button[0].trigger | Should -Be 0
            }

            It 'Should set macrobutton[1] Trigger to 1' {
                $button[1].trigger = 1
                $button[1].trigger | Should -Be 1
            }

            It 'Should set macrobutton[1] Trigger to 0' {
                $button[1].trigger = 0
                $button[1].trigger | Should -Be 0
            }

            It 'Should set macrobutton[2] Trigger to 1' {
                $button[2].trigger = 1
                $button[2].trigger | Should -Be 1
            }

            It 'Should set macrobutton[2] Trigger to 0' {
                $button[2].trigger = 0
                $button[2].trigger | Should -Be 0
            }
        }
    }

    Describe 'Set and Get Param Float Tests' {
        Context 'Strip[i].Mute' {
            It 'Should set Strip[0].Mute to 1' {
                $strip[0].Mute = 1
                $strip[0].Mute | Should -Be 1
            }

            It 'Should set Strip[0].Mute to 0' {
                $strip[0].Mute = 0
                $strip[0].Mute | Should -Be 0
            }

            It 'Should set Strip[1].Mute to 1' {
                $strip[1].Mute = 1
                $strip[1].Mute | Should -Be 1
            }

            It 'Should set Strip[1].Mute to 0' {
                $strip[1].Mute = 0
                $strip[1].Mute | Should -Be 0
            }

            It 'Should set Strip[2].Mute to 1' {
                $strip[2].Mute = 1
                $strip[2].Mute | Should -Be 1
            }

            It 'Should set Strip[2].Mute to 0' {
                $strip[2].Mute = 0
                $strip[2].Mute | Should -Be 0
            }
        }

        Context 'Strip[i].Solo' {
            It 'Should set Strip[0].Solo to 1' {
                $strip[0].Solo = 1
                $strip[0].Solo | Should -Be 1
            }

            It 'Should set Strip[0].Solo to 0' {
                $strip[0].Solo = 0
                $strip[0].Solo | Should -Be 0
            }

            It 'Should set Strip[1].Solo to 1' {
                $strip[1].Solo = 1
                $strip[1].Solo | Should -Be 1
            }

            It 'Should set Strip[1].Solo to 0' {
                $strip[1].Solo = 0
                $strip[1].Solo | Should -Be 0
            }

            It 'Should set Strip[2].Solo to 1' {
                $strip[2].Solo = 1
                $strip[2].Solo | Should -Be 1
            }

            It 'Should set Strip[2].Solo to 0' {
                $strip[2].Solo = 0
                $strip[2].Solo | Should -Be 0
            }
        }

        Context 'Strip[i].Mono' {
            It 'Should set Strip[0].Mono to 1' {
                $strip[0].Mono = 1
                $strip[0].Mono | Should -Be 1
            }

            It 'Should set Strip[0].Mono to 0' {
                $strip[0].Mono = 0
                $strip[0].Mono | Should -Be 0
            }

            It 'Should set Strip[1].Mono to 1' {
                $strip[1].Mono = 1
                $strip[1].Mono | Should -Be 1
            }

            It 'Should set Strip[1].Mono to 0' {
                $strip[1].Mono = 0
                $strip[1].Mono | Should -Be 0
            }

            It 'Should set Strip[2].Mono to 1' {
                $strip[2].Mono = 1
                $strip[2].Mono | Should -Be 1
            }

            It 'Should set Strip[2].Mono to 0' {
                $strip[2].Mono = 0
                $strip[2].Mono | Should -Be 0
            }
        }
    }
}
