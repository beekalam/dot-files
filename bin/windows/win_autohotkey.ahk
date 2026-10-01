;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AppsKey::LCtrl
^j::
	send, {alt down}{Tab down}{Tab up}{alt up}
Return

#.::
  send, {ctrl down}{F4 down}{F4 up}{ctrl up}
Return

!#RIGHT::
  send, {ctrl down}{pgdn down}{ctrl up}{pgdn up}
Return

!#LEFT::
  send, {ctrl down}{pgup down}{ctrl up}{pgup up}
Return

!#UP::
  send, {ctrl down}{pgup down}{ctrl up}{pgup up}
Return

#LEFT::
	send, {ctrl down}{pgdn dow}{ctrl up}{pgdn up}
Return

#j::
If WinActive("ahk_exe chrome.exe"){
	  send, {ctrl down}{pgdn down}{ctrl up}{pgdn up}
}
Return

#k::
If WinActive("ahk_exe chrome.exe"){
	send, {ctrl down}{pgdn dow}{ctrl up}{pgdn up}
}
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AutoHotkey script to map Caps Lock to Escape when it's pressed on its own and Ctrl when
; used in combination with another key, à la Steve Losh.
; Adapted from one that does something similar with the Ctrl Key on the Vim Tips Wiki 
; https://gist.github.com/sedm0784/4443120
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
g_LastCtrlKeyDownTime := 0
g_AbortSendEsc := false
g_ControlRepeatDetected := false

*CapsLock::
    if (g_ControlRepeatDetected)
    {
        return
    }

    send,{Ctrl down}
    g_LastCtrlKeyDownTime := A_TickCount
    g_AbortSendEsc := false
    g_ControlRepeatDetected := true

    return

*CapsLock Up::
    send,{Ctrl up}
    g_ControlRepeatDetected := false
    if (g_AbortSendEsc)
    {
        return
    }
    current_time := A_TickCount
    time_elapsed := current_time - g_LastCtrlKeyDownTime
    if (time_elapsed <= 250)
    {
        SendInput {Esc}
    }
    return

~*^a::
~*^b::
~*^c::
~*^d::
~*^e::
~*^f::
~*^g::
~*^h::
~*^i::
~*^j::
~*^k::
~*^l::
~*^m::
~*^n::
~*^o::
~*^p::
~*^q::
~*^r::
~*^s::
~*^t::
~*^u::
~*^v::
~*^w::
~*^x::
~*^y::
~*^z::
~*^1::
~*^2::
~*^3::
~*^4::
~*^5::
~*^6::
~*^7::
~*^8::
~*^9::
~*^0::
~*^Space::
~*^Backspace::
~*^Delete::
~*^Insert::
~*^Home::
~*^End::
~*^PgUp::
~*^PgDn::
~*^Tab::
~*^Return::
~*^,::
~*^.::
~*^/::
~*^;::
~*^'::
~*^[::
~*^]::
~*^\::
~*^-::
~*^=::
~*^`::
~*^F1::
~*^F2::
~*^F3::
~*^F4::
~*^F5::
~*^F6::
~*^F7::
~*^F8::
~*^F9::
~*^F10::
~*^F11::
~*^F12::
    g_AbortSendEsc := true
    return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

::uns::using namespace std;
::stdc::{#}include <bits/stdc{+}{+}.h>
::fori::for(size_t i = 0 `; i < n `; i{+}{+}){left 7}
::forj::for(size_t j = 0 `; j < n `; j{+}{+}){left 7}
::fork::for(size_t k = 0 `; k < n `; k{+}{+}){left 7}
::forl::for(size_t l = 0 `; l < n `; l{+}{+}){left 7}
::ull::unsigned long long
::ul::unsigned long
::ui::unsigned int
::/cout:: cout <<
::vi::vector<int>
::vf::vector<float>
::vd::vector<double>
::vs::vector<string>
::vc::vector<char>
::sci::static_cast<int>(
::scf::static_cast<float>(
::scc::static_cast<char>(
::scb::static_cast<bool>(
::pb::push_back(
::inc::{#}include <>{left 1}

::intmain::{#}include <iostream>{Enter}using namespace std;{Enter}int main(void){Enter}{{} {Enter}{Enter}{}}{left 2}
:*b0O:if`t::(){Return}{{}{Return}{}}{left 5}
:*b0O:while`t::(1){Return}{{}{Return}{Return}{}}{left 3}
:*b0O:switch`t::(){Return}{{}{Return}    case{:}{Return}        break{;}{Return}{}}{left 30}
:*b0O:ret`t::urn {;}{left 1}
:*b0O:int`t:: {;}{left 1}
:*b0O:float`t:: {;}{left 1}
:*b0O:double`t:: {;}{left 1}
:*b0O:char`t:: {;}{left 1}
:*b0O:string`t:: ""{;}{left 2}
:*b0O:template`t:: <typename T>{left 1}
:*b0O:class`t:: {Return}{{}{Return}public{:}    {Return}{}}{;}{left 17}
:*b0O:find`t::(.begin(),.end(),){left 17}
:*b0O:cout`t:: << 
:*b0O:cin`t:: >> 
::inccommon::{#}include <iostream>{Return}{#}include <vector>{Return}{#}include <string>{Return}{#}include <algorithm>{Return}{#}include <cstdlib>
::intmain2::{#}include <iostream>{Return}{#}include <vector>{Return}{#}include <string>{Return}{#}include <algorithm>{Return}{#}include <cstdlib>{Return}using namespace std;{Return}class {Return}{{}{Return}public{:}{Return}{}}{;}



:*b0O:cons`t::ole{.}log(){;}{left 2}

::inputt::<input type="text" name="" id="">
::inputr::<input type="radio" name="" id="">
::inputrl::<label><input type="radio" name="" id=""></label>
::inputc::<input type="checkbox" class="" name="" id="">{left 2}
::inputcl::<label><input type="checkbox" name="" id=""></label>
::formg::<form method="GET" action="
::formp::<form method="POST" action="
::btnsubmit::<button type="submit" class=""></button>
::/btn::<button class="btn btn-success"></button>
::/btninfo::<button class="btn btn-info"></button>
::/btndanger::<button class="btn btn-danger"></button>
::/btnprimary::<button class="btn btn-primary"></button>
::divxs12::<div class="col-xs-12">
::divxs4::<div class="col-xs-4">
::imp::{!}important
:*B0:<pre::></pre>{left 6}

::bek::beekalam@gmail.com
::bek2::beekalam2@gmail.com