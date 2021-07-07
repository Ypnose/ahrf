ahrf - [a]scii (or [a]wk) [h]uman [r]eadable [f]ile
---------------------------------------------------

ahrf is an `awk` script designed to interpret a simple and straightforward
ASCII file format. I wrote it to share my personal documentation, which is
written in plain text files. They can be exported to HTML.  
The main goal was... readability.

* One requirement: `awk`
* Supporting many `awk` variants (`nawk`, `mawk`, `gawk` or OpenBSD `awk`) (cf
"[Compatibility](https://github.com/Ypnose/ahrf#compatibility)")
* Simple syntax
* Easy to use / remember / extend
* Designed to work with [wswsh](https://github.com/Ypnose/Wswsh)
* File format can be parsed by almost everything: `sed`, `sh`, `python` or `C`

Syntax
------

#### Headings: `<h1>` to `<h6>`

```
: My important page title :
```

```
<h1>My important page title</h1>
```

```
:: This is the category title ::
```

```
<h2>This is the category title</h2>
```

and so on...

```
::: ::: for <h3></h3>
:::: :::: for <h4></h4>
::::: ::::: for <h5></h5>
:::::: :::::: for <h6></h6>
```

It's possible to define a heading, without the second `:::` field (but it
would be less readable):

```
::: My title without the second field
```

#### Paragraph: `<p></p>`

You just need to put your paragraph inside the file. Nothing else is required:

```
DTLS memory leak from zero-length fragments (CVE-2014-3507)
OpenSSL DTLS anonymous EC(DH) denial of service (CVE-2014-3510)
Race condition in ssl_parse_serverhello_tlsext (CVE-2014-3509)
OpenSSL TLS protocol downgrade attack (CVE-2014-3511)
```
```
<p>DTLS memory leak from zero-length fragments (CVE-2014-3507)
OpenSSL DTLS anonymous EC(DH) denial of service (CVE-2014-3510)
Race condition in ssl_parse_serverhello_tlsext (CVE-2014-3509)
OpenSSL TLS protocol downgrade attack (CVE-2014-3511)</p>
```

Line breaks are supported. You just need to add one or more "ghost" space(s)
at the end of the line:

```
This could be exploited in a Denial Of Service attack.▉
This issue affects OpenSSL 1.0.1 server implementations for both SSL/TLS
and DTLS regardless of whether SRTP is used or configured.▉
Reported by LibreSSL project.
```
```
<p>This could be exploited in a Denial Of Service attack.<br>
This issue affects OpenSSL 1.0.1 server implementations for both SSL/TLS
and DTLS regardless of whether SRTP is used or configured.<br>
Reported by LibreSSL project.</p>
```

Paragraphs can start by:

* `0-9`: From `0` to `9`
* `A-Z`: All letters uppercase
* `a-z`: All letters lowercase
* `_`, `(`, `"`, <code>`</code>

#### Inline Code: `<code></code>`

Code inside a paragraph is surrounded by 2 <code>`</code>.

```
There are so many shells, it becomes hard to choose what you want when
you are a novice.  
``bash`` (very common), ``dash``, ``sh``, ``pdksh`` or even ``tcsh``.
```

```
<p>There are so many shells, it becomes hard to choose what you want when
you are a novice.<br>
<code>bash</code> (very common), <code>dash</code>, <code>sh</code>, <code>pdksh</code> or even <code>tcsh</code>.</p>
 ```

#### Code block: `<pre><code></code></pre>`

Code blocks must start by 4 `=` at least.

```
====
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda5        12G  2.5G  8.6G  23% /
dev             3.9G     0  3.9G   0% /dev
run             4.0G  592K  3.9G   1% /run
tmpfs           4.0G     0  4.0G   0% /dev/shm
====
```

```
<pre><code>Filesystem      Size  Used Avail Use% Mounted on
/dev/sda5        12G  2.5G  8.6G  23% /
dev             3.9G     0  3.9G   0% /dev
run             4.0G  592K  3.9G   1% /run
tmpfs           4.0G     0  4.0G   0% /dev/shm</code></pre>
```

```
=======
ls /usr/local/etc/rc.d/
=======
```

```
<pre><code>ls /usr/local/etc/rc.d/</code></pre>
```

#### Unordered list: `<ul><li></li></ul>`

You need to add one or more space(s) after `*`. If you omit that, the
item(s) will be ignored.

```
* Eat cooked meat
* Buy french bread
* Peel potatoes
* Drink beers
```

```
<ul>
	<li>Eat cooked meat</li>
	<li>Buy french bread</li>
	<li>Peel potatoes</li>
	<li>Drink beers</li>
</ul>
```

```
*    Homemade sausage
*  Apple pie
*Be fast
*         Don't be in a hurry
```

```
<ul>
	<li>Homemade sausage</li>
	<li>Apple pie</li>
	<li>Don't be in a hurry</li>
</ul>
```

#### Page links: `<ul><a></a></ul>`

The "list" has to be started by `[0]` or `[1]`. If not, it won't be matched.

```
[0] https://github.com/
[1] http://netbsd.org/
[2] http://ywstd.fr/
[666] http://www.libressl.org/
```

```
<ul>
	<li>[0] <a href="https://github.com/">https://github.com/</a></li>
	<li>[1] <a href="http://netbsd.org/">http://netbsd.org/</a></li>
	<li>[2] <a href="http://ywstd.fr/">http://ywstd.fr/</a></li>
	<li>[666] <a href="http://www.libressl.org/">http://www.libressl.org/</a></li>
</ul>
```

#### Comments

There is no specific regex for the comments. If the line doesn't "satisfy"
the above specs, it'll be just ignored. However, starting comments by `#`
is perfect. The readers will be able to see them, in less than 0,25 ms
(yes, many configuration files use `#`).

#### Common shell symbols

To avoid invalid HTML code, the symbols `>`, `<` and `&` are automatically
replaced by their HTML counterparts.


The valid ouput can be found within the files `*.outvalid` inside the
directory `test`.
It's a __VERY__ good idea to check those results to understand how `ahrf`
behaves.

Regressions?
------------

To prevent introducing regressions when regexes are reworked, improved or
expanded, a `sh` script was written to check and compare `ahrf` output. It's
called `verify_regr.sh`. It can be launched via `your_shell verify_regr` or
`make check` for the lazy men. `make clean` deletes the invalid files from
the last checking. __I strongly advise you to run it for every changes!__

Compatibility
-------------

The following `awk` variants were validated using the regressions test (no
issues triggered).

The versions are printed here:

* `nawk` - `Dec 20, 2012`

* `mawk` (some [problems](https://github.com/Ypnose/ahrf/issues/1)
before `20141027`) - `mawk 1.3.4 20141027` & `mawk-1.3.4-20141206`

* OpenBSD `nawk` - `awk version 20110810`

* [lok](https://github.com/dimkr/lok) (Linux OpenBSD port from
[@dimkr](https://github.com/dimkr)) - `843382e`

* [fatbase awk](http://git.2f30.org/fatbase/) (Another portable
OpenBSD tools from [2f30](http://www.2f30.org/) folks)

* NetBSD 7.0_BETA `awk` - `awk version 20121220` (thanks to [@justincormack](https://github.com/justincormack))

* `gawk` - `GNU Awk 4.1.1`

* OSX `awk` (probably a `nawk`), but I don't have the exact version number.
However, I do not plan to test this "variant" for every new changes.

Notes
-----

I used `nawk` when I wrote this script. It can be found
[here](http://www.cs.princeton.edu/~bwk/btl.mirror/).

`make all` (or simply `make`) will launch the tests for every variants
specified in `AWKV`.

This script wasn't created to mimic or replace `markdown` syntax. Therefore,
I do not ask or force anybody to adopt it. I want to write my own documentation
or cheatsheets using an easy "system".  
`markdown` can be very frustrating when you use a lot of preformatted text
or lists and the result is sometimes totally broken and wrong. For example,
when I wrote that `README.md`, I encountered many times malformed output or
bad matches.  
I'm not even talking about the dozens of differents variants /
implementations... And do not tell me I don't know what I'm talking about
because I "played" thousands of times with `markdown`.

Issues
------

Maybe. I'm not enough confident to write a bugless script. Report them!
If you notice something wrong, try to provide me an ascii file with your
lines. I'll be able to work on/debug it.

Copyright
---------

Code created by Ypnose, under BSD (3-Clause) License  
Thanks to Alexander for serving me as a guinea pig.
