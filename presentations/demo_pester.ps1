#
# Function should multiply the argument by 2
#
# - numbers should be calculated
# - strings should be duplicated
# - arrays should be duplicated
#
function TimesTwo($value)
{
    return $value * 2
}

Describe "TimesTwo" {
    Context "Numbers" {
        It 'Multiplies numbers properly' {
            TimesTwo 2 | Should Be 4
        }
    }


    Context "Strings" {
        It 'Multiples strings properly' {
            TimesTwo "Foo" | Should BeExactly 'FooFoo'
        }
    }

    Context "Arrays" {
        It "Multiplies arrays properly" {
            $array = 1..2
            $result = TimesTwo $array

            $result.Count | Should Be 4
            $result[0] | Should Be 1
            $result[1] | Should Be 2
            $result[2] | Should Be 1
            $result[3] | Should Be 2
        }
    }
}