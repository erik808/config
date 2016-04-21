# MY GDB MACRO'S    SUPER HANDY
#
#                         great job!
#

define prnt2Dfort
  if $argc .NE. 3
  	help prnt2Dfort
  else
	set $j = 1
	while ($j .le. $arg2)
	  set $i = 1
	  while ($i .le. $arg1)
		p $arg0($i,$j)
		set $i = $i + 1
	  end
	  set $j = $j + 1
	end
  end							
end

document prnt2Dfort
Print 2d array in fortran
Usage: prnt2Dfort <array> <rows> <cols>
end
