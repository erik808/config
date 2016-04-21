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


define prntComplex2D
  if $argc != 3
  	help prntComplex2D
  else
	set $ld = $arg0.rows()	
	set $j = 0
	while ($j < $arg2)
	  set $i = 0
	  while ($i < $arg1)
		p $arg0[$i+$j*$ld]._M_value
		set $i = $i + 1
	  end
	  set $j = $j + 1
	end
  end							
end

document prntComplex2D
Print elements of a Complex2D object
Usage: prntComplex2D <array> <rows> <cols>
end
