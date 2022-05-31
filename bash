#!/usr/bin/env -S bash --

# See the Python original for comments.

lcs ()
{
	a="$1"
	b="$2"
	ll=0
	lia=-1
	lib=-1
	reset_r2 ()
	{
		r2=()
		local ia
		for (( ia = 0 ; ia < ${#a} ; ia++ )) ; do
			r2+=( 0 )
		done
	}
	reset_r2
	for (( ib = 0 ; ib < ${#b} ; ib++ )) ; do
		r1=( "${r2[@]}" )
		reset_r2
		for (( ia = 0 ; ia < ${#a} ; ia++ )) ; do
			if [[ ${a:ia:1} == ${b:ib:1} ]] ; then
				if (( ib == 0 )) ; then
					r2[$ia]=1
				else
					r2[$ia]=$(( ${r1[$(( ia - 1 ))]} + 1 ))
				fi
				if (( ${r2[$ia]} > ll )) ; then
					lia=$ia
					lib=$ib
					ll=${r2[$ia]}
				fi
			fi
		done
	done
	lia=$(( lia - ll + 1 ))
	lib=$(( lib - ll + 1 ))
	s0='                                                                '
	s1='^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
	printf '%s\n%s%s\n' "$a" "${s0:0:lia}" "${s1:0:ll}"
	printf '%s\n%s%s\n' "$b" "${s0:0:lib}" "${s1:0:ll}"
}

lcs 'aaa hi aaa' \
    'bbb hi bbb'

lcs 'ccc xyz ccc' \
    'tuvwxyz'

lcs '..xyz' \
    '..abcxyz'

lcs 'abchelloabc' \
    'xyzhelloxyz'

lcs 'the more things change' \
    'the more things change'
