#!/usr/bin/awk -f

BEGIN { FS = "\n"; RS = "" }

# Common shell symbols to HTML
{
	# Two backslashes for nawk(1) and OpenBSD awk(1)
	gsub(/\&/,"\\&amp;")
	gsub(/</,"\\&lt;")
	gsub(/>/,"\\&gt;")
}

# h1, h2, h3, h4, h5, h6
/^[\t ]*:/ {
	match($0,":+")
	cnt = RLENGTH
	gsub(/^[\t ]*:+[\t ]*|[\t ]*:+[\t ]*$/,"")
	# length($0) would also work
	if (cnt <= 6 && $0 != "") {
		printf("<h%s>%s</h%s>\n", cnt, $0, cnt)
	}
	next
}

# Paragraph
/^[A-Za-z0-9_]+/ {
	printf("<p>%s</p>\n\n", $0)
	next
}

# Code
/^====+/ {
	if (NF > 2 && $NF ~ /====+/) {
		gsub(/^[\t ]*====+[\t ]*\n|\n[\t ]*====+[\t ]*$/,"")
		printf("<pre><code>")
		for (c=1; c<NF; c++) {
			gsub(/^ +$/,"",$c)
			printf("%s\n", $c)
		}
		# Solve "space" bug! Less crado (gsub).
		gsub(/^ +/,"",$NF)
		printf("%s</code></pre>\n", $NF)
	}
	next
}

# List
/^[\t ]*\* +/ {
	printf("<ul>\n")
	for (l=1; l<=NF; l++) {
		gsub(/^[\t ]*/,"",$l)
		if ($l ~ /\* +/) {
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
			# RSTART can be replaced by 1, because we removed useless tabs/spaces
			num = substr($u,RSTART,RLENGTH)
			url = substr($u,RSTART+RLENGTH+1)
			if (length(url) >= 60) {
				printf("\t<li>%s <a href=\"%s\">%.60s...</a></li>\n", num, url, url)
			} else {
				printf("\t<li>%s <a href=\"%s\">%s</a></li>\n", num, url, url)
			}
		}
	}
	printf("</ul>\n")
	next
}
