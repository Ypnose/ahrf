#!/usr/bin/awk -f
# Script by Ypnose - http://ywstd.fr

BEGIN { FS = "\n"; RS = "" }

{
	# Common shell symbols to HTML
	# Two backslashes for nawk(1) and OpenBSD awk(1)
	gsub(/\&/,"\\&amp;")
	gsub(/</,"\\&lt;")
	gsub(/>/,"\\&gt;")
}

# h1, h2, h3, h4, h5, h6
/^[\t ]*:/ {
	# Count ':' and match the valid "level"
	match($0,":+")
	cnt = RLENGTH
	gsub(/^[\t ]*:+[\t ]*|[\t ]*:+[\t ]*$/,"")
	# Create the anchor
	anc = tolower($0)
	gsub(/ +/,"-",anc)
	# length($0) would also work
	if (cnt <= 6 && $0 != "")
		printf("<h%d id=\"%s\">%s</h%d>\n", cnt, anc, $0, cnt)
	next
}

# Paragraph
/^[A-Za-z0-9_("`]+/ {
	printf("<p>")
	for (p=1; p<=NF; p++) {
		# Line break
		gsub(/ +$/,"<br>\n",$p)
		x = split($p,word," ")
		for (w=1; w<=x; w++) {
			if (word[w] ~ /``/) {
				split(word[w],code,"``")
				printf("%s<code>%s</code>%s", code[1], code[2], code[3])
			}
			else
				printf("%s", word[w])
			# If EOL is not reached, add a space
			if (w != x)
				printf(" ")
		}
		# If it's the last paragraph line, close the paragraph
		if (p == NF)
			printf("</p>")
		printf("\n")
	}
	next
}

# Code
/^====+/ {
	if (NF > 2 && $NF ~ /====+/) {
		gsub(/^====+[\t ]*\n|\n[\t ]*====+$/,"")
		printf("<pre><code>")
		for (c=1; c<NF; c++) {
			gsub(/^ +$/,"",$c)
			printf("%s\n", $c)
		}
		printf("%s</code></pre>\n", $NF)
	}
	next
}

# Tables
/^%%%%+/ {
	if (NF > 2 && $NF ~ /%%%%+/) {
		gsub(/^%%%%+[\t ]*\n|\n[\t ]*%%%%+$/,"")
		printf("<table>\n")
		for (t=1; t<=NF; t++) {
			printf("\t<tr>\n")
			y = split($t,column,"%%%")
			for (c=1; c<=y; c++) {
				gsub(/^[\t ]+|[\t ]+$/,"",column[c])
				printf("\t<td>%s</td>\n", column[c])
			}
			printf("\t</tr>\n")
		}
		printf("</table>\n")
	}
}

# List
/^[\t ]*\* +/ {
	printf("<ul>\n")
	for (l=1; l<=NF; l++) {
		gsub(/^[\t ]*/,"",$l)
		if ($l ~ /\* +/) {
			# Only match the text
			match($l,"\\* +")
			str = substr($l,RSTART+RLENGTH)
			printf("\t<li>%s</li>\n", str)
		}
	}
	printf("</ul>\n")
	next
}

# End links
/^[\t ]*\[[01]/ {
	printf("<ul>\n")
	for (u=1; u<=NF; u++) {
		gsub(/^[\t ]*/,"",$u)
		if (match($u,"\\[[0-9]+\\]")) {
			# RSTART can be replaced by 1, because we already removed
			# useless tabs and/or spaces
			num = substr($u,RSTART,RLENGTH)
			url = substr($u,RSTART+RLENGTH+1)
			# Do not print the entire link if chars > 100
			if (length(url) > 100)
				printf("\t<li>%s <a href=\"%s\">%.100s…</a></li>\n", num, url, url)
			else
				printf("\t<li>%s <a href=\"%s\">%s</a></li>\n", num, url, url)
		}
	}
	printf("</ul>\n")
	next
}
